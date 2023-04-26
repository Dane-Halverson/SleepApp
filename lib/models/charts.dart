import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:units/AppColors.dart';

import './statistics.dart';

abstract class ChartModel<T extends StatefulWidget, D extends ChartSeries> {
  T createView({
    required String title,
    required ChartAxis xAxis,
    required bool legendVisible
  });
}

class CartesianChartModel<T extends XyDataSeries<dynamic, dynamic>> extends
ChartModel<SfCartesianChart, XyDataSeries> {
  late final List<T> _series;

  CartesianChartModel(List<T> series) {
    this._series = series;
  }

  @override
  SfCartesianChart createView({required String title, required ChartAxis xAxis, required bool legendVisible}) {
    return new SfCartesianChart(
      primaryXAxis: xAxis,
      title: ChartTitle(text: title, textStyle: TextStyle(color: AppColors.accentLight, fontSize: 16)),
      series: this._series,
      legend: Legend(isVisible: legendVisible, textStyle: TextStyle(color: AppColors.accentLight)),
      plotAreaBorderColor: AppColors.accentLight,
      plotAreaBackgroundColor: AppColors.darkAccent,
    );
  }
}

List<XyDataSeries<ChartData<X>, X>> _cartesianDataSeriesFactory<X>(String type, List<List<ChartData<X>>> data, List<String> seriesNames) {
  int nameIdx = 0;
  final colors = <Color>[
    AppColors.accent,
    AppColors.primary,
    Color.fromRGBO(125, 247, 203, 1),
  ];
  switch(type) {
    case 'bar':
      List<BarSeries<ChartData<X>, X>> series = [];
      for (var dataSeries in data) {
        final name = seriesNames.length > 0 ? seriesNames[nameIdx] : 'series $nameIdx';
          series.add(new BarSeries<ChartData<X>, X>(
            name: name,
            dataSource: dataSeries,
            xValueMapper: (ChartData<X> data, _) => data.x,
            yValueMapper: (ChartData<X> data, _) => data.y,
            color: colors[nameIdx],
            trackColor: AppColors.accentLight
        ));
        nameIdx++;
      }
      return series;
    case 'line':
      List<LineSeries<ChartData<X>, X>> series = [];
      for (var dataSeries in data) {
        final name = seriesNames.length > 0 ? seriesNames[nameIdx] : 'series $nameIdx';
        series.add(new LineSeries<ChartData<X>, X>(
          name: name,
          dataSource: dataSeries,
          xValueMapper: (ChartData<X> data, _) => data.x,
          yValueMapper: (ChartData<X> data, _) => data.y,
          color: colors[nameIdx]
        ));
        nameIdx++;
      }
      return series;
    case 'stacked column':
      List<StackedColumnSeries<ChartData<X>, X>> series = [];
      for (var dataSeries in data) {
        final name = seriesNames.length > 0 ? seriesNames[nameIdx] : 'series $nameIdx';
        series.add(new StackedColumnSeries<ChartData<X>, X>(
          name: name,
          dataSource: dataSeries,
          xValueMapper: (ChartData<X> data, _) => data.x,
          yValueMapper: (ChartData<X> data, _) => data.y,
          color: colors[nameIdx],
        ));
        nameIdx++;
      }
      return series;
    default:
      throw new Error();
  }
}

CartesianChartModel _cartesianChartModelFactory<X>(String type, List<List<ChartData<X>>> data, List<String> seriesNames) {
  final series = _cartesianDataSeriesFactory<X>(type, data, seriesNames);
  switch(type) {
    case 'bar':
      return new CartesianChartModel<BarSeries>(
        series as List<BarSeries<ChartData<X>, X>>
      );
    case 'line':
      return new CartesianChartModel<LineSeries>(
        series as List<LineSeries<ChartData<X>, X>>
      );
    case 'stacked column':
      return new CartesianChartModel<StackedColumnSeries>(
        series as List<StackedColumnSeries<ChartData<X>, X>>
      );
    default:
      throw new Error();
  }
}

ChartModel chartModelFactory<X>(String type, String subType, List<List<ChartData<X>>> data, List<String> seriesNames) {
  switch(type) {
    case 'cartesian':
      return _cartesianChartModelFactory(subType, data, seriesNames);
    default:
      throw new ErrorDescription('$type, is not a valid chart type!');
  }
}