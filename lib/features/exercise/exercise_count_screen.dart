import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:besports/features/exercise/count_model.dart';

class ExersiseCountScreen extends StatefulWidget {
  const ExersiseCountScreen({Key? key}) : super(key: key);

  @override
  State<ExersiseCountScreen> createState() => _ExersiseCountScreenState();
}

class _ExersiseCountScreenState extends State<ExersiseCountScreen> {
  static const int maxCount = 20;

  @override
  Widget build(BuildContext context) {
    final countModel = Provider.of<CountModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Count Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Center(
                // put image here
                child: Image.asset(
                  'images/exercise_1.jpeg',
                  width: 260,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  // position to the bottom
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color(0xff252624),
                ),
                child: Center(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      SfCircularChart(
                        series: <CircularSeries>[
                          // Renders doughnut chart
                          DoughnutSeries<ChartData, String>(
                            dataSource: <ChartData>[
                              ChartData(
                                  'Completed', countModel.count, Colors.green),
                              ChartData('Remaining',
                                  maxCount - countModel.count, Colors.grey),
                            ],
                            pointColorMapper: (ChartData data, _) => data.color,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: false),
                            innerRadius: '90%',
                          )
                        ],
                      ),
                      Text(
                        '${countModel.count} 회',
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}
