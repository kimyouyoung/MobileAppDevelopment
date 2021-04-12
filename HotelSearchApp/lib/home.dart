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
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rive/rive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'model/products_repository.dart';
import 'model/product.dart';

const _url = 'https://www.handong.edu';

void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

_HomePageState homePage = _HomePageState();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final isSelected = <bool>[false, true];
  final _saved = <Product>{};

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
                  child: Hero(
                    tag: product.assetName,
                    child: Image.asset(
                      product.assetName,
                      fit: BoxFit.cover,
                    ),
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
                      SizedBox(width: 2.0),
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
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Detail(product: product),
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
                    child: Hero(
                      tag: product.assetName,
                      child: AspectRatio(
                        aspectRatio: 22 / 15,
                        child: Image.asset(
                          product.assetName,
                          fit: BoxFit.cover,
                        ),
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
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Detail(product: product),
                            ));
                          },
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
              Navigator.pushNamed(context, '/search');
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

class Detail extends StatefulWidget {
  Detail({Key key, @required this.product}) : super(key: key);
  final Product product;

  @override
  _DetailState createState() => _DetailState(this.product);
}

class _DetailState extends State<Detail> {
  Product product;

  _DetailState(Product product) {
    this.product = product;
  }

  @override
  Widget build(BuildContext context) {
    final alreadySaved = homePage._saved.contains(product);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 22 / 18,
                    child: Hero(
                      tag: product.assetName,
                      child: Material(
                        child: InkWell(
                          child: Image.asset(
                            product.assetName,
                            fit: BoxFit.cover,
                          ),
                          onDoubleTap: () {
                            setState(() {
                              if (alreadySaved) {
                                homePage._saved.remove(product);
                              } else {
                                homePage._saved.add(product);
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                        alreadySaved ? Icons.favorite : Icons.favorite_border,
                        color: alreadySaved ? Colors.red : Colors.white,
                        size: 40),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        product.stars == 5
                            ? homePage.build5starIcon()
                            : homePage.build4starIcon(),
                        SizedBox(height: 10.0),
                        Text(
                          product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.blue.shade800,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        SizedBox(width: 2.0),
                        Icon(Icons.location_on,
                            color: Colors.lightBlue, size: 22),
                        SizedBox(width: 6.0),
                        Flexible(
                          child: Text(
                            product.location,
                            style:
                                TextStyle(fontSize: 14, color: Colors.blueGrey),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 7.0),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        SizedBox(width: 2.0),
                        Icon(Icons.phone, color: Colors.lightBlue, size: 22),
                        SizedBox(width: 6.0),
                        Flexible(
                          child: Text(
                            product.phone,
                            style:
                                TextStyle(fontSize: 15, color: Colors.blueGrey),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Divider(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      product.description,
                      style: TextStyle(fontSize: 17, color: Colors.blueGrey),
                      maxLines: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteHotel extends StatefulWidget {
  @override
  _FavoriteHotelState createState() => _FavoriteHotelState();
}

class _FavoriteHotelState extends State<FavoriteHotel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Hotels'),
      ),
      body: ListView(
        children: pushSaved(),
      ),
    );
  }

  List<Widget> pushSaved() {
    final tiles = homePage._saved.map(
      (Product product) {
        return Dismissible(
          background: Container(color: Colors.red),
          onDismissed: (direction) {
            setState(() {
              homePage._saved.remove(product);
            });
          },
          key: Key(product.name),
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 0.0),
            title: Text(
              product.name,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
    );
    final divided =
        ListTile.divideTiles(tiles: tiles, context: context).toList();
    return divided;
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<Product> products = ProductsRepository.loadProducts(Category.all);

  void _togglePlay() {
    if (_light) {
      _riveArtboard.addController(
        _controller = SimpleAnimation('day_night'),
      );
    } else {
      _riveArtboard.addController(
        _controller = SimpleAnimation('night_day'),
      );
    }
    setState(() => _riveArtboard);
  }

  bool _light = false;

  Artboard _riveArtboard;
  RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/knight063.riv').then(
      (data) async {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        artboard.addController(_controller = SimpleAnimation('idle'));
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: ClipOval(
                    child: Align(
                      heightFactor: 0.7,
                      widthFactor: 0.5,
                      child: _riveArtboard == null
                          ? const SizedBox()
                          : Rive(artboard: _riveArtboard),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wb_sunny, color: Colors.orange),
                  buildSwitch(),
                  Icon(Icons.nightlight_round, color: Colors.purple.shade900),
                ],
              ),
              Text('Youyoung Kim',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              SizedBox(height: 10.0),
              Text('21800147',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0)),
              Container(
                alignment: AlignmentDirectional.topStart,
                margin: EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 0.0),
                child: Text('My Favorite Hotel List',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              ExampleParallax(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSwitch() {
    return Transform.scale(
      scale: 1,
      child: Switch(
        activeColor: Colors.purple.shade900,
        activeTrackColor: Colors.purple.shade400,
        inactiveThumbColor: Colors.orange,
        inactiveTrackColor: Colors.yellow.shade600,
        splashRadius: 50,
        value: _light,
        onChanged: (value) {
          setState(() {
            _light = value;
            _togglePlay();
          });
        },
      ),
    );
  }
}

class ExampleParallax extends StatelessWidget {
  const ExampleParallax({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final product in homePage._saved)
            LocationListItem(
              assetName: product.assetName,
              name: product.name,
              location: product.location,
              product: product,
            ),
        ],
      ),
    );
  }
}

class LocationListItem extends StatelessWidget {
  LocationListItem({
    Key key,
    @required this.assetName,
    @required this.name,
    @required this.location,
    @required this.product,
  }) : super(key: key);

  final String assetName;
  final String name;
  final String location;
  final Product product;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            child: InkWell(
              child: Stack(
                children: [
                  _buildParallaxBackground(context),
                  _buildGradient(),
                  _buildTitleAndSubtitle(),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Detail(product: product),
                ));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.asset(
          assetName,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            location,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    @required this.scrollable,
    @required this.listItemContext,
    @required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class Parallax extends SingleChildRenderObjectWidget {
  Parallax({
    @required Widget background,
  }) : super(child: background);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderParallax(scrollable: Scrollable.of(context));
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderParallax renderObject) {
    renderObject.scrollable = Scrollable.of(context);
  }
}

class ParallaxParentData extends ContainerBoxParentData<RenderBox> {}

class RenderParallax extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin {
  RenderParallax({
    @required ScrollableState scrollable,
  }) : _scrollable = scrollable;

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    if (value != _scrollable) {
      if (attached) {
        _scrollable.position.removeListener(markNeedsLayout);
      }
      _scrollable = value;
      if (attached) {
        _scrollable.position.addListener(markNeedsLayout);
      }
    }
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ParallaxParentData) {
      child.parentData = ParallaxParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;

    // Force the background to take up all available width
    // and then scale its height based on the image's aspect ratio.
    final background = child;
    final backgroundImageConstraints =
        BoxConstraints.tightFor(width: size.width);
    background.layout(backgroundImageConstraints, parentUsesSize: true);

    // Set the background's local offset, which is zero.
    (background.parentData as ParallaxParentData).offset = Offset.zero;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Get the size of the scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;

    // Calculate the global position of this list item.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final backgroundOffset =
        localToGlobal(size.centerLeft(Offset.zero), ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final scrollFraction =
        (backgroundOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final background = child;
    final backgroundSize = background.size;
    final listItemSize = size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
        background,
        (background.parentData as ParallaxParentData).offset +
            offset +
            Offset(0.0, childRect.top));
  }
}
