import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/Product.dart';
import 'package:sqflite_demo/screens/product_add.dart';
import 'package:sqflite_demo/screens/product_detail.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _ProductListState();
  }
}
class _ProductListState extends State {
  DbHelper dbHelper = DbHelper();
  List<Product> products;
  int productCount=0;

  @override
  void initState() { // sayfa acildiginda ilk once ururnleri db den almak lazım
    // uygulama o sayfa acildiginda calisan blogu
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
        backgroundColor: Colors.amberAccent,
      ),
      body:buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){goToProductAdd();},
        child: Icon(Icons.add),
        tooltip: "Yeni ürün ekle",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context,int position){
          return Card(
            color: Colors.pinkAccent,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(backgroundColor:Colors.amberAccent,child: Text("P"),),
              title: Text(this.products[position].name),
              subtitle: Text(this.products[position].description),
              onTap: (){goToDetail(this.products[position]);},
            ),
          );

        });
  }

  void goToProductAdd() async {
    bool result =await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductAdd()));
    if(result != null){// gercekten ekleme yapildiysa
      if(result){
        getProducts();
      }
    }
  }

  void getProducts()async{
    var productsFuture= dbHelper.getProducts();
    productsFuture.then((data){ // data -> List<Product>, ustteki fonks dondugu sey
      setState(() { // degisim yapilan kodlar burada olmali
        this.products=data;
        productCount=data.length;
      });
    });
  }

  void goToDetail(Product product) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product)));
    if(result!=null){
      if(result){
        getProducts();
      }
    }
  }



}