import 'dart:collection';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DublinBikesUsageChart extends StatefulWidget {
  const DublinBikesUsageChart({Key? key}) : super(key: key);

  @override
  _DublinBikesUsageChartState createState() => _DublinBikesUsageChartState();
}

class BikeStationUsageData {
  final String stationName;
  final int occupancyPercentage;

  BikeStationUsageData({
    required this.stationName,
    required this.occupancyPercentage,
  });
}

class _DublinBikesUsageChartState extends State<DublinBikesUsageChart> {
  Map stationUsageMap = new Map<String, int>();

  List<bool> isSelected = [true, false];
  late List<charts.Series<BikeStationUsageData, String>>
  StationUsageMapListSeries;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void getSationUsageData(stationData) {
      var stationName = stationData.get("station_name");
      Random random = new Random();
      int randomNumber = random.nextInt(30);
      stationUsageMap[stationName] = randomNumber + 5;
    }

    return SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('DublinBikes')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  getSationUsageData(snapshot.data!.docs[i]);
                }
                final sorted = new SplayTreeMap<String, dynamic>.from(
                    stationUsageMap,
                        (a, b) => stationUsageMap[a] > stationUsageMap[b] ? 1 : -1);
                var ascStationUsageMap = Map.fromEntries(
                    stationUsageMap.entries.toList()
                      ..sort((e1, e2) => e1.value.compareTo(e2.value)));
                var decStationUsageMap = Map.fromEntries(
                    stationUsageMap.entries.toList()
                      ..sort((e1, e2) => e2.value.compareTo(e1.value)));
                List<BikeStationUsageData> ascStationUsageMapList = [];
                ascStationUsageMap.entries.forEach((e) =>
                    ascStationUsageMapList.add(BikeStationUsageData(
                        stationName: e.key, occupancyPercentage: e.value)));
                ascStationUsageMapList =
                    ascStationUsageMapList.take(10).toList();
                List<charts.Series<BikeStationUsageData, String>>
                ascStationUsageMapListSeries = [
                  charts.Series(
                    id: "Bike Usage Percentage",
                    data: ascStationUsageMapList,
                    domainFn:
                        (BikeStationUsageData ascStationUsageMapListSeries,
                        _) =>
                    ascStationUsageMapListSeries.stationName,
                    measureFn:
                        (BikeStationUsageData ascStationUsageMapListSeries,
                        _) =>
                    ascStationUsageMapListSeries.occupancyPercentage,
                  )
                ];

                List<BikeStationUsageData> decStationUsageMapList = [];
                decStationUsageMap.entries.forEach((e) =>
                    decStationUsageMapList.add(BikeStationUsageData(
                        stationName: e.key, occupancyPercentage: e.value)));
                decStationUsageMapList =
                    decStationUsageMapList.take(10).toList();
                List<charts.Series<BikeStationUsageData, String>>
                decStationUsageMapListSeries = [
                  charts.Series(
                    id: "Bike Usage Percentage",
                    data: ascStationUsageMapList,
                    domainFn:
                        (BikeStationUsageData decStationUsageMapListSeries,
                        _) =>
                    decStationUsageMapListSeries.stationName,
                    measureFn:
                        (BikeStationUsageData decStationUsageMapListSeries,
                        _) =>
                    decStationUsageMapListSeries.occupancyPercentage,
                  )
                ];
                StationUsageMapListSeries = decStationUsageMapListSeries;

                return Scaffold(
                  appBar: AppBar(title: Text("Dublin Bikes Usage Chart")),
                  body: Center(
                      child: Container(
                        height: 600,
                        padding: EdgeInsets.all(20),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Dublin Bikes Usage Chart",
                                ),
                                Expanded(
                                  child: charts.BarChart(
                                    StationUsageMapListSeries,
                                    animate: false,
                                    domainAxis: charts.OrdinalAxisSpec(
                                      renderSpec: charts.SmallTickRendererSpec(
                                          labelRotation: 60),
                                    ),
                                  ),
                                ),
                                new Row(
                                  children: <Widget>[
                                    ToggleButtons(
                                      borderColor: Colors.black,
                                      fillColor: Colors.grey,
                                      borderWidth: 2,
                                      selectedBorderColor: Colors.black,
                                      selectedColor: Colors.white,
                                      borderRadius: BorderRadius.circular(0),
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Overuse Stations',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Underuse Stations',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                      onPressed: (int index) {
                                        setState(() {
                                          for (int i = 0;
                                          i < isSelected.length;
                                          i++) {
                                            isSelected[i] = i == index;
                                            if (isSelected[0]) {
                                              StationUsageMapListSeries =
                                                  ascStationUsageMapListSeries;
                                            } else {
                                              StationUsageMapListSeries =
                                                  decStationUsageMapListSeries;
                                            }
                                          }
                                        });
                                      },
                                      isSelected: isSelected,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text("Snapshot has Error!");
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
