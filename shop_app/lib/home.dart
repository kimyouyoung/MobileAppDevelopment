import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/add.dart';
import 'package:shop_app/detail.dart';
import 'package:shop_app/login.dart';
import 'package:shop_app/product.dart';
import 'package:shop_app/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Card> _buildGridCards(BuildContext context, ApplicationState appState) {

    List<Product> products = appState.products;

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: AspectRatio(
                  aspectRatio: 18 / 11,
                  child: product.imageUrl == null ?
                      Image.network('https://handong.edu/site/handong/res/img/logo.png')
                    :Image.network(
                    product.imageUrl
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40.0, 3.0, 16.0, 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          maxLines: 1,
                        ),
                        Text(
                          '${product.price}',
                          style: TextStyle(fontSize: 15),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  margin: EdgeInsets.fromLTRB(120.0, 0.0, 0.0, 5.5),
                  child: FlatButton(
                    child: Text(
                      'more',
                      style: TextStyle(color: Colors.blue, fontSize: 13.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailPage(product: product, price: product.price),
                      ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  String dropdownValue = 'ASC';
  bool order = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main', style: TextStyle(fontWeight: FontWeight.w300)),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 5.0),
            icon: Icon(Icons.add),
            iconSize: 30.0,
            disabledColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddPage(),
              ));
            },
          ),
        ],
        leading: IconButton(
          padding: EdgeInsets.only(left: 5.0),
          icon: Icon(Icons.person_rounded),
          iconSize: 30.0,
          disabledColor: Colors.white,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Profile()));
          },
        ),
      ),
      body: Center(
        child: Consumer<ApplicationState>(
          builder: (context, appState, _) => Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    dropdownValue == 'ASC' ? order = false : order = true;
                    appState.order(order);
                  });
                },
                items: <String>['ASC', 'DESC']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 30.0),
              buildGridCard(appState),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridCard(ApplicationState appState) {
    return Expanded(
      child: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            children: _buildGridCards(context, appState),
          );
        },
      ),
    );
  }
}
