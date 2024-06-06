import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vsc/componenets/constants.dart';

class LineChartPage extends StatefulWidget {
  const LineChartPage({Key? key}) : super(key: key);

  @override
  _LineChartPageState createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  // Assuming you have a list of data points for the line chart
  List<FlSpot> _chartData = [
    FlSpot(0, 1.5),
    FlSpot(1, 2.2),
    FlSpot(2, 2.8),
    FlSpot(3, 2.1),
    FlSpot(4, 1.9),
    FlSpot(5, 2.5),
    FlSpot(6, 2.2),
    FlSpot(7, 3.1),
    FlSpot(8, 2.5),
    FlSpot(9, 2.9),
    FlSpot(10, 3.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientEnd2,
      appBar: AppBar(
        backgroundColor: gradientEnd2,
        title: Text(''),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientEnd2, gradientEnd2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Line Chart Title',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Subtitle describing the chart',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'This is a description of the chart, providing context and insights about the data presented.',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: _chartData,
                        color: Colors.blue.shade800,
                        dotData: FlDotData(
                          show: false,
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blue.shade100,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade100,
                              Colors.blue.shade200,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                    gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.blue.shade200,
                        strokeWidth: 1,
                      ),
                      getDrawingVerticalLine: (value) => FlLine(
                        color: Colors.blue.shade200,
                        strokeWidth: 1,
                      ),
                    ),
                    minX: 0,
                    maxX: 10,
                    minY: 1,
                    maxY: 4,
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blue.shade200,
                          width: 2,
                        ),
                        left: BorderSide(
                          color: Colors.blue.shade200,
                          width: 2,
                        ),
                      ),
                    ),
                    clipData: FlTooltipData(
                      show: true,
                      getTooltipItems: (value) {
                        return value.map((spot) {
                          return FlTooltipItem(
                            '${spot.x.toInt()}, ${spot.y.toStringAsFixed(1)}',
                            child: Text(
                              '${spot.x.toInt()}, ${spot.y.toStringAsFixed(1)}',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FlTooltipData(
      {required bool show, required Function(dynamic value) getTooltipItems}) {}
}

class FlTooltipItem {
  FlTooltipItem(String s, {required Text child});
}
