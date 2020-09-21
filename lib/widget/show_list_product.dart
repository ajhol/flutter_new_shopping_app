import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex1/models/product_model..dart';
import 'package:flutter/material.dart';

class ShowListProduct extends StatefulWidget {
  ShowListProduct({Key key}) : super(key: key);

  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  //Field
  List<ProductModel> productModels = List();
  //Method
  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Product');
    await collectionReference.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.documents;
      for (var snapshot in snapshots) {
        print('snapshot = $snapshot');
        print('Name= ${snapshot.data['Name']}');
        ProductModel productModel = ProductModel.fromMap(snapshot.data);
        setState(() {
          productModels.add(productModel);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (BuildContext buildContext, int index) {
        return Text(productModels[index].name);
      },
    ));
  }
}
