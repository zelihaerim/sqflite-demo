import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/Product.dart';

class ProductAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductAddState();
  }


}

class _ProductAddState extends State{
  DbHelper dbHelper=DbHelper();
  TextEditingController txtName=TextEditingController();
  TextEditingController txtDescription=TextEditingController();
  TextEditingController txtUnitPrice=TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Urun ekleme sayfası"),
       backgroundColor: Colors.purpleAccent,
     ),
     body: Padding(
       padding: EdgeInsets.all(30.0),
       child: Column(
         children: <Widget>[
           buildNameField(),
           buildDescriptionField(),
           buildUnitPriceField(),
            buildSaveButton()
         ],


       ),
     ) ,
   );
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün adı"),
      controller: txtName,
    );
  }
  buildDescriptionField(){
    return TextField(
      decoration: InputDecoration(labelText: "Ürün aciklamasi"),
      controller: txtDescription,
    );
  }
  buildUnitPriceField(){
    return TextField(
      decoration: InputDecoration(labelText: "Ürün fiyati"),
      controller: txtUnitPrice,
    );
  }

  buildSaveButton() {
    return FlatButton(onPressed: (){
      addProduct();
    }, child: Text("ekle"));
  }

  void addProduct() async {
    var result= await dbHelper.insert(Product(name:txtName.text,description: txtDescription.text,unitPrice:double.tryParse(txtUnitPrice.text)));
    Navigator.pop(context,true);//islem basarili yani true , pop yani bi onceki sayfaya git

  }
}