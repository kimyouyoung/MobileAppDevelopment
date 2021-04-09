// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:Shrine/model/product.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/products_repository.dart';
import 'model/product.dart';

const _url = 'https://www.handong.edu';

void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final isSelected = <bool>[false, true];

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

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
                  child: Image.asset(
                    product.assetName,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 3.0, 16.0, 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        product.stars == 5
                            ? build5starIcon()
                            : build4starIcon(),
                        SizedBox(height: 1.0),
                        Text(
                          product.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 2.0),
                      Icon(Icons.location_on,
                          color: Colors.lightBlue, size: 16),
                      SizedBox(width: 6.0),
                      Flexible(
                        child: Text(
                          product.location,
                          style: TextStyle(fontSize: 10),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  margin: EdgeInsets.fromLTRB(145.0, 0.0, 0.0, 5.5),
                  child: FlatButton(
                    child: Text(
                      'more',
                      style: TextStyle(color: Colors.blue, fontSize: 10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildListCards(BuildContext context, Product product) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 120.0,
                  height: 110.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: AspectRatio(
                      aspectRatio: 22 / 15,
                      child: Image.asset(
                        product.assetName,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            product.stars == 5
                                ? build5starIcon()
                                : build4starIcon(),
                            SizedBox(height: 5.0),
                            Text(
                              product.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              maxLines: 1,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              product.location,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 35.0,
                        alignment: AlignmentDirectional.bottomEnd,
                        margin: EdgeInsets.only(top: 5.5),
                        child: FlatButton(
                          child: Text(
                            'more',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).backgroundColor;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              child: DrawerHeader(
                padding: EdgeInsets.fromLTRB(30.0, 100.0, 10.0, 0.0),
                child: Text(
                  'Pages',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  _buildDrawerButton(
                      color, 'Home', Icons.home, '/home', context),
                  _buildDrawerButton(
                      color, 'Search', Icons.search, '/search', context),
                  _buildDrawerButton(color, 'Favorite Hotel',
                      Icons.location_city, '/favoriteHotel', context),
                  _buildDrawerButton(
                      color, 'My Page', Icons.person, '/myPage', context),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        centerTitle: true,
        title: Text(
          'Main',
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.language,
              semanticLabel: 'language',
            ),
            onPressed: _launchURL,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: AlignmentDirectional.topEnd,
              margin: EdgeInsets.fromLTRB(0.0, 10.0, 15.0, 5.0),
              child: ToggleButtons(
                constraints: BoxConstraints(minWidth: 40.0, minHeight: 40.0),
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
                children: <Widget>[
                  Icon(Icons.list),
                  Icon(Icons.grid_view),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: isSelected,
              ),
            ),
            isSelected[1] ? buildGridCard() : buildListCard(),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget buildGridCard() {
    return Expanded(
      child: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            children: _buildGridCards(context),
          );
        },
      ),
    );
  }

  Widget buildListCard() {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    return Flexible(
        child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _buildListCards(context, products[index]);
            }));
  }

  ListTile _buildDrawerButton(Color color, String text, IconData icon,
      String route, BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
          color: text == 'Home' ? color : null,
        ),
      ),
      leading: Icon(icon, color: color, size: 30.0),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget build5starIcon() {
    return Container(
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.yellow, size: 12),
          Icon(Icons.star, color: Colors.yellow, size: 12),
          Icon(Icons.star, color: Colors.yellow, size: 12),
          Icon(Icons.star, color: Colors.yellow, size: 12),
          Icon(Icons.star, color: Colors.yellow, size: 12),
        ],
      ),
    );
  }

  Widget build4starIcon() {
    return Container(
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.yellow, size: 12),
          Icon(Icons.star, color: Colors.yellow, size: 12),
          Icon(Icons.star, color: Colors.yellow, size: 12),
          Icon(Icons.star, color: Colors.yellow, size: 12),
        ],
      ),
    );
  }
}
