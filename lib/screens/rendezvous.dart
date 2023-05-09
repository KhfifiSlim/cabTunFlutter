import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import '../../config.dart';



class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  void initState() {
    super.initState();
    fetchUserProfile();
   // getHeureByDate();
  }

  static var client = http.Client();
List<String> heureFromApi = [];


List<String> heureReservation = ["09:00","09:30","10:00","10:30","11:00","11:30","13:30","14:00","14:30","15:00","15:30","16:00"];


String DateApi ="";
  
  Future<void> fetchUserProfile() async {
    try {
      final response = await APIService.getUserProfile();
      setState(() {
        email = response['email'];
        usernamepatient = response['username'];
        tel = response['tel'].toString();
      });
    } catch (error) {
      print(error);
    }
  }


 Future<String> insertReservation ( String name , String email , String num , String date , String heure ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
  var obj = {
    "name": name,
    "email": email,
    "num": num,
    "date": date,
    "heure": heure,
    "commentaire": "description test test"
};
    var url = Uri.http(
      Config.apiURL,
      Config.insertRes,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(obj),
    );
    var responseBody = jsonDecode(response.body);
    var message = responseBody['message'];
    //var token = responseBody['data']['token'];
    //debugPrint('Response body: ${message}');
    //debugPrint('Response body: ${token}');

    if (message == "Success") {
      print("ADD ");
    }else{
      return "error";
    }
    return "error";
  }


 Future<Object> getHeureByDateService() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var data = {"date": DateApi};
    var url = Uri.http(
      Config.apiURL,
      Config.getHeureByDate,
    );


    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(data),
    );
 

    var responseBody = jsonDecode(response.body);
    var message = responseBody['message'];
      print(message);
    if (message == "Success") {
      var responseBody = jsonDecode(response.body);
      var object = responseBody['data'];
      return object;

    }else{
      return {"error": "Error fetching heure."};
    }
  }
List<Widget> rowsOfButtons = [];

Future<void> fetchTimes() async {
List<Widget> rowsOfButtons = [];

for (int i = 0; i < heureReservation.length; i += 3) {
  List<Widget> buttons = [];

  for (int j = 0; j < 3 && i + j < heureReservation.length; j++) {
    bool isButtonDisabled = false;

    if(heureFromApi.contains(heureReservation[j])){
     isButtonDisabled = true;
}
    buttons.add(
      Expanded(
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff575de3),
              onPrimary: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              heureReservation[i + j],
              style: TextStyle(fontSize: 18),
            ),
            onPressed: isButtonDisabled
            ? null 
            : () {
              setState(() {
                selectedTime = heureReservation[i + j]; // Update the selected value
              });
            },
          ),
        ),
      ),
    );

    if (j < 2) {
      buttons.add(SizedBox(width: 20)); // Add spacing between buttons
    }
  }

  rowsOfButtons.add(
    Row(
      children: buttons,
    ),
  );
  rowsOfButtons.add(SizedBox(height: 15)); // Add spacing between buttons

}
}

   List<String> convertResponseToList(dynamic response) {
  List<String> resultList = [];
  if (response is List) {
    for (var item in response) {
      resultList.add(item.toString());
    }
  }
  return resultList;
}

   Future<void> getHeureByDate() async {
    try {
      final response = await getHeureByDateService();
     print(response);

     setState(() {
              heureFromApi = convertResponseToList(response);


 rowsOfButtons = [];

for (int i = 0; i < heureReservation.length; i += 3) {
  List<Widget> buttons = [];
  for (int j = 0; j < 3 && i + j < heureReservation.length; j++) {
    bool isButtonDisabled = false;

    if(heureFromApi.contains(heureReservation[i+j])){
     isButtonDisabled = true;
}
    buttons.add(
      Expanded(
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff575de3),
              onPrimary: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              heureReservation[i + j],
              style: TextStyle(fontSize: 18),
            ),
            onPressed: isButtonDisabled
            ? null 
            : () {
              setState(() {
                selectedTime = heureReservation[i + j]; // Update the selected value
              });
            },
          ),
        ),
      ),
    );

    if (j < 2) {
      buttons.add(SizedBox(width: 20)); // Add spacing between buttons
    }
  }

  rowsOfButtons.add(
    Row(
      children: buttons,
    ),
  );
  rowsOfButtons.add(SizedBox(height: 15)); // Add spacing between buttons

}
   ///////////////// END FOR
   print(rowsOfButtons.toString());  
    });
     
    } catch (error) {
      print(error);
    }
  }

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
         DatenowY = "${date.day}/${date.month}/${date.year}";
         print(response["result"]);

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
        DateApi = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
      });
    }
  }
String selectedTime = '';








  @override
  Widget build(BuildContext context) {

//     Future<void> fetchUserProfile() async {
//   try {
//     final response = await APIService.getUserProfile();
//     email = response['email'];
//     usernamepatient = response['username'];
//     tel = response['tel'].toString();
//   } catch (error) {
//     print(error);
//   }
// }
//
// // Call the function
// fetchUserProfile();
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
              SizedBox(height: 5),
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
              SizedBox(height: 5),
              
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
              SizedBox(height: 5),
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
              SizedBox(height: 10),
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
               SizedBox(height: 1),
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
                onPressed: () => getHeureByDate(),
                child: Text(
                  'Confirmer date',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              
              SizedBox(height: 20),
              Text(
                
                'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                style: TextStyle(fontSize: 16.0),
              ),

  Container(
  margin: EdgeInsets.only(top: 30.0), // Adjust the top margin as needed
  child: Column(
    children: rowsOfButtons,
  )
),

Container(
  margin: EdgeInsets.only(top: 30.0), // Adjust the top margin as needed
  child: Column(
    children: [
Row(
  children: [],
),
      
      SizedBox(height: 15),
      Center(
        
      child: Row(

       children: [
          Expanded(
              child: SizedBox(
         
          width: 10,
             
              ),
            ),
             Expanded(
              child: SizedBox(
              width: 100,
             child :  Text(
          'Heure : $selectedTime',
          style: TextStyle(fontSize: 18
         
          ),
        ),
             
              ),
            ),
             Expanded(
              child: SizedBox(
             
            width: 10,
             child :  Text(
          'Heure api : $heureFromApi',
          style: TextStyle(fontSize: 18
         
          ),
        ),
              ),
            ),
    
       ],
      ),
      ),
      SizedBox(height: 25),
      Row(

       children: [
          Expanded(
            child: SizedBox(
             child :  ElevatedButton(
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
      insertReservation(usernamepatient,email,tel,DateApi,selectedTime);
    },
    
  ),
  
             
              ),
            ),
    
       ],
      ),
     
    ],

    
  )
  
)
              
        



          
  
  





            ],
            
          ),
          
        ),
        
      ),
      
    );
  }
}
