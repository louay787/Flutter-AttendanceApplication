import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vsc/componenets/constants.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final _future = Supabase.instance.client
      .from('attendance')
      .select('id, time, known, user: users(name, image_url)');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientEnd2,
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: gradientEnd2,
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final attendance = snapshot.data! as List<dynamic>;
          return SingleChildScrollView(
            child: Container(
              height: 850,
              width: 550,
              margin: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 15, right: 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: DataTable(
                columns: const [
                  //  DataColumn(label: Text('ID')),
                  DataColumn(
                      label: Text(
                    'CameraFeed',
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  )),
                  DataColumn(
                      label: Text(
                    'Name',
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  )),

                  DataColumn(
                      label: Text(
                    'Time',
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  )),
                ],
                rows: attendance.map((item) {
                  return DataRow(
                    cells: [
                      //DataCell(Text(item['id'].toString())),
                      DataCell(Image.network(item['user']['image_url'])),
                      DataCell(Text(
                        item['user']['name'],
                        style: GoogleFonts.ubuntu(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )),

                      DataCell(
                        Text(
                            DateFormat(
                              'yyyy-MM-dd HH:mm:ss',
                            ).format(DateTime.parse(item['time'])),
                            style: GoogleFonts.ubuntu(
                                color: Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.w600)),
                      ),

                      // DataCell(
                      //   FutureBuilder<String>(
                      //     future: Supabase.instance.client.storage
                      //         .from('images')
                      //         .createSignedUrl(item["user_id"] ?? '', 60),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.waiting) {
                      //         return CircularProgressIndicator();
                      //       } else if (snapshot.hasError) {
                      //         return Text(
                      //             'Error loading image: ${snapshot.error}');
                      //       } else {
                      //         return Image.network(snapshot.data!);
                      //       }
                      //     },
                      //   ),
                      // ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
