import 'package:flutter/material.dart';
import 'package:runningtracker/models/run.dart';
import 'package:runningtracker/services/runService.dart';

class EditRun extends StatefulWidget {
  final Run run;
  const EditRun({Key? key, required this.run}) : super(key: key);

  @override
  State<EditRun> createState() => _EditRunState();
}

class _EditRunState extends State<EditRun> {
  final _runDateController = TextEditingController();
  final _runDistanceController = TextEditingController();
  final _runDurationController = TextEditingController();
  bool _validateName = false;
  bool _validateDistance = false;
  bool _validateDuration = false;
  final _runService = RunService();

  @override
  void initState() {
    setState(() {
      _runDateController.text = widget.run.date ?? '';
      _runDistanceController.text = widget.run.distance.toString();
      _runDurationController.text = widget.run.durationminutes.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite CRUD"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit New Run',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _runDateController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _runDistanceController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Distance',
                    labelText: 'Distance',
                    errorText: _validateDistance
                        ? 'Distance Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _runDurationController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Duration',
                    labelText: 'Duration',
                    errorText: _validateDuration
                        ? 'Duration Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _runDateController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _runDistanceController.text.isEmpty
                              ? _validateDistance = true
                              : _validateDistance = false;
                          _runDurationController.text.isEmpty
                              ? _validateDuration = true
                              : _validateDuration = false;
                        });
                        if (_validateName == false &&
                            _validateDistance == false &&
                            _validateDuration == false) {
                          // print("Good Data Can Save");
                          var run = Run();
                          run.id = widget.run.id;
                          run.date = _runDateController.text;
                          run.distance =
                              double.parse(_runDistanceController.text);
                          run.durationminutes =
                              int.parse(_runDurationController.text);
                          run.averagespeed =
                              run.distance! / (run.durationminutes! / 60);
                          var result = await _runService.UpdateRun(run);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Update Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _runDateController.text = '';
                        _runDistanceController.text = '';
                        _runDurationController.text = '';
                      },
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
