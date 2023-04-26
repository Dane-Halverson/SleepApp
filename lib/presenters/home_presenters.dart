
import '../models/behaviors.dart';
import '../models/models.dart';
import '../models/statistics.dart';
import '../views/home.dart';

class AllData {
  final BehaviorStatisitcsModel behaviors;
  final StatisticsModel sleep;

  AllData({
    required this.sleep,
    required this.behaviors
  });
}

class HomePresenter {
  late final HomeStatefulWidgetState _view;
  late final UserModel _model;
  late StatisticsModel _statisticsModel;
  late bool _alreadyQueried;

  UserModel get model => this._model;

  HomePresenter(HomeStatefulWidgetState view, UserModel model) {
    this._view = view;
    this._model = model;
    this._alreadyQueried = false;
  }

  String? get firstname => this._model.firstname;

  Future<StatisticsModel> getStatisticsData() async {
    if (!_alreadyQueried) {
      _alreadyQueried = true;
      this._statisticsModel = await StatisticsModel.create(this._model);
    }
    return _statisticsModel;
  }

  Future<AllData> fetchData() async {
    final StatisticsModel sleep = await this.getStatisticsData();
    final BehaviorStatisitcsModel behaviors = await this.getBehavioralData();

    return new AllData(sleep: sleep, behaviors: behaviors);
  }

  Future<SleepModel?> getSleepLogForDate(DateTime date) async {
    return await _model.getSleepDataForDate(date);
  }

  Future<BehaviorStatisitcsModel> getBehavioralData() async {
    return await BehaviorStatisitcsModel.create(this._model);
  }
}
