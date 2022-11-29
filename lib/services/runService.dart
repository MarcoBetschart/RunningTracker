import 'dart:async';

import 'package:runningtracker/db_helper/repository.dart';
import 'package:runningtracker/models/run.dart';

class RunService {
  late Repository _repository;
  RunService() {
    _repository = Repository();
  }
  //Save Run
  SaveRun(Run run) async {
    return await _repository.insertData('runningTracker', run.runMap());
  }

  //Read All Runs
  readAllRuns() async {
    return await _repository.readData('runningTracker');
  }

  //Edit Run
  UpdateRun(Run run) async {
    return await _repository.updateData('runningTracker', run.runMap());
  }

  deleteRun(runId) async {
    return await _repository.deleteDataById('runningTracker', runId);
  }
}
