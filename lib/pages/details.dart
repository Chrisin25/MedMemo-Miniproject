import 'package:flutter/material.dart';
import 'package:medical_reminder/datamodel.dart';
import 'package:medical_reminder/dbfunctions.dart';
import 'package:medical_reminder/pages/medicinerem.dart';
var pic;

class Details extends StatelessWidget {
  const Details({super.key});
  
  @override
  Widget build(BuildContext context) {
  medicineModel m=medlistnotifier.value.elementAt(i);
  if(m.type=="PILL"){
          
    pic= 'assets/pill.jpg';
  }
  else if(m.type=="SYRUP"){
    pic='assets/syrup.jpg';
  }
    return Scaffold(
      appBar: AppBar(
        title: Text(m.medName),
      ),
      body: Container(
        
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Image.asset(pic,height: 250,),
            SizedBox(height: 20,),
            Row(
              
              children: [Text("Type:  ",style: TextStyle(fontSize: 22),),Text(m.type,style: TextStyle(fontSize: 22),)
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [Text("Dosage:  ",style: TextStyle(fontSize: 22),),
              Text(m.dosage,style: TextStyle(fontSize: 22),)
              ],
            ),
            SizedBox(height: 10,),
            /*Row(
              children: [Text("Times a day:  ",style: TextStyle(fontSize: 22),),
              Text(m.timesADay.toString(),style: TextStyle(fontSize: 22),)
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [Text("Start time:  ",style: TextStyle(fontSize: 22),),
              Text(m.starttime.toString(),style: TextStyle(fontSize: 22),)
              ],
            ),
            SizedBox(height: 10,),*/
            Row(
              children: [Text("Start date:  ",style: TextStyle(fontSize: 22),),
              Text(m.startdate,style: TextStyle(fontSize: 22),)
              ],
            ),
            
            
          ],
        ),
      ),
    );
  }
}