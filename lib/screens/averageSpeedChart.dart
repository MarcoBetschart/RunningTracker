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
        Widget;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:runningtracker/models/run.dart';

import '../services/runService.dart';

class AverageSpeedChart extends StatefulWidget {
  const AverageSpeedChart({Key? key}) : super(key: key);

  @override
  State<AverageSpeedChart> createState() => _AverageSpeedChartState();
}

class _AverageSpeedChartState extends State<AverageSpeedChart> {
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
        runModel.averagespeed = run['averagespeed'];
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
                title: ChartTitle(text: 'Average speed in km/h'),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                primaryXAxis: CategoryAxis(),
                primaryYAxis:
                    NumericAxis(numberFormat: NumberFormat.decimalPattern()),
                series: <LineSeries<Run, String>>[
              // Initialize line series.
              LineSeries<Run, String>(
                  name: 'Average speed (km/h)',
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  dataSource: _runList,
                  xValueMapper: (Run run, _) => run.date,
                  yValueMapper: (Run run, _) => run.averagespeed)
            ])));
  }
}
