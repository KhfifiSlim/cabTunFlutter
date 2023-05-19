import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_register_nodejs/styles/colors.dart';
import 'package:flutter_login_register_nodejs/styles/styles.dart';
import '../services/api_service.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

List<Map<String, dynamic>> schedules = [];

enum FilterStatus { Encours, Complet, Annuler }

Future<List<Map<String, dynamic>>> fetchdates() async {
  List<Map<String, dynamic>> schedules = [];
  final response = await APIService.getReservation();
  print("Test");
  schedules = response as List<Map<String, dynamic>>;
  return schedules;
}

class _ScheduleTabState extends State<ScheduleTab> {
  FilterStatus status = FilterStatus.Encours;
  int currentStatus = 0;
  Alignment _alignment = Alignment.centerLeft;
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    List<Map<String, dynamic>> tab = await fetchdates();
    setState(() {
      schedules = tab;
    });
  }

  void _callApiFunction(String id) async {
    // Your API call code here
    print("Test confirmed");
    var response = await APIService.annulerReservation(id);
    if (response == "Success") {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (context, animation1, animation2) => ScheduleTab(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map> filteredSchedules = schedules.where((var schedule) {
      return schedule['status'] == currentStatus;
    }).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Mes réservations',
              textAlign: TextAlign.center,
              style: kTitleStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(MyColors.bg),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.Encours) {
                                  status = FilterStatus.Encours;
                                  currentStatus = 0;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.Complet) {
                                  status = FilterStatus.Complet;
                                  currentStatus = 1;
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.Annuler) {
                                  status = FilterStatus.Annuler;
                                  currentStatus = 2;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                filterStatus.name,
                                style: kFilterStyle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: Duration(milliseconds: 200),
                  alignment: _alignment,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  var _schedule = filteredSchedules[index];
                  bool isLastElement = filteredSchedules.length + 1 == index;
                  return Card(
                    margin: !isLastElement
                        ? EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   _schedule['name'],
                                  //   style: TextStyle(
                                  //     color: Color(MyColors.header01),
                                  //     fontWeight: FontWeight.w700,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(MyColors.bg03),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Color(MyColors.primary),
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      _schedule['date'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(MyColors.primary),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_alarm,
                                      color: Color(MyColors.primary),
                                      size: 17,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      _schedule['heure'],
                                      style: TextStyle(
                                        color: Color(MyColors.primary),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          if (currentStatus == 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    child: Text('Annuler'),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Confirmation'),
                                            content: Text(
                                                'Êtes-vous sûr de vouloir annuler la réservation ?'),
                                            actions: [
                                              TextButton(
                                                child: Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Confirm'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  // Call the API function with the id
                                                  _callApiFunction(
                                                      _schedule['id']);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  const DateTimeCard({
    Key? key,
    required String date,
    required String time,
  }) : super(key: key);

  String get date => date;
  String get time => time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: Color(MyColors.primary),
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                time,
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
