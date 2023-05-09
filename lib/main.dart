import 'package:flutter/material.dart';
import 'package:flutter_login_register_nodejs/screens/doctor_detail.dart';
import 'package:flutter_login_register_nodejs/screens/home.dart';
import 'package:flutter_login_register_nodejs/screens/profile.dart';
import 'package:flutter_login_register_nodejs/screens/rendezvous.dart';
import 'package:flutter_login_register_nodejs/tabs/ScheduleTab.dart';

import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'screens/SplashScreen.dart';
import 'services/shared_service.dart';

Widget _defaultHome = const PageSplashScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get result of the login function.
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const LoginPage();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const LoginPage(),
      routes: {
        '/': (context) => _defaultHome,
        '/home': (context) => const Home(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/detail': (context) => SliverDoctorDetail(),
        '/profile': (context) => Profile(),
        '/rendezvous': (context) => DatePicker(),
        '/ScheduleTab': (context) => ScheduleTab(),
      },
    );
  }
}
