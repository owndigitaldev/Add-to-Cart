import 'dart:convert';

import 'package:add_to_cart/common/styles.dart';
import 'package:collection/collection.dart';
import 'package:add_to_cart/common/constans.dart';
import 'package:add_to_cart/data/sp_data.dart';
import 'package:add_to_cart/model/app/singleton_model.dart';
import 'package:flutter/material.dart';

class FabCartWidget extends StatefulWidget {
  final List<ProductModel> carts;
  static FloatingActionButtonLocation location =
      FloatingActionButtonLocation.miniEndFloat;

  FabCartWidget({@required this.carts});

  @override
  _FabCartWidgetState createState() => _FabCartWidgetState();
}

class _FabCartWidgetState extends State<FabCartWidget> {
  SingletonModel _model;

  @override
  void initState() {
    super.initState();
    _model = SingletonModel.shared;
  }

  void _handleCarts() {
    if (ListEquality().equals(widget.carts, _model.carts)) {
      _model.carts = widget.carts;
      SPData()
          .saveToSP(kDCarts, SharedDataType.string, jsonEncode(_model.carts));
    }
  }

  void _onTap() {
    //ketika fab di klik
  }

  @override
  Widget build(BuildContext context) {
    _handleCarts();
    return FloatingActionButton(
      tooltip: kSAppName,
      child: _content(),
      backgroundColor: hPrimary,
      onPressed: _onTap,
    );
  }

  Widget _content() {
    return Stack(
      children: [
        Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        Visibility(
          visible: _model.carts.length > 0,
          child: Positioned(
            right: 0,
            top: 0,
            child: new Container(
              padding: EdgeInsets.all(2.0),
              decoration: new BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6.0),
              ),
              constraints: BoxConstraints(
                minWidth: 14.0,
                minHeight: 14.0,
              ),
              child: Text(
                "${_model.carts.length}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
