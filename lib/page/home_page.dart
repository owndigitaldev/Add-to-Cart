import 'dart:convert';

import 'package:add_to_cart/common/styles.dart';
import 'package:add_to_cart/data/request.dart';
import 'package:add_to_cart/dialog/exit_dialog.dart';
import 'package:add_to_cart/widget/fab_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:add_to_cart/common/constans.dart';
import 'package:add_to_cart/model/app/singleton_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  SingletonModel _model;
  Request _request;

  List<ProductModel> _carts;
  Future _future;
  List<ProductModel> _products;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _model = SingletonModel.shared;
    _request = new Request();
    _carts = _model.carts;
    _future = _request.product.all();
  }

  Future<bool> _onWillPop() async {
    return await openExitDialog(context) ?? false;
  }

  void _onCardTapped() {
    //ketika item card di tap
  }

  void _add2Cart(ProductModel p) {
    //ketika di add
    setState(() {
      _carts.add(p);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: FabCartWidget(carts: _carts),
        floatingActionButtonLocation: FabCartWidget.location,
      ),
      onWillPop: _onWillPop,
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(kSAppName),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(
                  child: SpinKitHourGlass(
                    color: hPrimary,
                    size: 64.0,
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData) {
                  http.Response res = snapshot.data;
                  if (res.statusCode == 200) {
                    _products = List<ProductModel>.from(jsonDecode(res.body)
                        .map((x) => ProductModel.fromJson(x)));

                    return _data();
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Gagal Memuat Data:\n${snapshot.error}"),
                  );
                }
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _data() {
    final gridCount = MediaQuery.of(context).size.width ~/ 160.0;
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      physics: const ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCount,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.57,
      ),
      itemCount: _products.length,
      itemBuilder: (context, idx) {
        ProductModel p = _products[idx];

        return InkWell(
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 164.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8.0)),
                      image: DecorationImage(
                        image: NetworkImage(p.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    p.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: hPrimary,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "\$ ${p.price}",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () => _add2Cart(p),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: _onCardTapped,
        );
      },
    );
  }
}
