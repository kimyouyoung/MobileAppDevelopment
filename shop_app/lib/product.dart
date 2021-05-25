import 'package:flutter/cupertino.dart';

class Product{
  Product({@required this.docId, @required this.imageUrl, @required this.path, @required this.name, @required this.price, @required this.desc, @required this.uid, @required this.created, @required this.modified, @required this.likes});
  final String docId;
  final String imageUrl;
  final String path;
  final String name;
  final int price;
  final String desc;
  final String uid;
  final String created;
  final String modified;
  final likes;
}