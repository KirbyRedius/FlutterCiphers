import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EntropyChartScreen extends StatelessWidget {
  final List<double> hkOverKValues;

  const EntropyChartScreen({
    super.key,
    required this.hkOverKValues,
  });

  @override
  Widget build(BuildContext context) {
    final List<EntropyData> data = [];
    for (int k = 1; k <= hkOverKValues.length; k++) {
      data.add(EntropyData(k, hkOverKValues[k - 1]));
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
      ),
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(title: AxisTitle(text: 'k')),
        primaryYAxis: const NumericAxis(title: AxisTitle(text: 'Hk/k')),
        series: <CartesianSeries>[
          LineSeries<EntropyData, int>(
            dataSource: data,
            xValueMapper: (EntropyData data, _) => data.k,
            yValueMapper: (EntropyData data, _) => data.hkOverK,
            name: 'Энтропия',
            markerSettings: const MarkerSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

/// Класс для хранения данных графика
class EntropyData {
  final int k;
  final double hkOverK;

  EntropyData(this.k, this.hkOverK);
}
