import 'package:flutter/material.dart';

import 'package:qr_scaner/src/providers/db_provider.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScanModel>>(
      future: DBProvider.db.getScansType('geo'),
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(child: Text('No hay datos que mostrar'));
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.redAccent,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.zoom_out_map,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(scans[i].value),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {},
              ),
            );
          },
        );
      },
    );
  }
}
