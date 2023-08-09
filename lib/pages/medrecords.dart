import 'package:flutter/material.dart';
import '../drawer.dart';
import 'medicinerem.dart';
class medrec extends StatelessWidget {
  const medrec({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => const MedicineRem(),
    ),);
          
        }, icon: Icon(Icons.home)),
        title: Text("medrec"),
      ),
      endDrawer: MyDrawer(),
      body: Text("medical records"),
    );
  }
}