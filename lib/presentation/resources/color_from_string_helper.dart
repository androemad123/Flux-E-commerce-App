

import 'package:flutter/material.dart';

Color colorFromString(String colorName) {
  switch (colorName.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'blue':
      return Colors.blue;
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    case 'green':
      return Colors.green;
    case 'yellow':
      return Colors.yellow;
    case 'pink':
      return Colors.pink;
    case 'nude':
      return Colors.brown;
    case 'coral':
      return Colors.redAccent;
    case 'brown':
      return Colors.brown;
    case 'silver':
      return Colors.blueGrey;
    case 'gold':
      return Colors.orangeAccent;
    case 'gray':
      return Colors.grey;
    case 'navy':
      return Colors.blueGrey;
    case 'coral':
      return Colors.redAccent;
    case 'brown':
      return Colors.brown;
    case 'silver':
      return Colors.blueGrey;
    case 'gold':
      return Colors.orangeAccent;
    default:
      return Colors.grey; // fallback
  }
}
