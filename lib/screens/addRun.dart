import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:runningtracker/models/run.dart';
import 'package:runningtracker/services/runService.dart';

class AddRun extends StatefulWidget {
  const AddRun({Key? key}) : super(key: key);

  @override
  State<AddRun> createState() => _AddRunState();
}

class _AddRunState extends State<AddRun> {
  var _runDateController = TextEditingController();
  var _runDistanceController = TextEditingController();
  var _runDurationController = TextEditingController();
  bool _validateName = false;
  bool _validateDistance = false;
  bool _validateDuration = false;
  var _runService = RunService();
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
                'Add New Run',
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
                  keyboardType: TextInputType.datetime,
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                          var run = Run();
                          run.date = _runDateController.text;
                          run.distance =
                              double.parse(_runDistanceController.text);
                          run.durationminutes =
                              double.parse(_runDurationController.text);
                          run.averagespeed =
                              run.distance! / (run.durationminutes! / 60);
                          var result = await _runService.SaveRun(run);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Save Details')),
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
