import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vsc/pages/home_page.dart';
import 'package:vsc/pages/login_page.dart';
import 'package:vsc/pages/util/introductionscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://mhfnttlxzmusbqdnyuum.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1oZm50dGx4em11c2JxZG55dXVtIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwNzMzMjM2MywiZXhwIjoyMDIyOTA4MzYzfQ.KUkkkp6nutcdt_t2LFvcYbHeE9xsW5wywzxT6qd51kM',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        //theme: Provider.of<ThemeProvider>(context).themeDate,

        theme: ThemeData(primarySwatch: Colors.red));
  }
}
