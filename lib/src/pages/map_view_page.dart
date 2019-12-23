import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:qr_scanner/src/models/scan_model.dart';

class MapViewPage extends StatefulWidget {
  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  MapController mapController = new MapController();
  String mapStyle = 'streets';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: _appBar(scan),
      body: _createFlutterMap(scan),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  Widget _appBar(ScanModel scan) {
    return AppBar(
      title: Text('Mapa'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.gps_fixed),
          onPressed: () {
            mapController.move(scan.getLatLong(), 15);
          },
        )
      ],
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.getLatLong(),
        zoom: 15,
      ),
      layers: [
        _createMap(),
        _createBookmark(scan),
      ],
    );
  }

  _createMap() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
          '{id}/{z}/{x}/{y}@2x.png?access_token={acssesToken}',
      additionalOptions: {
        'acssesToken':
            'pk.eyJ1IjoiamRnbjk0IiwiYSI6ImNrNGlpenlyeDFsOHQzZW82NHh4Nm9pY2IifQ.uCuZOOe4zW3AyZ9amO2nCw',
        'id': 'mapbox.$mapStyle',
      },
    );
  }

  _createBookmark(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 120.0,
          height: 120.0,
          point: scan.getLatLong(),
          builder: (context) => Container(
            child: Icon(Icons.location_on,
                size: 50.0, color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        setState(() {
          if (mapStyle == 'streets') {
            mapStyle = 'dark';
          } else if (mapStyle == 'dark') {
            mapStyle = 'light';
          } else if (mapStyle == 'light') {
            mapStyle = 'outdoors';
          } else if (mapStyle == 'outdoors') {
            mapStyle = 'satellite';
          } else {
            mapStyle = 'streets';
          }
        });
      },
    );
  }
}
