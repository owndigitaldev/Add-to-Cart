import 'dart:async';

import 'package:add_to_cart/common/configs.dart';
import 'package:add_to_cart/data/api.dart';
import 'package:add_to_cart/data/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:add_to_cart/data/http.dart';
import 'package:dio/dio.dart' as dio;

final _api = new API();

class Repo {
  _Product product = _Product();
  _Cart cart = _Cart();
  _User user = _User();
}

class _Product {
  Future<http.Response> all() async {
    return await Http.get(url: _api.product.add, header: kDHeader());
  }

  Future<http.Response> detail({@required int id}) async {
    return await Http.get(url: _api.product.detail(id), header: kDHeader());
  }
}

class _Cart {}

class _User {}
