// ignore_for_file: file_names

import 'package:runningtracker/db_helper/repository.dart' show Repository;
import 'package:runningtracker/models/run.dart';

/// Service class for CRUD methods
class RunService {
  late Repository _repository;
  RunService() {
    _repository = Repository();
  }

  /// Save run
  saveRun(Run run) async {
    return await _repository.insertData('runningTracker', run.runMap());
  }

  // Read all runs
  readAllRuns() async {
    return await _repository.readData('runningTracker');
  }

  /// Edit run
  updateRun(Run run) async {
    return await _repository.updateData('runningTracker', run.runMap());
  }

  /// delete run
  deleteRun(runId) async {
    return await _repository.deleteDataById('runningTracker', runId);
  }
}
