import 'package:flutter/material.dart';
import 'package:medical_reminder/pages/addmedicine.dart';
import 'package:medical_reminder/pages/dashboard.dart';
import 'package:medical_reminder/pages/medicinerem.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:medical_reminder/pages/splash.dart';

import 'dbfunctions.dart';


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   tz.initializeTimeZones();
  await opendb();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.lightBlue),
      home: SplashScreen(),
      routes: {
        "/dashboard":(context)=>DashboardPage()
      },

    );
  }
}





