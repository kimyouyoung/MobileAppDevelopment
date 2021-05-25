import 'package:flutter/material.dart';
import 'package:shop_app/home.dart';

enum ApplicationLoginState {
  loggedOut,
  googleLogin,
  anonymousLogin,
  loggedIn,
  signOut,
}

class Authentication extends StatelessWidget {
  const Authentication({
    @required this.loginState,
    @required this.signInWithGoogle,
    @required this.signInAnonymously,
    @required this.signOut,
  });

  final ApplicationLoginState loginState;

  final void Function(void Function(Exception e) error) signInWithGoogle;
  final void Function(void Function(Exception e) error) signInAnonymously;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 250.0),
                Column(
                  children: <Widget>[
                    Container(
                      height: 90,
                      width: 90,
                      child: Image.asset('assets/shop.png'),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
                SizedBox(height: 130.0),
                Column(
                  children: <Widget>[
                    TextButton(
                      child: Container(
                        width: 290.0,
                        decoration: BoxDecoration(
                            color: Colors.redAccent.shade100,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 55.0,
                              width: 55.0,
                              child: Center(
                                  child: Text('G',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold))),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Container(
                              height: 55.0,
                              width: 100.0,
                              child: Center(
                                  child: Text('GOOGLE',
                                      style: TextStyle(color: Colors.white))),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        signInWithGoogle((e) => _showErrorDialog(
                            context, "Failed to sign in with Google:(", e));
                      },
                    ),
                    SizedBox(height: 12.0),
                    TextButton(
                      child: Container(
                        width: 290.0,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 55.0,
                              width: 55.0,
                              child: Center(
                                  child: Text('?',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold))),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Container(
                              height: 55.0,
                              width: 100.0,
                              child: Center(
                                  child: Text('GUEST',
                                      style: TextStyle(color: Colors.white))),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        signInAnonymously((e) => _showErrorDialog(context,
                            "Failed to sign in with Anonymously:(", e));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      case ApplicationLoginState.loggedIn:
        return HomePage();
    }
    return Container();
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }
}
