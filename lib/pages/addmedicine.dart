import 'package:flutter/material.dart';
import 'package:medical_reminder/datamodel.dart';
import 'package:medical_reminder/dbfunctions.dart';
import 'package:intl/intl.dart';

import 'medicinerem.dart';
import 'notification.dart';
int index=0;
DateTime start=DateTime.now();
DateTime end=DateTime.now();
TimeOfDay t=TimeOfDay.now();
class AddMedicine extends StatelessWidget {
  const AddMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    final _mednamecntrlr=TextEditingController();
    final _dosagecntrlr=TextEditingController();
    final _starttimecntrlr=TextEditingController();
    final _startdatecntrlr=TextEditingController();
    final _enddatecntrlr=TextEditingController();
    final _timesadaycntrlr=TextEditingController();
    const List<String> list = <String>["PILL","SYRUP"];
    String dropdownValue = list.first;
    
    return  Scaffold(
      appBar: AppBar(
        title: Text("add medicine"),
      ),
      body: Form(
        child:SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              TextField(
                controller: _mednamecntrlr,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'medicine name'
                ),
              ),
              SizedBox(height: 10,),
              DropdownButtonFormField(
              hint: Text("medicine type"),
              decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0))),
              isExpanded: true,
               value: dropdownValue,
               onChanged: (String? value) {
                dropdownValue = value!;
               },
               items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                value: value,
               child: Text(value),
              );
              }).toList(),
              ),
              SizedBox(height: 10,),
            TextField(
              controller: _dosagecntrlr,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'dosage'
            )
            ),
            //timesa day
            SizedBox(height: 10,),
            TextField(
              controller: _timesadaycntrlr,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'times a day'
            )
            ),
            SizedBox(height: 10,),
            //starttime
            TextField(
              keyboardType: TextInputType.none,
              controller: _starttimecntrlr,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'start time'
            ),
            onTap: ()async{
              TimeOfDay? pickedtime=await showTimePicker(context: context, initialTime: TimeOfDay.now());
              if (pickedtime != null) {
                t=pickedtime;
                _starttimecntrlr.text =pickedtime.format(context);
                
              }
            },
            ),
            SizedBox(height: 10,),
            //start date
            TextField(
              keyboardType: TextInputType.none,
              controller: _startdatecntrlr,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'start date'
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2050));
        
              if (pickedDate != null) {
                start=pickedDate;
                _startdatecntrlr.text =DateFormat("yyyy-MM-dd").format(pickedDate);
              }
                }
            ),
            SizedBox(height: 10,),
            //enddate
            TextField(
              keyboardType: TextInputType.none,
              controller: _enddatecntrlr,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'end date'
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2050));
        
              if (pickedDate != null) {
                end=pickedDate;
                _enddatecntrlr.text =DateFormat("yyyy-MM-dd").format(pickedDate);
              }
                }
            ),
            SizedBox(height: 30,),
            FloatingActionButton.extended(
              onPressed: () async {
                final medicine=medicineModel(medName: _mednamecntrlr.text,type: dropdownValue,dosage: _dosagecntrlr.text,timesADay: int.parse(_timesadaycntrlr.text),startdate: _startdatecntrlr.text,enddate: _enddatecntrlr.text,starttime: _starttimecntrlr.text,id:index);
                index++;
                await addmedicine(medicine,start,end,t);
                await getallmed();
                await scheduleNotification(t,_mednamecntrlr.text,start,end);
                //await scheduleMedicineNotifications(medicine, start, end, t);
                Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => const MedicineRem(),
    ),);
              }, 
              label: Text("add"),icon: Icon(Icons.add),)
            ],
            )
            ),
          
      ),
      
      
      
    );
  }
}