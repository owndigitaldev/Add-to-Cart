import 'package:add_to_cart/common/configs.dart';
import 'package:add_to_cart/data/repo.dart';
import 'package:add_to_cart/model/app/singleton_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

final _repo = new Repo();

class Request {
  _Product product = _Product();
  _Cart cart = _Cart();
  _User user = _User();
}

class _Product {
  Future<http.Response> all() {
    return _repo.product.all();
  }

  Future<http.Response> detail({@required int id}) {
    return _repo.product.detail(id: id);
  }
}

class _Cart {}

class _User {}
