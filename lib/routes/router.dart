import 'package:flutter/material.dart';
import 'package:flutter_login_register_nodejs/screens/doctor_detail.dart';
import 'package:flutter_login_register_nodejs/screens/home.dart';
import 'package:flutter_login_register_nodejs/screens/profile.dart';
import 'package:flutter_login_register_nodejs/tabs/ScheduleTab.dart';

import '../pages/login_page.dart';
import '../screens/rendezvous.dart';

Widget _defaultHome = const LoginPage();
Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => _defaultHome,
  '/home': (context) => Home(),
  '/detail': (context) => SliverDoctorDetail(),
  '/profile': (context) => Profile(),
  '/rendezvous': (context) => DatePicker(),
  '/ScheduleTab': (context) => ScheduleTab(),
};
