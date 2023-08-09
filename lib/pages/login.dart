import 'package:flutter/material.dart';
import 'package:medical_reminder/pages/medicinerem.dart';
import 'package:medical_reminder/pages/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final _usernameController =TextEditingController();

final _passwordController =TextEditingController();
bool _IsDataMatched=true;
final _formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(100),child: AppBar(title: const Text("MedMemo",style: TextStyle(fontSize: 30),),)),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0,right:30.0,top: 100.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'Username'),
              validator: (value){
                if(value==null || value.isEmpty){
                  return "value is empty";
                }
                else{
                  return null;
                }
        
              },
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'Password'),
              validator: (value){
                if(value==null || value.isEmpty){
                  return "value is empty";
                }
                else{
                  return null;
                }
              },
              ),
              SizedBox(height: 20,),
              Visibility(
                visible: !_IsDataMatched,
                child: Text('username and password doesnot match',style: TextStyle(color: Colors.red),)),
              ElevatedButton(
                onPressed: (){
                  if(_formkey.currentState!.validate()){
                     checklogin(context);
                  }
                  else{
                    //enter username and password 
                  }
                  
        
              }, 
              child: Text("Sign In",style: TextStyle(fontSize: 20),))
            ],
          ),
        ),
      ),
    );
  }
//checks if username and password match
  void checklogin(BuildContext ctx)async{
    final _username= _usernameController.text;
    final _password=_passwordController.text;
    if(_username==_password){
      //set userlogged in to true
      final _sharedPrefs=await SharedPreferences.getInstance();
      _sharedPrefs.setBool(SAFE_KEY_NAME, true);
      //go to home
      Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (ctx)=>MedicineRem()));
    }
    else{
      setState(() {
        _IsDataMatched=false;
      });
     }
  }
}