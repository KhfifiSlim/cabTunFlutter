import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_login_register_nodejs/models/login_request_model.dart';
import 'package:flutter_login_register_nodejs/models/login_response_model.dart';
import 'package:flutter_login_register_nodejs/models/register_request_model.dart';
import 'package:flutter_login_register_nodejs/models/register_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';
import 'shared_service.dart';

class APIService {
  static var client = http.Client();
 // static var iduser ="63f273f153d7eb35bdf32dcd";
  static String idlogged = "";
  static int userTel = 0;
  static verifToken() async {
      SharedPreferences.getInstance().then((SharedPreferences prefs) {
      final token = prefs.getString('token');
        if (token != null){
           prefs.clear();
           prefs.remove('token');
    }
    });
  
      
  }

  static Future<String> login(
    LoginRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.loginAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    var responseBody = jsonDecode(response.body);
    var message = responseBody['message'];
    //var token = responseBody['data']['token'];
    //debugPrint('Response body: ${message}');
    //debugPrint('Response body: ${token}');

    if (message == "Success") {
      await SharedService.setLoginDetails(
        loginResponseJson(
          response.body,
        ),
      );
      verifToken();

      var responseBody = jsonDecode(response.body);
      var token = responseBody['data']['token'];
      idlogged = responseBody['data']['id'];
      userTel = responseBody['data']['tel'];
      debugPrint(idlogged);
      
       SharedPreferences.getInstance().then((SharedPreferences prefs) {
       prefs.setString('token' , token);
       print('Token get: $token');
   
      
    });
    

      return "Success";
    } else if (message == "Invalid Username!") {
      return "Invalid Username!";
    } else if (message == "Invalid Password!") {
      return "Invalid Password!";
    } else {
      return "error";
    }
  }

  static Future<Map<String, dynamic>> getUserProfile(
     
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var data = {"id": idlogged}; // Create a Map with the 'id' field
    var url = Uri.http(
      Config.apiURL,
      Config.userProfileAPI,
      
    );
      

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(data),
    );
    
    var responseBody = jsonDecode(response.body);
    var message = responseBody['message'];
    //var token = responseBody['data']['token'];
   // debugPrint('Response body: ${message}');
    //print(message);

    if (message == "Success") {
      

      var responseBody = jsonDecode(response.body);
      var object = responseBody['data']['user'][0];
      // var token = responseBody['data']['token'];
     //r print(object);
    
    

      //return "Success";
      return object;

    }else{
      return {"error": "Error fetching user profile."};
    }
  }



  // static Future<Object> getHeureByDate() async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //   };
  //   var data = {"date": "05/05/2023"};
  //   var url = Uri.http(
  //     Config.apiURL,
  //     Config.getHeureByDate,
  //   );


  //   var response = await client.post(
  //     url,
  //     headers: requestHeaders,
  //     body: jsonEncode(data),
  //   );
  //  // print(response);

  //   var responseBody = jsonDecode(response.body);
  //   var message = responseBody['message'];
  //   //var token = responseBody['data']['token'];
  //   debugPrint('Response body: ${message}');
  //    debugPrint('slimmmmmmmmmmmmm');
    

  //   if (message == "Success") {
  //     var responseBody = jsonDecode(response.body);
  //     var object = responseBody['data'];
   
  //     return object;


  //   }else{
  //     return {"error": "Error fetching heure."};
  //   }
  // }





  static Future<Object> getReservation() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var data = {"num": userTel};
    var url = Uri.http(
      Config.apiURL,
      Config.getAllReservation,
    );


    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(data),
    );
    print(response);

    var responseBody = jsonDecode(response.body);
    var message = responseBody['message'];
    //var token = responseBody['data']['token'];
    debugPrint('Response body: ${message}');
    List<Map<String, dynamic>> schedules = [];

    if (message == "Success") {
      var responseBody = jsonDecode(response.body);
      var object = responseBody['data'];
      //print(object);
      for (var item in object) {
        // Do something with each item
        schedules.add(item);
      }

      //return "Success";
      return schedules;


    }else{
      return {"error": "Error fetching Reservation."};
    }
  }

  static Future<String> annulerReservation(String id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var data = {"status" : 2};
    var url = Uri.http(
      Config.apiURL,
      Config.annulerReservation+id,
    );


    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(data),
    );
    print(response);

    var responseBody = jsonDecode(response.body);
    var message = responseBody['message'];
    //var token = responseBody['data']['token'];
    debugPrint('Response body: ${message}');
    List<Map<String, dynamic>> schedules = [];

    if (message == "Success") {
      return "Success";

    }else{
      return "Error Annuler Reservation.";
    }
  }

 static Future<Map<String, dynamic>> getnondisp() async {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
  };

  var url = Uri.http(Config.apiURL, Config.getnotdisp);

  var response = await client.post(
    url,
    headers: requestHeaders,
    //body: jsonEncode(data),
  );

  var responseBody = jsonDecode(response.body);
  var message = responseBody['message'];
  debugPrint('Response body: ${message}');
  print(message);

  if (message == "Success") {
    var object = responseBody['data']['date'];
    //print(object);

    return {"result":object};
  } else {
    return {"error": "Error fetching dates"};
  }
}


/*
  static Future<String> getUserProfile(id) async {
   // var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
     // 'Authorization': 'Basic ${loginDetails!.data.token}'
    };

    var url = Uri.http(Config.apiURL, Config.userProfileAPI);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

     var responseBody = jsonDecode(response.body);
     //var token = responseBody['data']['token'];

    if (response.statusCode == 200) {
      return "slim";
    } else {
      return "error";
    }
  }
*/
  static Future<RegisterResponseModel> register(
    RegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.registerAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJson(
      response.body,
    );
  }

  
}
