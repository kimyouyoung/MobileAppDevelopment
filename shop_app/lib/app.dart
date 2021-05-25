import 'package:flutter/material.dart';
import 'package:shop_app/login.dart';

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopApp',
      home: LoginPage(),
    );
  }
}