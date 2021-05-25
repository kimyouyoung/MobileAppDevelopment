import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          Consumer<ApplicationState>(
              builder: (context, appState, _) => IconButton(
                  icon: Icon(Icons.exit_to_app),
                  iconSize: 25.0,
                  disabledColor: Colors.white,
                  onPressed: () {
                    appState.signOut();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  })),
        ],
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 250.0,
              height: 250.0,
              color: Colors.white,
              child: FirebaseAuth.instance.currentUser.isAnonymous
                  ? Image.network(
                      'https://handong.edu/site/handong/res/img/logo.png')
                  : Image.network(FirebaseAuth.instance.currentUser.photoURL),
            ),
            SizedBox(height: 100.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(FirebaseAuth.instance.currentUser.uid,
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                SizedBox(height: 20.0),
                Divider(
                  indent: 35.0,
                  endIndent: 35.0,
                  height: 1.0,
                  color: Colors.white,
                ),
                SizedBox(height: 20.0),
                Text(
                    FirebaseAuth.instance.currentUser.isAnonymous
                        ? 'Anonymous'
                        : FirebaseAuth.instance.currentUser.email,
                    style: TextStyle(color: Colors.white, fontSize: 15.0)),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
