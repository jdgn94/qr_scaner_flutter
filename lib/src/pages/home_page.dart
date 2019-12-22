import 'package:flutter/material.dart';

import 'package:qr_scaner/src/pages/maps_page.dart';
import 'package:qr_scaner/src/pages/urls_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int actualPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(actualPage),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (i) {
        setState(() {
          actualPage = i;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.web),
          title: Text('URLs'),
        ),
      ],
    );
  }

  Widget _callPage(int actualPage) {
    switch (actualPage) {
      case 0:
        return MapsPage();
      case 1:
        return UrlsPage();
      default:
        return MapsPage();
    }
  }
}
