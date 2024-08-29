import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';

class SalesData {
  final int year;
  final int sales;

  SalesData(this.year, this.sales);
}

final List<SalesData> data = [
  SalesData(0, 1500000),
  SalesData(1, 1735000),
  SalesData(2, 1678000),
  SalesData(3, 1890000),
  SalesData(4, 1907000),
  SalesData(5, 2300000),
  SalesData(6, 2360000),
  SalesData(7, 1980000),
  SalesData(8, 2654000),
  SalesData(9, 2789070),
  SalesData(10, 3020000),
  SalesData(11, 3245900),
  SalesData(12, 4098500),
  SalesData(13, 4500000),
  SalesData(14, 4456500),
  SalesData(15, 3900500),
  SalesData(16, 5123400),
  SalesData(17, 5589000),
  SalesData(18, 5940000),
  SalesData(19, 6367000),
];

void main() {
  runApp(MaterialApp(
    title: 'Sales Chart',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Chart')),
      body: Center(
        child: Container(
          height: 400,
          padding: const EdgeInsets.all(20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Sales Data Over The Year',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: data
                                .map(
                                  (e) => FlSpot(
                                    e.year.toDouble(),
                                    e.sales.toDouble(),
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
