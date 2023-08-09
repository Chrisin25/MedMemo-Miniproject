import 'package:flutter/material.dart';
import 'package:medical_reminder/dbfunctions.dart';
import 'package:medical_reminder/pages/appointment.dart';
import 'package:medical_reminder/pages/login.dart';
import 'package:medical_reminder/pages/loginpage.dart';
import 'package:medical_reminder/pages/records.dart';
import 'package:medical_reminder/pages/scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/medicinerem.dart';
import 'pages/medrecords.dart';
String user='';
username(String name){
      user=name;
    }
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(child:Column(children: [Icon(Icons.account_box),Text(user)],)
            ),
            ListTile(
              title: Text("Routines"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => const MedicineRem(),
    ),);
              },
            ),
            
            ListTile(
              title: Text("Appointments"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => AppointmentsPage(),
    ),);
              },
            ),
            ListTile(
              title: Text("Prescription scanner"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => ScannerPage(),
    ),);
              },
            ),
            
            ListTile(
              title: Text("Files"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => RecordsPage(),
    ),);
              },
            ),
            ListTile(
              title: Text("Sign Out"),
              onTap: (){
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );},
            )
          ],
        ),
        
        
      );
  }
}
//sets logged in status to false and navigate to login screen
signout(BuildContext ctx) async{
               final _sharedPrefs= await SharedPreferences.getInstance();
               _sharedPrefs.clear();
                Navigator.of(ctx).pushAndRemoveUntil(
                  MaterialPageRoute<void>(builder: (BuildContext context) => LoginScreen(), ),
                  (route)=>false
                );
         }