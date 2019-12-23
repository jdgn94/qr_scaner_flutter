import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:qr_scanner/src/models/scan_model.dart';

launchURL(ScanModel scan, BuildContext context) async {
  if (scan.type == 'http') {
    if (await canLaunch(scan.value)) {
      await launch(scan.value);
    } else {
      throw 'Could not launch ${scan.value}';
    }
  } else {
    print('Hacer el codigo para los mapas');
    Navigator.pushNamed(context, 'map_view', arguments: scan);
  }
}
