import 'package:ase_group5_scm/Components/AppConstants.dart';
import 'package:ase_group5_scm/pages/DublinBikes/widgets/swap_suggestions_table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/foundation.dart';

import 'dublin_bikes_map.dart';
import 'dublin_bikes_usage_chart.dart';
import 'package:logging/logging.dart';

class DublinBikesDashboardWeb extends StatefulWidget {
  const DublinBikesDashboardWeb({Key? key}) : super(key: key);

  @override
  _DublinBikesDashboardWebState createState() =>
      _DublinBikesDashboardWebState();
}

class _DublinBikesDashboardWebState extends State<DublinBikesDashboardWeb> {
  final log = Logger('dublin_bikes_dashboard.dart');

  StreamBuilder<Object?> combinedStreams() {
    Stream<QuerySnapshot> map = FirebaseFirestore.instance
        .collection(AppConstants.DUBLIN_BIKES_COLLECTION)
        .snapshots();
    Stream<QuerySnapshot> swaps = FirebaseFirestore.instance
        .collection(AppConstants.BIKES_SWAPS_COLLECTION)
        .snapshots();
    return StreamBuilder(
        stream: CombineLatestStream.list([map, swaps]),
        builder: (context, combinedSnapshot) {
          if (combinedSnapshot.hasData) {
            var snapshotList = combinedSnapshot.data as List<QuerySnapshot>;
            var snapshot = snapshotList[0];
            var swapSnapshot = snapshotList[1];
            return Container(
                child: new SingleChildScrollView(
              child: Column(
                children: [
                  (defaultTargetPlatform == TargetPlatform.iOS ||
                          defaultTargetPlatform == TargetPlatform.android)
                      ? Column(
                          mainAxisSize: MainAxisSize.max, // match parent
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              BikeStationMap(snapshot: snapshot),
                              DublinBikesUsageChart(
                                  snapshot: snapshot, series: "overuse"),
                              DublinBikesUsageChart(
                                  snapshot: snapshot, series: "underuse")
                            ])
                      : Row(
                          mainAxisSize: MainAxisSize.max, // match parent
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: BikeStationMap(snapshot: snapshot),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    DublinBikesUsageChart(
                                        snapshot: snapshot, series: "overuse"),
                                    DublinBikesUsageChart(
                                        snapshot: snapshot, series: "underuse")
                                  ],
                                ),
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                  SwapSuggestionTable(
                    snapshot: swapSnapshot,
                    dataKey: "free_stations",
                  ),
                  SwapSuggestionTable(
                    snapshot: swapSnapshot,
                    dataKey: "occupied_stations",
                  ),
                ],
              ),
            ));
          } else {
            return Center(
                child: Transform.scale(
              scale: 1,
              child: CircularProgressIndicator(),
            ));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    log.info('entered dublin bikes web dashboard');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(child: combinedStreams()),
    );
  }
}
