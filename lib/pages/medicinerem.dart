
import 'package:flutter/material.dart';
import 'package:medical_reminder/datamodel.dart';
import 'package:medical_reminder/dbfunctions.dart';
import 'package:medical_reminder/pages/addmedicine.dart';
import 'package:medical_reminder/pages/dashboard.dart';
import 'package:table_calendar/table_calendar.dart';
import '../drawer.dart';
import 'details.dart';
var i;
class MedicineRem extends StatefulWidget {
  const MedicineRem({super.key});

  @override
  State<MedicineRem> createState() => _MedicineRemState();
}

class _MedicineRemState extends State<MedicineRem> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  callsetdate(DateTime day){
      setdate(day);
    }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
      title: Text("MedMemo"),
      ),
      endDrawer:  MyDrawer(),
      body:Stack(
        children:[
          
          Column(
            children: [
              SizedBox(height: 25,),
              //calendar
              TableCalendar(
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2050),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: callsetdate(_selectedDay),
              calendarStyle: CalendarStyle(todayDecoration: BoxDecoration(color: Colors.blue[200],shape: BoxShape.circle),selectedDecoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),),
        ),
            ],
          ),
        reminderlist(),
        ]
      ),
      
    );
    
  }
}

Widget reminderlist(){
  
  return DraggableScrollableSheet(
             
             initialChildSize : 0.6,
             minChildSize : 0.1,
             maxChildSize : 1.0,
             builder: (BuildContext context, ScrollController scrollController)
             {
             return Container(
              padding: EdgeInsets.all(10),
              decoration:BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blueGrey[700]),
              child: Column(
               children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('Routine',style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold,color: Colors.white),),
                  FloatingActionButton(onPressed:(){
                    //addremdialog(context);
                    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => AddMedicine(),
    ),);
                  },
                  child: Icon(Icons.add) ,)]),
                 
                 const Expanded(child: listmedicinewdgt()),

               ],
                  ),
             );
            }
              
            );
}

class listmedicinewdgt extends StatelessWidget {
  const listmedicinewdgt({super.key});
  
  @override
  Widget build(BuildContext context) {
    getallmed();
    return ValueListenableBuilder(
      valueListenable: medlistnotifier,
      builder: (BuildContext ctx, List<medicineModel> medlist, Widget? child){
        if(medlist.length!=0)
        {return ListView.builder(
          itemCount: medlist.length,
          itemBuilder: (ctx,index){
            final data=medlist[index];
            
            return Card(
               elevation: 5,
               child: ListTile(
                title: Text(data.medName),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text('Dosage:'),
                        Text(data.dosage.toString()),
                      ],
                    ),
                    Row(children:[
                      Text('Type:'),
                      Text(data.type.toString()),
                    IconButton(onPressed: (){
                      deletemedicine(data.id);
                      }, icon: Icon(Icons.delete))
                    
                    ])
                  ],
                ),
                onTap: (){
                  i=index;
                  Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => const Details()));
                },
               ),
            );
          },
        
      );
        }
        else{
          return Text('add reminders !!!');
        }
      },
       
    );
  }
}