import 'package:flutter/material.dart';
import 'package:runningtracker/models/run.dart';
import 'package:runningtracker/screens/addRun.dart';
import 'package:runningtracker/screens/editRun.dart';
import 'package:runningtracker/screens/viewRuns.dart';
import 'package:runningtracker/services/runService.dart';

void main() {
  runApp(const RunningTrackerHome());
}

class RunningTrackerHome extends StatelessWidget {
  const RunningTrackerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appName = "Running Tracker";
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        brightness: Brightness.dark,
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
        runModel.name = run['name'];
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
            title: Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.blue[800], fontSize: 20),
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
                      primary: Colors.white, backgroundColor: Colors.blue[800]),
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
                  leading: const Icon(
                    Icons.run_circle_outlined,
                    size: 56.0,
                  ),
                  title: Text(_runList[index].name ?? ''),
                  subtitle: Text("Date: ${_runList[index].date}"),
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
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue[800],
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
          backgroundColor: Colors.blue[800],
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        endDrawer: const DrawerWidget());
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      const UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        accountName: Text("Running Tracker"),
        accountEmail: Text("marco.betschart98@bluewin.ch"),
      ),
      ListTile(
        leading: const Icon(
          Icons.run_circle_outlined,
        ),
        title: const Text('All runs'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.line_axis_outlined,
        ),
        title: const Text('Diagram'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      const AboutListTile(
        icon: Icon(
          Icons.info,
        ),
        applicationIcon: Icon(
          Icons.local_play,
        ),
        applicationName: 'Running Tracker',
        applicationVersion: '1.0.0',
        applicationLegalese: '2023 © Marco Betschart',
        aboutBoxChildren: [
          SizedBox(height: 24),
          Text(
              "The running tracker was created in case of a school project at HFIE.")
        ],
      ),
    ]));
  }
}
