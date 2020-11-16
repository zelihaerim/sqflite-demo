import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/Product.dart';

class ProductDetail extends StatefulWidget {
  Product
      product; // Bu page in calismasi icin product nesnesine ihtiyac var bunu da disaridan yani geldigi sayfadan alacak.
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options { delete, update }

class _ProductDetailState extends State {
  TextEditingController txtName =
      TextEditingController(); // bu controller lar textfield de degisim olunca guncelleme olabilsin diye var
  TextEditingController txtDescription =
      TextEditingController(); //controllerlar yazi yazdigimiz yerler
  TextEditingController txtUnitPrice = TextEditingController();
  //initstate setstate vs icin
  var dbHelper = DbHelper();
  Product product;
  _ProductDetailState(this.product);
  @override
  void initState() {
    txtName.text = product.name;
    txtDescription.text = product.description;
    txtUnitPrice.text = product.unitPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text("Ürün detayı: ${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess, //parametre verilmesine gerek yok
            // cunku asagidan otomatik oalrak aliyor.
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Sil"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Güncelle"),
              ),
            ],
          ),
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField(),
        ],
      ),
    );
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Product.withId(
            id: product.id,
            name: txtName.text,
            description: txtDescription.text,
            unitPrice: double.tryParse(txtUnitPrice.text)));
        Navigator.pop(context, true);
        break;
      default:
        break;
    }
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün adı"),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün aciklamasi"),
      controller: txtDescription,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün fiyati"),
      controller: txtUnitPrice,
    );
  }
}
