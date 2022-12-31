// ignore_for_file: file_names

import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        FontWeight,
        Icon,
        Icons,
        InputDecoration,
        Key,
        Navigator,
        OutlineInputBorder,
        Row,
        Scaffold,
        SingleChildScrollView,
        SizedBox,
        State,
        StatefulWidget,
        Text,
        TextButton,
        TextEditingController,
        TextField,
        TextStyle,
        Widget,
        showDatePicker;
import 'package:intl/intl.dart';
import 'package:runningtracker/models/run.dart';
import 'package:runningtracker/services/runService.dart';

class EditRun extends StatefulWidget {
  /// Run to be edited
  final Run run;
  const EditRun({Key? key, required this.run}) : super(key: key);

  @override
  State<EditRun> createState() => _EditRunState();
}

class _EditRunState extends State<EditRun> {
  /// Controllers for validation
  final _runNameController = TextEditingController();
  final _runDateController = TextEditingController();
  final _runDistanceController = TextEditingController();
  final _runDurationController = TextEditingController();

  /// Validation flag
  bool _validateName = false;
  bool _validateDate = false;
  bool _validateDistance = false;
  bool _validateDuration = false;

  /// Service for CRUD functions
  final _runService = RunService();

  @override
  void initState() {
    setState(() {
      _runNameController.text = widget.run.name ?? '';
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
        title: const Text("Running Tracker"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Run #${widget.run.id}',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue[800],
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _runDateController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                    hintText: 'Date',
                    labelText: 'Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('dd.MM.yyyy').format(pickedDate);

                    setState(() {
                      _runDateController.text = formattedDate;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _runNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Name',
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Name value can\'t be empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _runDistanceController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Distance',
                    labelText: 'Distance',
                    errorText: _validateDistance
                        ? 'Distance value can\'t be empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  key: const Key("duration"),
                  controller: _runDurationController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Duration',
                    labelText: 'Duration',
                    errorText: _validateDuration
                        ? 'Duration value can\'t be empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue[800],
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _runNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _runDateController.text.isEmpty
                              ? _validateDate = true
                              : _validateDate = false;
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
                            _validateDuration == false &&
                            _validateDate == false) {
                          var run = Run();
                          run.id = widget.run.id;
                          run.name = _runNameController.text;
                          run.date = _runDateController.text;
                          run.distance =
                              double.parse(_runDistanceController.text);
                          run.durationminutes =
                              int.parse(_runDurationController.text);
                          run.averagespeed =
                              run.distance! / (run.durationminutes! / 60);
                          var result = await _runService.updateRun(run);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Update Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
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
