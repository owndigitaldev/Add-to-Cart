import 'package:add_to_cart/common/configs.dart';
import 'package:add_to_cart/common/constans.dart';
import 'package:add_to_cart/common/styles.dart';
import 'package:add_to_cart/page/splash_page.dart';
import 'package:flutter/material.dart';

class AddToCartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kSAppName,
      theme: tdMain(context),
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: kLDelegates,
      supportedLocales: kLSupports,
    );
  }
}
