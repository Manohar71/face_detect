import 'package:face_detect/home.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
//import 'package:page_transition/page_transition.dart';

List<CameraDescription>?cameras;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primarySwatch: Colors.white,
        primaryColor: Colors.red
      ),

      home:  AnimatedSplashScreen(
          duration: 3000,
          splash: Image.asset('assets/splash2.png',
              fit: BoxFit.contain,
          height: 500,
          width: 500),
          nextScreen: home(),
          splashTransition: SplashTransition.fadeTransition,
         //pageTransitionType: PageTransitionType.scale,
          backgroundColor: Colors.white)
    );
  }
}
