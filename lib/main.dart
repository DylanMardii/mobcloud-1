import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

List<List<dynamic>> data = [];

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  final csv = await rootBundle.loadString('assets/data.csv');
  List<List<dynamic>> convertedCsv = const CsvToListConverter().convert(csv);
  data = convertedCsv;
  
  runApp(const MaterialApp(
    title: 'Sales Chart',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget{
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
                                    e[0].toDouble() ?? 0.0,
                                    e[1].toDouble() ?? 0.0,
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
