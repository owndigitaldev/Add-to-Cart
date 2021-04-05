import 'package:add_to_cart/model/app/singleton_model.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  SingletonModel _model;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _model = SingletonModel.shared;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(),
    );
    //untuk mendapatkan data cart, bisa panggil dengan _model.carts
  }
}
