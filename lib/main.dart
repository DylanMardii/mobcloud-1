import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';

class SalesData {
  final int year;
  final int sales;

  SalesData(this.year, this.sales);

  SalesData.fromJson(Map<String, dynamic> json) : year = json['year'] as int, sales = json['sales'] as int; 

  Map<String, dynamic> toJson() => {
    'name' : year,
    'sales' : sales
  };

}

List<SalesData> data = []; 

Future<void> main() async {

  await Supabase.initialize(
    url: 'https://piboagqmuewtqrxjroxw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBpYm9hZ3FtdWV3dHFyeGpyb3h3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQ5MzcxNTQsImV4cCI6MjA0MDUxMzE1NH0.-G0z7ve6Wu-_KUWIgjU_KF6unKb-he_pC3RO6-h5nD0',
  );

  final supabase = Supabase.instance.client;

  final response = await supabase
  .from('dataPertahun')
  .select();

  data = response.map((item) => SalesData.fromJson(item)).toList();

  runApp(const MaterialApp(
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
                  const Text(
                    'Sales Data Over The Year',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
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
