import 'package:flutter/material.dart';

class Slide {
  String imageUrl;
   String title;
  String description;

  Slide({
    this.imageUrl,
     this.title,
    this.description,
  });

 static List<Slide> list = [
    Slide(
      imageUrl: 'assets/images/image1.png',
      title: 'Hi..',
      description: 'Welcome To App ',
    ),
    Slide(
      imageUrl: 'assets/images/medical.png',
      title: 'Learning Online',
      description: ' We are glad that you are here with us',
    ),
    Slide(
      imageUrl: 'assets/images/technology.png',
      title: 'Start Learning',
      description: 'It will be a wonderful learning journey with us',
    ),
  ];
}


