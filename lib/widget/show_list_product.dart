import 'package:flutter/material.dart';

class ShowListProduct extends StatefulWidget {
  ShowListProduct({Key key}) : super(key: key);

  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  //Field

  //Method
  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('This is ShowListProduct test'),
    );
  }
}
