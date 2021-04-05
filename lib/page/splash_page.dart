import 'dart:convert';

import 'package:add_to_cart/common/constans.dart';
import 'package:add_to_cart/data/sp_data.dart';
import 'package:flutter/material.dart';
import 'package:add_to_cart/model/app/singleton_model.dart';
import 'package:add_to_cart/page/home_page.dart';
import 'package:add_to_cart/tool/helper.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  SingletonModel _model;
  Helper _helper;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _model = SingletonModel.shared;
    _helper = new Helper();
    _checkData();
  }

  void _checkData() async {
    String carts =
        await SPData().loadFromSP(kDCarts, SharedDataType.string) ?? "[]";

    print(carts);

    _model.carts = List<ProductModel>.from(
      jsonDecode(carts).map((x) => ProductModel.fromJson(x)),
    );

    await Future.delayed(Duration(seconds: 2));
    _helper.moveToPage(context, page: HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Text(kSAppName),
    );
  }
}
