import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

import './statistics.dart';

abstract class ChartModel<T extends StatefulWidget, D extends ChartSeries> {
  T createView({
    required String title,
    required ChartAxis xAxis
  });
}

class CartesianChartModel<T extends XyDataSeries<dynamic, dynamic>> extends
ChartModel<SfCartesianChart, XyDataSeries> {
  late final List<T> _series;

  CartesianChartModel(List<T> series) {
    this._series = series;
  }

  @override
  SfCartesianChart createView({required String title, required ChartAxis xAxis}) {
    return new SfCartesianChart(
      primaryXAxis: xAxis,
      title: ChartTitle(text: title),
      series: this._series,
      
    );
  }
}

List<XyDataSeries<ChartData<X>, X>> _cartesianDataSeriesFactory<X>(String type, List<List<ChartData<X>>> data) {
  switch(type) {
    case 'bar':
      List<BarSeries<ChartData<X>, X>> series = [];
      for (var dataSeries in data) {
          series.add(new BarSeries<ChartData<X>, X>(
            dataSource: dataSeries,
            xValueMapper: (ChartData<X> data, _) => data.x,
            yValueMapper: (ChartData<X> data, _) => data.y
        ));
      }
      return series;
    case 'line':
      List<LineSeries<ChartData<X>, X>> series = [];
      for (var dataSeries in data) {
        series.add(new LineSeries<ChartData<X>, X>(
          dataSource: dataSeries,
          xValueMapper: (ChartData<X> data, _) => data.x,
          yValueMapper: (ChartData<X> data, _) => data.y
        ));
      }
      return series;
    case 'stacked column':
        List<StackedColumnSeries<ChartData<X>, X>> series = [];
        for (var dataSeries in data) {
          series.add(new StackedColumnSeries<ChartData<X>, X>(
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

CartesianChartModel _cartesianChartModelFactory<X>(String type, List<List<ChartData<X>>> data) {
  final series = _cartesianDataSeriesFactory<X>(type, data);
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

ChartModel chartModelFactory<X>(String type, String subType, List<List<ChartData<X>>> data) {
  switch(type) {
    case 'cartesian':
      return _cartesianChartModelFactory(subType, data);
    default:
      throw new ErrorDescription('$type, is not a valid chart type!');
  }
}