import 'package:flutter/material.dart';

class PortfolioSliverAppBar extends StatelessWidget {
  final String _title;

  const PortfolioSliverAppBar(
      this._title, {
        Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.lightBlue,
      expandedHeight: 200,
      pinned: true,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          _title,
          style: const TextStyle(color: Colors.white),
        ),
        background: Image.asset(
          'assets/images/organic.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}