import 'package:flutter/material.dart';

import 'package:qr_scaner/src/providers/db_provider.dart';
import 'package:qr_scaner/src/block/scans_bloc.dart';

class UrlsPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
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
              onDismissed: (direction) => scansBloc.deleteScan(scans[i].id),
              child: ListTile(
                leading: Icon(
                  Icons.find_in_page,
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
