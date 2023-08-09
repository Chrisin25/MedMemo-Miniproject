import 'package:flutter/material.dart';
import 'package:medical_reminder/datamodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import 'pages/notification.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:timezone/timezone.dart' as tz;

ValueNotifier<List<medicineModel>> medlistnotifier =ValueNotifier([]);

late Database _db;
//late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future <void> opendb()async{
 _db= await openDatabase(
  'MedicineDB1456.db',
  version:1,
  onCreate:  (Database db, int version) async{
    await db.execute('CREATE TABLE MEDICINE(medName TEXT,type TEXT,dosage TEXT,timesADay INTEGER,startdate TEXT,enddate TEXT,starttime TEXT,id INT)');
    
  });
 /* flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  });*/
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
Future <void> addmedicine(medicineModel value,DateTime start,DateTime end,TimeOfDay t)async{
  
 final id = await _db.rawInsert('INSERT INTO MEDICINE(medName,type,dosage,timesADay,startdate,enddate,starttime,id) VALUES(?,?,?,?,?,?,?,?)',[value.medName,value.type,value.dosage,value.timesADay,value.startdate,value.enddate,value.starttime,value.id]);
  value.id = id;
  //await scheduleMedicineNotifications(value,start,end,t);
  
}

DateTime selected=DateTime.now();
setdate(DateTime day){
  selected=day;
  getallmed();
}

/*Future<void> scheduleMedicineNotifications(medicineModel medicine,DateTime start,DateTime end,TimeOfDay t) async {
  final int? timesADay = medicine.timesADay;
  if (timesADay == null) {
    return;
  }
  final int gapMinutes = timesADay == 3 ? 360 : 720;

  final DateTime now = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  final DateTime startDate =start; //dateFormat.parse(medicine.startdate);
  final DateTime endDate =end;// dateFormat.parse(medicine.enddate);
  final TimeOfDay startTime = t;//TimeOfDay.fromDateTime(
    //dateFormat.parse(medicine.starttime ?? ''),
 // );

  if (now.isBefore(startDate) || now.isAfter(endDate)) {
    return;
  }

  DateTime scheduledDateTime = DateTime(
    startDate.year,
    startDate.month,
    startDate.day,
    startTime.hour,
    startTime.minute,
  );
  

  while (
      scheduledDateTime.isBefore(endDate) && scheduledDateTime.isAfter(now)) {
    for (int i = 0; i < timesADay; i++) {
      scheduledDateTime = scheduledDateTime.add(Duration(minutes: gapMinutes));
      await flutterLocalNotificationsPlugin.zonedSchedule(
        medicine.id,
        'Time to take medicine',
        'It\'s time to take ${medicine.medName}',
        tz.TZDateTime.from(scheduledDateTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            'channel_description',
            importance: Importance.high,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: medicine.medName,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }
}*/

Future <void> getallmed()async{
  
  
  final _values=await _db.rawQuery('SELECT * FROM MEDICINE');
  
  medlistnotifier.value.clear();
  _values.forEach((map) { 
    final medicine = medicineModel.fromMap(map);
    DateTime start=DateFormat('yyyy-MM-dd').parse(medicine.startdate);
    DateTime end=DateFormat('yyyy-MM-dd').parse(medicine.enddate);
    if(start.isBefore(selected) && end.isAfter(selected))
    {medlistnotifier.value.add(medicine);
     medlistnotifier.notifyListeners();
    }
    
  }
  );
  
}


Future <void> deletemedicine(int id)async{
  await _db.delete('MEDICINE',where: 'id=?',whereArgs: [id]);
  //await flutterLocalNotificationsPlugin.cancel(id);
  getallmed();
}
class PillTrackerPage extends StatefulWidget {
  @override
  _PillTrackerPageState createState() => _PillTrackerPageState();
}

class _PillTrackerPageState extends State<PillTrackerPage> {
  int pillsRemaining = 0;

  void decrementPills() {
    if (pillsRemaining > 0) {
      setState(() {
        pillsRemaining--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pill Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pills Remaining: $pillsRemaining',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: decrementPills,
              child: Text('Take One Pill'),
            ),
          ],
        ),
      ),
    );
  }
}
