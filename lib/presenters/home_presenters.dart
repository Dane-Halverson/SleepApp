
import '../models/models.dart';
import '../models/statistics.dart';
import '../views/home.dart';

class HomePresenter {
  late final HomeStatefulWidgetState _view;
  late final UserModel _model;
  late StatisticsModel _statisticsModel;
  late bool _alreadyQueried;

  HomePresenter(HomeStatefulWidgetState view, UserModel model) {
    this._view = view;
    this._model = model;
    this._alreadyQueried = false;
  }

  Future<StatisticsModel> getStatisticsData() async {
    if (!_alreadyQueried) {
      _alreadyQueried = true;
      this._statisticsModel = await StatisticsModel.create(this._model);
    }
    return _statisticsModel;
  }
}
