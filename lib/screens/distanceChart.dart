// ignore_for_file: file_names

import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Center,
        Key,
        Scaffold,
        State,
        StatefulWidget,
        Text,
        TextStyle,
        Widget;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:runningtracker/models/run.dart';

import '../services/runService.dart';

class DistanceChart extends StatefulWidget {
  const DistanceChart({Key? key}) : super(key: key);

  @override
  State<DistanceChart> createState() => _DistanceChartState();
}

class _DistanceChartState extends State<DistanceChart> {
  late List<Run> _runList = <Run>[];
  final _runService = RunService();

  getAllRunDetails() async {
    var runs = await _runService.readAllRuns();
    _runList = <Run>[];
    runs.forEach((run) {
      setState(() {
        var runModel = Run();
        runModel.id = run['id'];
        runModel.date = run['date'];
        runModel.distance = run['distance'];
        _runList.add(runModel);
      });
    });
  }

  @override
  void initState() {
    getAllRunDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Running Tracker"),
        ),
        body: Center(
            child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          title: ChartTitle(text: 'Distances of runs'),
          primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            labelFormat: '{value} km',
          ),
          series: <ColumnSeries<Run, String>>[
            ColumnSeries<Run, String>(
              dataSource: _runList,
              xValueMapper: (Run run, _) => run.date as String,
              yValueMapper: (Run run, _) => run.distance,
              dataLabelSettings: const DataLabelSettings(
                  isVisible: true, textStyle: TextStyle(fontSize: 10)),
            )
          ],
        )));
  }
}
