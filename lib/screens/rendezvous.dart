import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();


  String email = '';
  String usernamepatient = '';
  String tel = '';

  Future<void> _selectDate(BuildContext context) async {
    String selectdDateY = "";
    String DatenowY = "";


Future<void> fetchdates() async {
    try {
      final response = await APIService.getnondisp();
      
      print(response["result"]);
    } catch (error) {
      print(error);
    }
}

// Call the function
          final response = await APIService.getnondisp();

    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime date) {
        // Disable all days that have passed
        
        if (!date.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
          return false;
        }
        // Disable weekdays
       //   fetchdates();
        
         selectdDateY = "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
         DatenowY = "${date.year}/${date.month}/${date.day}";
         print(response["result"]);
         print(DatenowY);
         
        if(response["result"].contains(DatenowY)){
          return false;

        }
        
        if (date.weekday == 6 && selectdDateY != DatenowY) {
          return false;
        }
        
        if (date.weekday == 7 && selectdDateY != DatenowY) {
          return false;
        }
        
        return true;
      },
    );
    if (picked != null && picked != selectedDate ) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    Future<void> fetchUserProfile() async {
  try {
    final response = await APIService.getUserProfile();
    email = response['email'];
    usernamepatient = response['username'];
    tel = response['tel'].toString();
  } catch (error) {
    print(error);
  }
}

// Call the function
fetchUserProfile();

    return Scaffold(
      appBar: AppBar(
        title: Text('Prendre rendez-vous'),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              SizedBox(height: 20),
              // Input field for name
              
              TextField(
                 
                decoration: InputDecoration(
                  hintText: usernamepatient,
               
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                   controller: TextEditingController(text: usernamepatient),
                   enabled: false,
             
              ),
              SizedBox(height: 20),
              // Input field for email
              TextField(
                decoration: InputDecoration(
                  hintText: 'Adresse e-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: TextEditingController(text: email),
                enabled: false,
              ),
              SizedBox(height: 20),
              // Input field for message
              TextField(
                decoration: InputDecoration(
                  hintText: 'Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
               controller: TextEditingController(text: tel),
               enabled: false,
              ),
              SizedBox(height: 20),
              // Date picker button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => _selectDate(context),
                child: Text(
                  'Sélectionner une date',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Selected date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20),
               SizedBox(
  width: 430, // set the desired width here
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Color(0xff575de3),
      onPrimary: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(
      'Réserver',
      style: TextStyle(fontSize: 16),
    ),
    onPressed: () {
      // Handle form submission here
    },
  ),
),

            ],
          ),
        ),
      ),
    );
  }
}
