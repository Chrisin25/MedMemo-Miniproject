import 'package:flutter/material.dart';
import 'package:medical_reminder/pages/medicinerem.dart';
import 'package:medical_reminder/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginpage.dart';

const SAFE_KEY_NAME="UserLoggedIn";// to check log in status

//splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    chkUserLoggedIn();
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/medlogo.jpg',height: 500,),),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  //navigate to login screen
  Future<void> gotologin() async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>LoginPage()));
  }
  //function to check if user is already logged in,if so user does not have to log in
  Future<void> chkUserLoggedIn() async{
    final _sharedprefs= await SharedPreferences.getInstance();
    final UserLoggedIn =_sharedprefs.getBool(SAFE_KEY_NAME);
    //userloggedin is null when the app starts for the first time
    if(UserLoggedIn==null || UserLoggedIn==false){
      gotologin();//go to login screen
    }
    else{
      //user already logged in..directly go to home screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>MedicineRem()));
    }
  }
}