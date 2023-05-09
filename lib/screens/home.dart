import 'package:flutter/material.dart';
import 'package:flutter_login_register_nodejs/styles/colors.dart';
import 'package:flutter_login_register_nodejs/tabs/HomeTab.dart';
import 'package:flutter_login_register_nodejs/tabs/ScheduleTab.dart';
import '../services/api_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

List<Map> navigationBarItems = [
  {'icon': Icons.local_hospital, 'index': 0},
  {'icon': Icons.calendar_today, 'index': 1},
];

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String usernamepatient = "";

  void goToSchedule() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserProfile();

  }

  Future<void> fetchUserProfile() async {
    try {
      final response = await APIService.getUserProfile();
      usernamepatient = response['username'];
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> screens = [
      HomeTab(
        onPressedScheduleCard: goToSchedule,
        usernameSet: usernamepatient,
      ),
      ScheduleTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(MyColors.primary),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        selectedItemColor: Color(MyColors.primary),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          for (var navigationBarItem in navigationBarItems)
            BottomNavigationBarItem(
              icon: Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border(
                    top: _selectedIndex == navigationBarItem['index']
                        ? BorderSide(color: Color(MyColors.bg01), width: 5)
                        : BorderSide.none,
                  ),
                ),
                child: Icon(
                  navigationBarItem['icon'],
                  color: _selectedIndex == 0
                      ? Color(MyColors.bg01)
                      : Color(MyColors.bg02),
                ),
              ),
              label: '',
            ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() {
          _selectedIndex = value;
        }),
      ),
    );
  }
}
