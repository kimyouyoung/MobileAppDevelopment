import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/login.dart';
import 'package:shop_app/product.dart';
import 'package:path/path.dart' as Path;

class EditPage extends StatefulWidget {
  EditPage({@required this.product, @required this.imageUrl, @required this.path, @required this.name, @required this.price, @required this.desc, @required this.docId});
  final Product product;
  final String imageUrl;
  final String path;
  final String name;
  final int price;
  final String desc;
  final String docId;
  @override
  _EditPageState createState() => _EditPageState(this.product, this.imageUrl, this.path, this.name, this.price, this.desc, this.docId);
}

class _EditPageState extends State<EditPage> {
  File _image;
  final picker = ImagePicker();
  Product product;
  String url;
  String path;
  String name;
  int price;
  String desc;
  String docId;

  _EditPageState(Product product, String imageUrl, String path, String name, int price, String desc, String docId){
    this.product = product;
    this.url = imageUrl;
    this.path = path;
    this.name = name;
    this.price = price;
    this.desc = desc;
    this.docId = docId;
  }


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

  Future uploadFile(File _image, ApplicationState appState) async {

    if(_image != null)
      path = 'productImages/${Path.basename(_image.path)}}';

    if(_image != null)
      await FirebaseStorage.instance
          .ref()
          .child('productImages/${Path.basename(_image.path)}}').putFile(_image);
    print('File Uploaded');

    if(_image != null)
      url = await FirebaseStorage.instance
          .ref()
          .child('productImages/${Path.basename(_image.path)}}').getDownloadURL();

    appState.editProducts(docId, url, path,  name, price, desc, _image, product.likes);
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
          'Edit',
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
                      onPressed: ()  {
                        uploadFile(_image, appState);

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
                child: product.imageUrl == null
                    ? Image.network(
                    'https://handong.edu/site/handong/res/img/logo.png')
                    : Image.network(product.imageUrl),
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
                      onChanged: (text){
                        setState(() {
                          if(_productNameController.text != null)
                            name = _productNameController.text;
                        });
                      },
                      controller: _productNameController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: '${product.name}',
                        fillColor: Colors.white24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 5.0),
                    child: TextField(
                    onChanged: (text){
                      setState(() {
                        if(_priceController.text != null)
                          price = int.parse(_priceController.text);
                      });
                    },
                      controller: _priceController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: '${product.price}',
                        fillColor: Colors.white24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 5.0),
                    child: TextField(
                      onChanged: (text){
                        setState(() {
                          if(_descriptionController.text != null)
                            desc = _descriptionController.text;
                        });
                      },
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: '${product.desc}',
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
