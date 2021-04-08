import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _emailAddress = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 120.0),
            TextFormField(
              controller: _usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Username';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Password';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _confirmPassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Confirm Password';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                labelText: 'Confirm Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Address';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                labelText: 'Email Address',
              ),
            ),
            SizedBox(height: 20.0),
            ButtonBar(
              buttonMinWidth: 90.0,
              children: <Widget>[
                RaisedButton(
                  child: Text('SIGN UP'),
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState.validate()) {
                        Navigator.pop(context);
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
