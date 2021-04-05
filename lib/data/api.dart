final String _baseUrl = "https://fakestoreapi.com/";

class API {
  _Product product = _Product();
  _Cart cart = _Cart();
  _User user = _User();

  final String baseUrl = "https://fakestoreapi.com/";
}

class _Product {
  final all = "${_baseUrl}products";
  String detail(int id) => "$_baseUrl/$id";
  final add = "${_baseUrl}products";
  String update(int id) => "$_baseUrl/$id";
  String delete(int id) => "$_baseUrl/$id";
  final category = "${_baseUrl}products/categories";
}

class _Cart {}

class _User {}
