# RunningTracker

```plantuml
@startuml
set namespaceSeparator ::

class "runningtracker::db_helper::database_connection.dart::DatabaseConnection" {
  +Future<Database> setDatabase()
  -Future<void> _createDatabase()
}

class "runningtracker::db_helper::repository.dart::Repository" {
  -DatabaseConnection _databaseConnection
  {static} -Database? _database
  +Future<Database?> database
  +dynamic insertData()
  +dynamic readData()
  +dynamic readDataById()
  +dynamic updateData()
  +dynamic deleteDataById()
}

"runningtracker::db_helper::repository.dart::Repository" o-- "runningtracker::db_helper::database_connection.dart::DatabaseConnection"
"runningtracker::db_helper::repository.dart::Repository" o-- "sqflite_common::sqlite_api.dart::Database"

class "runningtracker::main.dart::RunningTrackerHome" {
  +Widget build()
}

"flutter::src::widgets::framework.dart::StatelessWidget" <|-- "runningtracker::main.dart::RunningTrackerHome"

class "runningtracker::main.dart::MyHomePage" {
  +State<MyHomePage> createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "runningtracker::main.dart::MyHomePage"

class "runningtracker::main.dart::_MyHomePageState" {
  -List<Run> _runList
  -RunService _runService
  +dynamic getAllRunDetails()
  +void initState()
  -dynamic _showSuccessSnackBar()
  -dynamic _deleteFormDialog()
  +Widget build()
}

"runningtracker::main.dart::_MyHomePageState" o-- "runningtracker::services::runService.dart::RunService"
"flutter::src::widgets::framework.dart::State" <|-- "runningtracker::main.dart::_MyHomePageState"

class "runningtracker::main.dart::DrawerWidget" {
  +Widget build()
}

"flutter::src::widgets::framework.dart::StatelessWidget" <|-- "runningtracker::main.dart::DrawerWidget"

class "runningtracker::models::run.dart::Run" {
  +int? id
  +String? name
  +String? date
  +num? distance
  +num? durationminutes
  +num? averagespeed
  +dynamic runMap()
}

class "runningtracker::screens::addRun.dart::AddRun" {
  +State<AddRun> createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "runningtracker::screens::addRun.dart::AddRun"

class "runningtracker::screens::addRun.dart::_AddRunState" {
  -TextEditingController _runNameController
  -TextEditingController _runDateController
  -TextEditingController _runDistanceController
  -TextEditingController _runDurationController
  -bool _validateName
  -bool _validateDate
  -bool _validateDistance
  -bool _validateDuration
  -RunService _runService
  +Widget build()
}

"runningtracker::screens::addRun.dart::_AddRunState" o-- "flutter::src::widgets::editable_text.dart::TextEditingController"
"runningtracker::screens::addRun.dart::_AddRunState" o-- "runningtracker::services::runService.dart::RunService"
"flutter::src::widgets::framework.dart::State" <|-- "runningtracker::screens::addRun.dart::_AddRunState"

class "runningtracker::screens::averageSpeedChart.dart::AverageSpeedChart" {
  +State<AverageSpeedChart> createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "runningtracker::screens::averageSpeedChart.dart::AverageSpeedChart"

class "runningtracker::screens::averageSpeedChart.dart::_AverageSpeedChartState" {
  -List<Run> _runList
  -RunService _runService
  +dynamic getAllRunDetails()
  +void initState()
  +Widget build()
}

"runningtracker::screens::averageSpeedChart.dart::_AverageSpeedChartState" o-- "runningtracker::services::runService.dart::RunService"
"flutter::src::widgets::framework.dart::State" <|-- "runningtracker::screens::averageSpeedChart.dart::_AverageSpeedChartState"

class "runningtracker::screens::distanceChart.dart::DistanceChart" {
  +State<DistanceChart> createState()
}

"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "runningtracker::screens::distanceChart.dart::DistanceChart"

class "runningtracker::screens::distanceChart.dart::_DistanceChartState" {
  -List<Run> _runList
  -RunService _runService
  +dynamic getAllRunDetails()
  +void initState()
  +Widget build()
}

"runningtracker::screens::distanceChart.dart::_DistanceChartState" o-- "runningtracker::services::runService.dart::RunService"
"flutter::src::widgets::framework.dart::State" <|-- "runningtracker::screens::distanceChart.dart::_DistanceChartState"

class "runningtracker::screens::editRun.dart::EditRun" {
  +Run run
  +State<EditRun> createState()
}

"runningtracker::screens::editRun.dart::EditRun" o-- "runningtracker::models::run.dart::Run"
"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "runningtracker::screens::editRun.dart::EditRun"

class "runningtracker::screens::editRun.dart::_EditRunState" {
  -TextEditingController _runNameController
  -TextEditingController _runDateController
  -TextEditingController _runDistanceController
  -TextEditingController _runDurationController
  -bool _validateName
  -bool _validateDate
  -bool _validateDistance
  -bool _validateDuration
  -RunService _runService
  +void initState()
  +Widget build()
}

"runningtracker::screens::editRun.dart::_EditRunState" o-- "flutter::src::widgets::editable_text.dart::TextEditingController"
"runningtracker::screens::editRun.dart::_EditRunState" o-- "runningtracker::services::runService.dart::RunService"
"flutter::src::widgets::framework.dart::State" <|-- "runningtracker::screens::editRun.dart::_EditRunState"

class "runningtracker::screens::viewRuns.dart::ViewRuns" {
  +Run run
  +State<ViewRuns> createState()
}

"runningtracker::screens::viewRuns.dart::ViewRuns" o-- "runningtracker::models::run.dart::Run"
"flutter::src::widgets::framework.dart::StatefulWidget" <|-- "runningtracker::screens::viewRuns.dart::ViewRuns"

class "runningtracker::screens::viewRuns.dart::_ViewRunsState" {
  +Widget build()
}

"flutter::src::widgets::framework.dart::State" <|-- "runningtracker::screens::viewRuns.dart::_ViewRunsState"

class "runningtracker::services::runService.dart::RunService" {
  -Repository _repository
  +dynamic saveRun()
  +dynamic readAllRuns()
  +dynamic updateRun()
  +dynamic deleteRun()
}

"runningtracker::services::runService.dart::RunService" o-- "runningtracker::db_helper::repository.dart::Repository"


@enduml
```