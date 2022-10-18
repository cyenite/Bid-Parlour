import 'package:flutter/material.dart';

class gridHome {
  String name, image, valueMarket, valuePercent;
  Color chartColor;
  List<Color> chartColorGradient;
  var data;
  gridHome(
      {this.image,
      this.name,
      this.data,
      this.chartColor,
      this.valueMarket,
      this.valuePercent,
      this.chartColorGradient});
}

List<gridHome> listGridHome = [
  gridHome(
      name: "JACKPOT",
      image: "Test",
      chartColor: Color(0xff00ff0e),
      valueMarket: "5,6000,000",
      valuePercent: "98%",
      chartColorGradient: [
        Colors.greenAccent.withOpacity(0.2),
        Colors.greenAccent.withOpacity(0.01)
      ],
      data: [
        0.0,
        0.5,
        0.9,
        1.4,
        2.2,
        1.0,
        3.3,
        0.0,
        -0.5,
        -1.0,
        -0.5,
        0.0,
        0.0
      ]),
  gridHome(
      name: "GIVEAWAY",
      image: "Test",
      chartColor: Color(0xffffcd00),
      valueMarket: "3873.98",
      valuePercent: "0.14%",
      chartColorGradient: [
        Colors.greenAccent.withOpacity(0.2),
        Colors.greenAccent.withOpacity(0.01)
      ],
      data: [
        0.0,
        -0.3,
        -0.5,
        -0.1,
        0.0,
        0.0,
        -0.5,
        -1.0,
        -0.5,
        0.0,
        0.0,
      ]),
  gridHome(
      name: "BONUSES",
      image: "Test",
      valueMarket: "132.20",
      valuePercent: "0.34%",
      chartColor: Colors.redAccent,
      chartColorGradient: [
        Colors.redAccent.withOpacity(0.2),
        Colors.redAccent.withOpacity(0.01)
      ],
      data: [
        0.0,
        1.0,
        1.5,
        2.0,
        0.0,
        0.0,
        -0.5,
        -1.0,
        -0.5,
        0.0,
        0.0
      ]),
  gridHome(
      name: "AFFILIATE",
      image: "Test",
      valueMarket: "0.31",
      valuePercent: "0.53%",
      chartColor: Colors.redAccent,
      chartColorGradient: [
        Colors.greenAccent.withOpacity(0.2),
        Colors.greenAccent.withOpacity(0.01)
      ],
      data: [
        0.0,
        1.0,
        1.5,
        2.0,
        1.8,
        1.7,
        1.6,
        1.67,
        1.4,
        1.2,
        1.5,
        2.0,
        0.7,
        1.1,
        2.2,
        1.5,
        2.0,
        1.8,
        1.7,
        1.6,
        1.67,
        1.4,
        1.2,
        1.5,
        0.5,
        -0.5,
        -0.7,
        -0.5,
        0.0,
        0.0
      ]),
];
