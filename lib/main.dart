import 'package:flutter/material.dart';
import 'package:runningtracker/models/run.dart';
import 'package:runningtracker/screens/addRun.dart';
import 'package:runningtracker/screens/editRun.dart';
import 'package:runningtracker/screens/viewRuns.dart';
import 'package:runningtracker/services/runService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Running Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        runModel.durationminutes = run['durationminutes'];
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

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, runId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.red),
                  onPressed: () async {
                    var result = await _runService.deleteRun(runId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllRunDetails();
                      _showSuccessSnackBar('Run Detail Deleted Success');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Running Tracker"),
      ),
      body: ListView.builder(
          itemCount: _runList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewRuns(
                                run: _runList[index],
                              )));
                },
                leading: const Icon(Icons.person),
                title: Text(_runList[index].date ?? ''),
                subtitle: Text(_runList[index].distance.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditRun(
                                        run: _runList[index],
                                      ))).then((data) {
                            if (data != null) {
                              getAllRunDetails();
                              _showSuccessSnackBar(
                                  'Run Detail Updated Success');
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(context, _runList[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddRun()))
              .then((data) {
            if (data != null) {
              getAllRunDetails();
              _showSuccessSnackBar('Run Detail Added Success');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}