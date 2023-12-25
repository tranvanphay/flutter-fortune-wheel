import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class Constants {
  Constants._();

  static Constants I = Constants._();

  static List<Fortune> icons = <Fortune>[
    Fortune(
      id: 1,
      backgroundColor: Colors.red,
      icon: Image.asset(
        'assets/gold.png',
        width: 50,
        height: 50,
      ),
      priority: 1,
    ),
    Fortune(
      id: 2,
      backgroundColor: Colors.green,
      icon: Image.asset(
        'assets/money.png',
        width: 50,
        height: 50,
      ),
      priority: 0,
    ),
    Fortune(
      id: 3,
      backgroundColor: Colors.amber,
      icon: Image.asset(
        'assets/milk.png',
        width: 50,
        height: 50,
      ),
      priority: 0,
    ),
    Fortune(
      id: 4,
      backgroundColor: Colors.red,
      icon: Image.asset(
        'assets/ticket.png',
        width: 50,
        height: 50,
      ),
      priority: 0,
    ),
    Fortune(
      id: 5,
      backgroundColor: Colors.green,
      icon: Image.asset(
        'assets/sui.png',
        width: 50,
        height: 50,
      ),
      priority: 0,
    ),
    Fortune(
      id: 6,
      backgroundColor: Colors.amber,
      icon: Image.asset(
        'assets/air_plane.png',
        width: 50,
        height: 50,
      ),
      priority: 0,
    ),
    Fortune(
      id: 7,
      backgroundColor: Colors.red,
      icon: Image.asset(
        'assets/car.png',
        width: 50,
        height: 50,
      ),
      priority: 0,
    ),
    Fortune(
      id: 8,
      backgroundColor: Colors.amber,
      icon: Image.asset(
        'assets/bicycle.png',
        width: 50,
        height: 50,
      ),
      priority: 0,
    ),
    Fortune(
      id: 9,
      backgroundColor: Colors.green,
      icon: Image.asset(
        'assets/package.png',
        width: 50,
        height: 50,
      ),
      priority: 0,
    ),
    Fortune(
      id: 10,
      backgroundColor: Colors.blueAccent,
      icon: Image.asset(
        'assets/replay.png',
        width: 50,
        height: 50,
      ),
      priority: 0,
    ),
    Fortune(
      id: 11,
      backgroundColor: Colors.orangeAccent,
      icon: Image.asset(
        'assets/oops.png',
        width: 50,
        height: 50,
      ),
      priority: 0,
    ),
    Fortune(
      id: 12,
      backgroundColor: Colors.green,
      icon: Image.asset(
        'assets/card.png',
        width: 50,
        height: 50,
      ),
      priority: 0,
    )
  ];
}
