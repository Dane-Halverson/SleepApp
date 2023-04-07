import 'package:units/views/statistics.dart';

import '../models/models.dart';
import '../models/statistics.dart';
import '../views/home.dart';

class HomePresenter {
  late final HomeStatefulWidgetState _view;
  late final UserModel _model;

  HomePresenter(HomeStatefulWidgetState view, UserModel model) {
    this._view = view;
    this._model = model;
  }

  Future<StatisticsModel> getStatisticsData() async {
    return await StatisticsModel.create(this._model);
  }
}
