import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../services/api_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

    @override
  ProfileState createState() => ProfileState();
   
  static String usernameconn = "username";
  //static String email = "email";
  void getToken() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    print(token);
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    String username = decodedToken['data'];
    print(username);
    usernameconn = username;
  }
}
class ProfileState extends State<Profile> {
  
bool _isLoading = false;
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? userName;
  String? password;
  
 static String email = "email user";
static String usernamepatient = "username patient";
static String tel = "tel user";
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
   
/*
 APIService.getUserProfile().then(
               (response) {
       

      
            email = response['email'];
            usernamepatient = response['username'];
            tel = response['tel'].toString();
        
        

              }
 );
*/
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

    //getToken();
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      final token = prefs.getString('token');
      print('Token get: $token');
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
      String username = decodedToken['data'];
      print(username);
     
      //print(usernameconn);
    });
    //print(usernameconn);

    return new Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(colors: [
              const Color(0xff575de3),
              const Color(0xff575de3),
            ], begin: Alignment.topCenter, end: Alignment.center)),
          ),
          new Scaffold(
            backgroundColor: Colors.transparent,
            body: new Container(
              child: new Stack(
                children: <Widget>[
                  new Align(
                    alignment: Alignment.center,
                    child: new Padding(
                      padding: new EdgeInsets.only(top: _height / 15),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new CircleAvatar(
                            backgroundImage:
                                new AssetImage('assets/aa.jpg'),
                            radius: _height / 10,
                          ),
                          new SizedBox(
                            height: _height / 30,
                          ),
                          new Text(
                            usernamepatient,
                            style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: _height / 2.2),
                    child: new Container(
                      color: Colors.white,
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(
                        top: _height / 2.6,
                        left: _width / 20,
                        right: _width / 20),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 2.0,
                                    offset: new Offset(0.0, 2.0))
                              ]),
                          child: new Padding(
                            padding: new EdgeInsets.all(_width / 20),
                            child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  headerChild('Réservations', 0),
                                 headerChild('Réservations', 0),
                                ]),
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(top: _height / 20),
                          child: new Column(
                            children: <Widget>[
                              infoChild(_width, Icons.email, email),
                              infoChild(_width, Icons.call, tel),
                              
                              new Padding(
                                padding: new EdgeInsets.only(top: _height / 30),
                                child: new Container(
                                  width: _width / 3,
                                  height: _height / 20,
                                  decoration: new BoxDecoration(
                                      color: const Color(0xff575de3),
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(_height / 40)),
                                      boxShadow: [
                                        new BoxShadow(
                                            color: Colors.black87,
                                            blurRadius: 2.0,
                                            offset: new Offset(0.0, 1.0))
                                      ]),
                                  child: new     Center(
            child: FormHelper.submitButton(
              "test",
              () {

            
        
              

              String id = "63f273f153d7eb35bdf32dcd";
              APIService.getUserProfile().then(
              (response) {
       

        if (response != null) {
          //email = response['email'];
          FormHelper.showSimpleAlertDialog(
            context,
            Config.appName,
            response['tel'].toString(),
            
            "OK",
            () {
              Navigator.of(context).pop();
            },
          );
        } else if (response == "Error fetching user profile.") {
          FormHelper.showSimpleAlertDialog(
            context,
            Config.appName,
            "error !!!!!!!",
            "OK",
            () {
              Navigator.of(context).pop();
            },
          );
        }
      },
    );

                
              },
              btnColor: Color(0xff575de3),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
  Widget headerChild(String header, int value) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(header),
          new SizedBox(
            height: 8.0,
          ),
          new Text(
            '$value',
            style: new TextStyle(
                fontSize: 14.0,
                color: const Color(0xff575de3),
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => new Padding(
        padding: new EdgeInsets.only(bottom: 8.0),
        child: new InkWell(
          child: new Row(
            children: <Widget>[
              new SizedBox(
                width: width / 10,
              ),
              new Icon(
                icon,
                color: const Color(0xff575de3),
                size: 36.0,
              ),
              new SizedBox(
                width: width / 20,
              ),
              new Text(data)
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );


Future<Map<String, dynamic>> fetchData() async {
  SharedPreferences prefs =
      SharedPreferences.getInstance() as SharedPreferences;
  final token = prefs.getString('token');
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
  String username = decodedToken['username'];
  debugPrint(username);
  return {'token': token};
}




