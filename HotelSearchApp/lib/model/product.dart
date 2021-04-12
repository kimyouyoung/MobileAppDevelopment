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

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum Category { all, busan, gangneung, gyeongju, jeju, seoul, yeosu,}

class Product {
  const Product({
    @required this.category,
    @required this.id,
    @required this.isFeatured,
    @required this.name,
    @required this.stars,
    @required this.location,
    @required this.description,
    @required this.phone,
  })  : assert(category != null),
        assert(id != null),
        assert(isFeatured != null),
        assert(name != null),
        assert(stars != null),
        assert(location != null),
        assert(description != null),
        assert(phone != null);

  final Category category;
  final int id;
  final bool isFeatured;
  final String name;
  final int stars;
  final String location;
  final String description;
  final String phone;

  String get assetName => 'images/$id-0.jpg';

  @override
  String toString() => "$name (id=$id)";
}

class Save{
  final _saved = <Product>{};
}