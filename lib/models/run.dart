class Run {
  int? id;
  String? name;
  String? date;
  num? distance;
  num? durationminutes;
  num? averagespeed;

  runMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['date'] = date;
    mapping['distance'] = distance;
    mapping['durationminutes'] = durationminutes;
    mapping['averagespeed'] = averagespeed;
    return mapping;
  }
}
