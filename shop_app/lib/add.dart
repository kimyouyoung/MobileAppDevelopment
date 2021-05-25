import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/login.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  File _image;
  final picker = ImagePicker();
  String url;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }



  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'Add',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          Consumer<ApplicationState>(
              builder: (context, appState, _) =>
                  Container(

          child: TextButton(
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            onPressed: (){
              appState.addProducts(_productNameController.text, _priceController.text, _descriptionController.text, _image);

              Navigator.pop(context);
            },
          )
    ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 300.0,
                child: _image == null
                    ? Image.network(
                        'https://handong.edu/site/handong/res/img/logo.png')
                    : Image.file(_image),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsetsDirectional.fromSTEB(370.0, 0.0, 0.0, 10.0),
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  disabledColor: Colors.black,
                  onPressed: () {
                    getImage();
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 5.0),
                    child: TextField(
                      controller: _productNameController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Product Name',
                        fillColor: Colors.white24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 5.0),
                    child: TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Price',
                        fillColor: Colors.white24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 5.0),
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Description',
                        fillColor: Colors.white24,
                      ),
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
