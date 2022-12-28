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
        TextInputType,
        TextStyle,
        Widget,
        showDatePicker;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:runningtracker/models/run.dart';
import 'package:runningtracker/services/runService.dart';

class AddRun extends StatefulWidget {
  const AddRun({Key? key}) : super(key: key);

  @override
  State<AddRun> createState() => _AddRunState();
}

class _AddRunState extends State<AddRun> {
  final _runNameController = TextEditingController();
  final _runDateController = TextEditingController();
  final _runDistanceController = TextEditingController();
  final _runDurationController = TextEditingController();
  bool _validateName = false;
  bool _validateDate = false;
  bool _validateDistance = false;
  bool _validateDuration = false;
  final _runService = RunService();

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
                'Add New Run',
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
                  key: const Key("name"),
                  controller: _runNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Name',
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  key: const Key("duration"),
                  controller: _runDistanceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                  ],
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Distance',
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                  ],
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Duration',
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
                          run.name = _runNameController.text;
                          run.date = _runDateController.text;
                          run.distance =
                              double.parse(_runDistanceController.text);
                          run.durationminutes =
                              double.parse(_runDurationController.text);
                          run.averagespeed =
                              run.distance! / (run.durationminutes! / 60);
                          var result = await _runService.saveRun(run);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Save Details')),
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
                        _runNameController.text = '';
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
