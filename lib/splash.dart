import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursingpdq/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'qrcode.dart';
class MySplashScreen extends StatelessWidget {
  const MySplashScreen({super.key});

@override
Widget build(BuildContext context) {
	return GetMaterialApp(
	title: 'Splash Screen',
  theme: ThemeData(fontFamily: 'Raleway',primarySwatch: Colors.deepPurple),
	
	home: const MySplashPage(),
	debugShowCheckedModeBanner: false,
	);
}
}

class MySplashPage extends StatefulWidget {
  const MySplashPage({super.key});

@override
// ignore: library_private_types_in_public_api
_MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MySplashPage> {
@override
 final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var isLogin = false.obs;
    Future check() async {
   // SharedPreferences prefs = await SharedPreferences.getInstance();
  
    final SharedPreferences? prefs = await _prefs;
 Object key = await prefs?.getString('username') ?? false;
         print(key);
    // ignore: unnecessary_null_comparison
    if (key!=false) {
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const QRViewExample
        ()));
    } else {
      // ignore: use_build_context_synchronously
         Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInScreen()));
    }
  }
 @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      check();
    });
  }
@override
Widget build(BuildContext context) {
	return Scaffold(

 body: Stack(
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child:
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Kauverylogo.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
 
	);
}
}
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

@override
Widget build(BuildContext context) {
	return Scaffold(
	appBar: AppBar(title:const Text("GeeksForGeeks")),
	body: const Center(
		child:Text("Home page",textScaleFactor: 2,)
	),
	);
}
}
