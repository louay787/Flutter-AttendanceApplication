import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:vsc/componenets/constants.dart';

class WorkStat extends StatefulWidget {
  final String name;
  final String role;
  final String workerName;
  final String imageUrl;
  final String id;

  const WorkStat({
    Key? key,
    required this.name,
    required this.role,
    required this.workerName,
    required this.imageUrl,
    required this.id,
  }) : super(key: key);

  @override
  _WorkStatState createState() => _WorkStatState();
}

class _WorkStatState extends State<WorkStat> {
  List<Map<String, dynamic>> attendanceData = [];
  List<FlSpot> chartData = [];

  Future<void> _fetchData() async {
    final response = await Supabase.instance.client
        .from('attendance')
        .select()
        .eq('user_id', widget.id)
        .gte('time', DateTime.now().subtract(Duration(days: 14)));

    if (mounted) {
      setState(() {
        attendanceData = response;
        _generateChartData();
      });
    }
  }

  void _generateChartData() {
    chartData = attendanceData.map((data) {
      final dateTime = DateTime.parse(data['time'] as String);
      final x = dateTime
          .difference(DateTime.now().subtract(Duration(days: 14)))
          .inDays
          .toDouble();
      final y = (dateTime.hour - 8) * 60 +
          dateTime.minute.toDouble(); // Convert time to minutes from 8 AM
      return FlSpot(x, y);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientEnd2,
      appBar: AppBar(
        title: Text('${widget.name}\ Profile'),
        backgroundColor: gradientEnd2,
      ),
      body: Column(
        children: [
          // Ychildren: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 12),
            height: 150,
            width: 150,
            decoration: const BoxDecoration(
              color: Colors.black54,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 2),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(70)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(widget.imageUrl),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text('Name: ${widget.name}',
                style: GoogleFonts.ubuntu(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
          ),
          Align(
            alignment: Alignment.center,
            child: Text('Role: ${widget.role}',
                style: GoogleFonts.ubuntu(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [gradientEnd2, gradientEnd2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: chartData,
                          isCurved: true,
                          barWidth: 2,
                          color: Colors.black,
                        ),
                      ],
                      minX: 0,
                      maxX: 16,
                      minY: 0,
                      maxY: 120, // Representing 8 AM to 10 AM in minutes
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                            getTitlesWidget: (value, meta) {
                              final date = DateTime.now()
                                  .subtract(Duration(days: 14 - value.toInt()));
                              return Text(DateFormat('MMMd').format(date));
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              final hours = (value ~/ 60) + 8; // Extract hours
                              final minutes =
                                  (value % 60).toInt(); // Extract minutes
                              return Text(
                                  '$hours:${minutes.toString().padLeft(2, '0')}');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
