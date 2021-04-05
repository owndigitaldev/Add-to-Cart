import 'package:add_to_cart/model/product_model.dart';
export 'package:add_to_cart/model/product_model.dart';

class SingletonModel {
  static final SingletonModel _singleton = SingletonModel._internal();

  factory SingletonModel() {
    return _singleton;
  }

  SingletonModel._internal();

  static SingletonModel get shared {
    return _singleton;
  }

  List<ProductModel> carts;
}
