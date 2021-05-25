import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/login.dart';
import 'package:shop_app/app.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => ShopApp(),
    ),
  );
}