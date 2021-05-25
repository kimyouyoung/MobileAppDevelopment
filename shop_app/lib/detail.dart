import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/edit.dart';
import 'package:shop_app/login.dart';
import 'package:shop_app/product.dart';

class DetailPage extends StatefulWidget {
  DetailPage({@required this.product, @required this.price});
  final Product product;
  final int price;

  @override
  _DetailPageState createState() => _DetailPageState(this.product, this.price);
}

class _DetailPageState extends State<DetailPage> {
  Product product;
  int price;
  List likeList;
  bool alreadyLike;
  int count;
  List forCount;

  _DetailPageState(Product product, int price) {
    this.product = product;
    likeList = this.product.likes;
    count = likeList.length;
    likeList.contains(FirebaseAuth.instance.currentUser.uid)
        ? alreadyLike = true
        : alreadyLike = false;
    this.price = price;
  }
  var snackBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FirebaseAuth.instance.currentUser.uid == product.uid
            ? Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child: Text(
                    'Detail',
                  ),
                ),
              )
            : Text('Detail'),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Row(
              children: [
                if (FirebaseAuth.instance.currentUser.uid == product.uid)
                  IconButton(
                    icon: Icon(Icons.create),
                    iconSize: 25.0,
                    disabledColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditPage(
                            product: product,
                            imageUrl: product.imageUrl,
                            path: product.path,
                            name: product.name,
                            price: product.price,
                            desc: product.desc,
                            docId: product.docId),
                      ));
                    },
                  ),
                if (FirebaseAuth.instance.currentUser.uid == product.uid)
                  IconButton(
                    icon: Icon(Icons.delete),
                    iconSize: 25.0,
                    disabledColor: Colors.white,
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('products')
                          .where('name', isEqualTo: product.name)
                          .get()
                          .then((snapshot) {
                        snapshot.docs.first.reference.delete();
                      });
                      FirebaseStorage.instance
                          .ref()
                          .child(product.path)
                          .delete();
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 22 / 18,
                  child: Image.network(product.imageUrl),
                ),
                Container(
                  height: 50.0,
                  padding: EdgeInsets.only(right: 40.0),
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        color: Colors.red,
                        iconSize: 30.0,
                        onPressed: () {
                          List<String> s = [
                            FirebaseAuth.instance.currentUser.uid,
                          ];
                          FirebaseFirestore.instance
                              .collection('products')
                              .doc(product.docId)
                              .get()
                              .then((doc) => {
                                    doc.get('likes').contains(FirebaseAuth
                                            .instance.currentUser.uid)
                                        ? alreadyLike = true
                                        : alreadyLike = false,
                                  });
                          if (!alreadyLike)
                            FirebaseFirestore.instance
                                .collection('products')
                                .doc(product.docId)
                                .update({
                              'likes': FieldValue.arrayUnion(s),
                            });
                          alreadyLike ? count = count : count = count + 1;
                          alreadyLike
                              ? snackBar = SnackBar(
                                  content: Text('You can only do it once!'))
                              : snackBar = SnackBar(content: Text('I LIKE IT'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                      SizedBox(width: 3.0),
                      Text(
                        count == null ? '0' : '$count',
                        style: TextStyle(color: Colors.red, fontSize: 35.0),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 35.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.blue.shade900,
                                  ),
                                  maxLines: 1,
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.monetization_on_outlined,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      price != product.price
                                          ? '$price'
                                          : '${product.price}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue.shade400,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Divider(
                            indent: 35.0,
                            endIndent: 35.0,
                            height: 1.0,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 15.0),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                            child: Text(
                              product.desc,
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ),
                          SizedBox(height: 100.0),
                          Container(
                            padding: EdgeInsets.only(left: 30.0),
                            alignment: AlignmentDirectional.bottomStart,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'creator: ${product.uid}',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                ),
                                SizedBox(height: 5.0),
                                Text('${product.created} Created',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 12.0)),
                                SizedBox(height: 5.0),
                                Text('${product.modified} Modified',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
