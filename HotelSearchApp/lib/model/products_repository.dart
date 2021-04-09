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

import 'package:flutter/material.dart';

import 'product.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    const allProducts = <Product> [
      Product(
        category: Category.busan,
        id: 0,
        isFeatured: true,
        name: 'Paradise Hotel',
        stars: 5,
        location: '296, Haeundaehaebyeon-ro, Haeundae-gu, 48099 Busan',
        description: 'Paradise Hotel Busan is located along sandy Haeundae Beach and is 12 mi from away Gimhae International Airport. Apart from modern rooms, it also features a casino and an outdoor spa. Selected rooms have balconies overlooking the sea.',
        
      ),
      Product(
        category: Category.busan,
        id: 1,
        isFeatured: true,
        name: 'Park Hyatt Hotel',
        stars: 5,
        location: '51, Marine City 1-ro, Haeundae-gu, 48120 Busan',
        description: 'Located in Haeundae district next to Busan Marina and only 1.2 mi from Haeundae Beach, the 5-star Park Hyatt Busan features luxurious accommodations with exquisite rooms and suites. Boasting its sky lobby on the 30th floor, the hotel offers free WiFi and free private parking for guests.'
      ),
      Product(
        category: Category.gangneung,
        id: 2,
        isFeatured: false,
        name: 'Hotel Tops 10',
        stars: 5,
        location: '455-34, Heonhwa-ro, Gangdong-myeon, 25633 Gangneung',
        description: 'Hotel Tops 10 is just a 3-minute drive from Geumjin Beach and under a 40-minute drive from Gangneung KTX Station. Free WiFi access is available at the hotel. Each room at Hotel Tops 10 is fitted with a flat-screen TV, safety deposit box, fridge and electric kettle. Suites also feature views of the ocean, a sofa and a bath. Private bathroom comes with a hairdryer, bath amenities, a bathrobe, slippers and a toilet with an electronic bidet.',
      ),
      Product(
        category: Category.gangneung,
        id: 3,
        isFeatured: true,
        name: 'Skybay Hotel',
        stars: 5,
        location: '476 Haean-ro, 25460 Gangneung',
        description: 'Located at the heart of 2018 Pyeongchang Winter Olympic site, Skybay Gyeongpo Hotel is just within a short stroll of Lake Gyeongpo and Gyeongpo Beach. Boasting its cleanest quality, this iconic 5-star hotel offers indoor/outdoor pools, fitness center and other top-of-the-line facilities.',
      ),
      Product(
        category: Category.gyeongju,
        id: 4,
        isFeatured: false,
        name: 'Commodore Hotel',
        stars: 4,
        location: '422, Bomun-ro, 38117 Gyeongju',
        description: 'Commodore Hotel Gyeongju Chosun is located within walking distance of Bomun Tourism Complex. It offers rooms with air conditioning, cable TV and wired internet access. The Commodore Hotel has a extensive gardens and an outdoor swimming pool surrounded by a terraced area. There also tennis courts for guests to use.',
      ),
      Product(
        category: Category.gyeongju,
        id: 5,
        isFeatured: false,
        name: 'Hilton Hotel',
        stars: 5,
        location: '484-7, Bomun-ro, 38117 Gyeongju',
        description: 'Overlooking scenic Bomun Lake, the luxurious Hilton Gyeongju is located within Bomun Tourist Complex in historical Gyeongju. Boasting 6 dining options, it also has a seasonal outdoor pool, large indoor pool and squash courts. Light colors are complemented by elegant wooden furnishings, giving each spacious room in Hilton Gyeongju a modern feel. A flat-screen TV, mini-bar and large private bathroom are included in all rooms.',
      ),
      Product(
        category: Category.jeju,
        id: 6,
        isFeatured: false,
        name: 'LOTTE City Hotel',
        stars: 4,
        location: '83, Doryeong-ro, Jeju City, 63127 Jeju',
        description: 'Located in the center of Jeju City, the 4-star LOTTE City Hotel Jeju features free access to an outdoor pool, a fitness center and a sauna. Free WiFi and free parking are available at the property. LOTTE City Hotel Jeju also offers a drop-off service to Jeju International Airport.',
      ),
      Product(
        category: Category.jeju,
        id: 7,
        isFeatured: true,
        name: 'Grand Hyatt Hotel',
        stars: 5,
        location: '12, Noyeon-ro, Jeju City, 63082 Jeju',
        description: 'Centrally located in the heart of Jeju City, Grand Hyatt Jeju is located 1 mi from Shilla Duty Free. The property is 5 mi from Jeju National Museum and 5 mi from Jeju International Passenger Terminal. Samyang Black Sand Beach is 7.5 mi from the resort, while Hamdeok Beach is 12 mi from the property.',
      ),
      Product(
        category: Category.seoul,
        id: 8,
        isFeatured: true,
        name: 'The Westin Josun Hotel',
        stars: 5,
        location: '106, Sogong-ro, Jung-gu, Jung-Gu, 04533 Seoul',
        description: 'Westin Chosun Hotel Seoul is a 5-minute walk from the popular Myeongdong and 350 m from the City Hall Subway Station. Located just behind Lotte Department Store Sogong Branch, this luxurious 5-star property offers an indoor pool, a spa and free parking on site.',
      ),
      Product(
        category: Category.seoul,
        id: 9,
        isFeatured: true,
        name: 'Signiel Hotel',
        stars: 5,
        location: '300, Olympic-ro, Songpa-gu, Songpa-Gu, 05551 Seoul',
        description: 'Located between floors 76 and 101 of Lotte World Tower, Signiel Seoul features panoramic views of Seoul in all 235 rooms. This five-star hotel features a champagne bar, Michelin-starred restaurant, indoor swimming pool, fitness center and banquet facilities. It is also directly connected to Jamsil Subway Station (Line 2 and 8) through an underground passage and provides free WiFi access throughout the entire property.',
      ),
      Product(
        category: Category.yeosu,
        id: 10,
        isFeatured: false,
        name: 'Hidden Bay Hotel',
        stars: 4,
        location: '496-25, Sinwol-ro, 59747 Yeosu',
        description: 'Located in Yeosu, 1.1 mi from Ungcheon Beach Park, Hidden Bay Hotel features accommodations with a restaurant, free private parking, a fitness center and a bar. This 4-star hotel offers a 24-hour front desk, room service and free WiFi. The hotel has a garden and provides a terrace.',
      ),
      Product(
        category: Category.yeosu,
        id: 11,
        isFeatured: false,
        name: 'Sono Calm Hotel',
        stars: 5,
        location: '111, Odongdo-ro, 555-030 Yeosu',
        description: 'Located on the eastern tip of Yeosu city, The MVL Hotel offers spacious and modern rooms as well as a number of on-site dining options. Private parking and property-wide WiFi are provided free of charge. All rooms at Yeosu MVL Hotel boast sea views through floor-to-ceiling windows. There are a flat-screen TV, mini-bar and a work desk in each room. Private bathroom is fitted with a bath, a shower and a hairdryer.',
      ),
    ];
    if (category == Category.all) {
      return allProducts;
    } else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }
}
