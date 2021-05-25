import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/product.dart';
import 'src/authentication.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) => Authentication(
        loginState: appState.loginState,
        signInWithGoogle: appState.signInWithGoogle,
        signInAnonymously: appState.signInAnonymously,
        signOut: appState.signOut,
      ),
    );
  }
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        print("HEllo");
        _loginState = ApplicationLoginState.loggedIn;

        _productSubscription = FirebaseFirestore.instance
            .collection('products')
            .orderBy('price', descending: false)
            .snapshots()
            .listen((snapshot) {
          _products = [];
          snapshot.docs.forEach((document) {
            _products.add(
              Product(
                docId: document.id,
                imageUrl: document.data()['imageUrl'],
                path: document.data()['path'],
                name: document.data()['name'],
                price: document.data()['price'],
                desc: document.data()['desc'],
                uid: document.data()['userId'],
                created: (document.data()['created'] as Timestamp).toDate() == null ? document.data()['created'].toString() : (document.data()['created'] as Timestamp).toDate().toString(),
                modified: (document.data()['modified'] as Timestamp).toDate()== null ? document.data()['modified'].toString() : (document.data()['modified'] as Timestamp).toDate().toString(),
                likes: document.data()['likes'],
              ),
            );
            FirebaseFirestore.instance.collection('products').doc(document.id).update({
              'docId': document.id,
            });
          });
          notifyListeners();
        });
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        _products = [];
        _productSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  StreamSubscription<QuerySnapshot> _productSubscription;
  List<Product> _products = [];
  List<Product> get products => _products;
  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  void signInWithGoogle(
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signInAnonymously(
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void order(bool check){
    _productSubscription = FirebaseFirestore.instance
        .collection('products')
        .orderBy('price', descending: check)
        .snapshots()
        .listen((snapshot) {
      _products = [];
      snapshot.docs.forEach((document) {
        _products.add(
          Product(
            docId: document.id,
            imageUrl: document.data()['imageUrl'],
            path: document.data()['path'],
            name: document.data()['name'],
            price: document.data()['price'],
            desc: document.data()['desc'],
            uid: document.data()['userId'],
            // created: document.data()['created'].toString(),
            // modified: document.data()['modified'].toString(),
            created: (document.data()['created'] as Timestamp).toDate() == null ? document.data()['created'].toString() : (document.data()['created'] as Timestamp).toDate().toString(),
            modified: (document.data()['modified'] as Timestamp).toDate()== null ? document.data()['modified'].toString() : (document.data()['modified'] as Timestamp).toDate().toString(),
            likes: document.data()['likes'],
          ),
        );
        FirebaseFirestore.instance.collection('products').doc(document.id).update({
          'docId': document.id,
        });
      });
      notifyListeners();
    });
  }
  String url;
  String path;

  Future<DocumentReference> addProducts(String name, String price, String desc, File _image) async {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    await uploadFile(_image);

    if(_image == null)
      url = 'https://handong.edu/site/handong/res/img/logo.png';

    var numPrice = int.parse(price);
    return FirebaseFirestore.instance.collection('products').add({
      'docId': '',
      'imageUrl': url,
      'path': path,
      'name': name,
      'price': numPrice,
      'desc': desc,
      'userId': FirebaseAuth.instance.currentUser.uid,
      'created': FieldValue.serverTimestamp(),
      'modified': FieldValue.serverTimestamp(),
      'likes': [],
    });
  }

  Future<void> editProducts(String docId, String imageUrl, String imagePath, String name, int price, String desc, File _image, var likes)  {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }
    if(imageUrl == null)
      imageUrl = 'https://handong.edu/site/handong/res/img/logo.png';

    FirebaseFirestore.instance.collection('products').doc(docId).update({
      'imageUrl': imageUrl,
      'path': imagePath,
      'name': name,
      'price': price,
      'desc': desc,
      'modified': FieldValue.serverTimestamp(),
      'likes': likes,
    });
    notifyListeners();
  }

  Future uploadFile(File _image) async {
    path = 'productImages/${Path.basename(_image.path)}}';
    await FirebaseStorage.instance
        .ref()
        .child('productImages/${Path.basename(_image.path)}}').putFile(_image);

    url = await FirebaseStorage.instance
        .ref()
        .child('productImages/${Path.basename(_image.path)}}').getDownloadURL();
  }

}
