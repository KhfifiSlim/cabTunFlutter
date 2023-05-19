import 'package:flutter/material.dart';
import 'package:flutter_login_register_nodejs/styles/colors.dart';
import 'package:flutter_login_register_nodejs/styles/styles.dart';
import '../services/api_service.dart';

import '../services/shared_service.dart';

List<Map> doctors = [
  {
    'img': 'assets/doctor03.jpeg',
    'doctorName': 'Dr. Rosa Williamson',
    'doctorTitle': 'Skin Specialist'
  }
];

class HomeTab extends StatelessWidget {
  final void Function() onPressedScheduleCard;
  final String usernameSet; // New parameter

  const HomeTab({
    Key? key,
    required this.onPressedScheduleCard,
    required this.usernameSet, // Add new parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            UserIntro(usernameSet: usernameSet),
            SizedBox(
              height: 10,
            ),
            SearchInput(),
            SizedBox(
              height: 20,
            ),
            CategoryIcons(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Les réservations',
                  style: kTitleStyle,
                ),
                TextButton(
                  child: Text(
                    '',
                    style: TextStyle(
                      color: Color(MyColors.yellow01),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/ScheduleTab');
                  },
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            AppointmentCard(
              onTap: onPressedScheduleCard,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Notre Docteur',
              style: TextStyle(
                color: Color(MyColors.header01),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TopDoctorCard(
              img: 'assets/doctor03.jpeg',
              doctorName: "Dr . Ben Mohamed",
              doctorTitle: "Skin Specialist",
            )
          ],
        ),
      ),
    );
  }
}

class TopDoctorCard extends StatelessWidget {
  String img;
  String doctorName;
  String doctorTitle;

  TopDoctorCard({
    required this.img,
    required this.doctorName,
    required this.doctorTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/detail');
        },
        child: Row(
          children: [
            Container(
              color: Color(MyColors.grey01),
              child: Image(
                width: 100,
                image: AssetImage(img),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: TextStyle(
                    color: Color(MyColors.header01),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  doctorTitle,
                  style: TextStyle(
                    color: Color(MyColors.grey02),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Color(MyColors.yellow02),
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '4.0 - 50 Reviews',
                      style: TextStyle(color: Color(MyColors.grey02)),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final void Function() onTap;
  static String usernameconnect = "username";

  const AppointmentCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(MyColors.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/doctor01.jpeg'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dr.Muhammed',
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Dental Specialist',
                              style: TextStyle(color: Color(MyColors.text01)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ScheduleCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg02),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg03),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

List<Map> categories = [
  {'icon': Icons.calendar_month, 'text': 'Prend rendez-vous'},
  {'icon': Icons.local_hospital, 'text': 'Mes réservations'},
];

class CategoryIcons extends StatelessWidget {
  const CategoryIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CategoryIcon(
            icon: Icons.calendar_month,
            text: 'Prend rendez-vous',
            url: "/rendezvous"),
        CategoryIcon(
            icon: Icons.local_hospital,
            text: 'Mes réservations',
            url: "/ScheduleTab"),
      ],
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg01),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Mon, July 29',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              '11:00 ~ 12:10',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  IconData icon;
  String text;
  String url;

  CategoryIcon({
    required this.icon,
    required this.text,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Color(MyColors.bg01),
      onTap: () {
        Navigator.pushNamed(context, url);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(MyColors.bg),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: Color(MyColors.primary),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: Color(MyColors.primary),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(MyColors.bg),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(
              Icons.search,
              color: Color(MyColors.purple02),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Rechercher ...',
                hintStyle: TextStyle(
                    fontSize: 13,
                    color: Color(MyColors.purple01),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserIntro extends StatelessWidget {
  static String usernameconnect = "user";

  final usernameSet;

  const UserIntro({Key? key, required this.usernameSet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> fetchUserProfile() async {
      try {
        final response = await APIService.getUserProfile();
        // email = response['email'];
        usernameconnect = response['username'];
        print('userconnected : ${usernameconnect}');
        // tel = response['tel'].toString();
      } catch (error) {
        print(error);
      }
    }

// Call the function
    fetchUserProfile();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        //crossAxisAlignment: CrossAxisAlignment.start,
        //children: const [
        new Text(
          'Bonjour ',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        new Text(
          '$usernameSet 👋',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),

        new IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
          onPressed: () {
            SharedService.logout(context);
          },
        ),

        new GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/aa.jpg'),
          ),
        ),
      ],
    );
  }
}
