import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

import './statistics.dart';

enum ChartType {
  bar,
  line,
}

/// TODO implement a presenter method to get the widget from 
abstract class ChartModel<T extends StatefulWidget, D extends ChartSeries> {
  T createView({
    required String title
  });
}

class CartesianChartModel<T extends XyDataSeries<dynamic, dynamic>> extends
ChartModel<SfCartesianChart, XyDataSeries> {
  late final List<T> _series;

  CartesianChartModel(List<T> series) {
    this._series = series;
  }

  @override
  SfCartesianChart createView({required String title}) {
    return new SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      title: ChartTitle(text: title),
      series: this._series
    );
  }
}

List<XyDataSeries<ChartData<X>, X>> _cartesianDataSeriesFactory<X>(ChartType type, List<List<ChartData<X>>> data) {
  switch(type) {
    case ChartType.bar:
      List<BarSeries<ChartData<X>, X>> series = [];
      for (var dataSeries in data) {
          series.add(new BarSeries<ChartData<X>, X>(
            dataSource: dataSeries,
            xValueMapper: (ChartData<X> data, _) => data.x,
            yValueMapper: (ChartData<X> data, _) => data.y
        ));
      }
      return series;
    case ChartType.line:
      List<LineSeries<ChartData<X>, X>> series = [];
      for (var dataSeries in data) {
        series.add(new LineSeries<ChartData<X>, X>(
          dataSource: dataSeries,
          xValueMapper: (ChartData<X> data, _) => data.x,
          yValueMapper: (ChartData<X> data, _) => data.y
        ));
      }
      return series;
    default:
      throw new Error();
  }
}

CartesianChartModel cartesianChartModelFactory<X>(ChartType type, List<List<ChartData<X>>> data) {
  final series = _cartesianDataSeriesFactory<X>(type, data);
  switch(type) {
    case ChartType.bar:
      return new CartesianChartModel<BarSeries>(
        series as List<BarSeries<ChartData<X>, X>>
      );
    case ChartType.line:
      return new CartesianChartModel<LineSeries>(
        series as List<LineSeries<ChartData<X>, X>>
      );
    default:
      throw new Error();
  }
}