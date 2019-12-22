import 'package:flutter/material.dart';

import 'package:qr_scaner/src/pages/maps_page.dart';
import 'package:qr_scaner/src/pages/urls_page.dart';

import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int actualPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _callPage(actualPage),
      floatingActionButton: _floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text('QR Scanner'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: actualPage,
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

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: _scanQR,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  void _scanQR() async {
    print('Quiero escanear');

    String futureString = '';

    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }

    print('future string $futureString');
  }
}
