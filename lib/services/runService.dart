// ignore_for_file: file_names

import 'package:runningtracker/db_helper/repository.dart' show Repository;
import 'package:runningtracker/models/run.dart';

class RunService {
  late Repository _repository;
  RunService() {
    _repository = Repository();
  }
  //Save Run
  saveRun(Run run) async {
    return await _repository.insertData('runningTracker', run.runMap());
  }

  //Read All Runs
  readAllRuns() async {
    return await _repository.readData('runningTracker');
  }

  //Edit Run
  updateRun(Run run) async {
    return await _repository.updateData('runningTracker', run.runMap());
  }

  deleteRun(runId) async {
    return await _repository.deleteDataById('runningTracker', runId);
  }
}
