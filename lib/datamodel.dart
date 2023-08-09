import 'package:flutter/material.dart';

class medicineModel {
  String medName;
  String type;
  String dosage;
  int? timesADay;
  int id;
  String startdate;
  String enddate;
  String? starttime;
  
  medicineModel({required this.medName,required this.type,required this.dosage,this.timesADay,required this.startdate,required this.enddate,this.starttime,required this.id});
  Map<String,dynamic> toMap(){
    var map=<String,dynamic>{
      "medName":medName,
      "type":type,
      "dosage":dosage,
      "timesADay":timesADay,
      "startdate":startdate,
      "enddate":enddate,
      "starttime":starttime,
      "id":id

    };
    return map;
  }
 
 static medicineModel fromMap(Map<String, Object?> map) {
    final medName = map['medName'] as String?;
    final type=map['type'] as String?;
    final dosage = map['dosage'] as String?;
    final timesADay=map['timesADay'] as int?;
    final startdate=map['startdate'] as String?;
    final enddate=map['enddate'] as String?;
    final starttime=map['starttime'] as String?;
    final id=map['id'] as int?;
    
    return medicineModel(
      medName: medName ?? '', // Assign an empty string if medName is null
      dosage: dosage ?? '', // Assign 0 if dosage is null
      startdate: startdate ?? '',
      enddate: enddate ?? '',
      type: type ?? 'PILL',
      id: id ?? 0
    );
  }
}
 