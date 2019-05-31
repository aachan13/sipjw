
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import './calendar.dart';
import 'viewHumas/calendarHumas.dart';
import 'viewProtokol/CalendarProtokol.dart';


void main() {
  initializeDateFormatting().then((_) => runApp(new MyApp()));

}

class MyApp extends StatelessWidget {
   
   
  final Map<int, Color> color = {
    50: Color.fromRGBO(32, 40, 62, .1),
    100: Color.fromRGBO(32, 40, 62, .2),
    200: Color.fromRGBO(32, 40, 62, .3),
    300: Color.fromRGBO(32, 40, 62, .4),
    400: Color.fromRGBO(32, 40, 62, .5),
    500: Color.fromRGBO(32, 40, 62, .6),
    600: Color.fromRGBO(32, 40, 62, .7),
    700: Color.fromRGBO(32, 40, 62, .8),
    800: Color.fromRGBO(32, 40, 62, .9),
    900: Color.fromRGBO(32, 40, 62, 10),
  };
  
  @override
  Widget build(BuildContext context) {

    MaterialColor colorCustom = MaterialColor(0xFF20283e, color);

    return MaterialApp(
      title: "SIPJW",
      home: new Home(),
      routes: {
        "/logout": (_) => new Home(),
        "/calendar": (_) => new Calendar(),
        "/calendarHumas": (_) => new CalendarHumas(),
      },
      theme: new ThemeData(
        primarySwatch: colorCustom, // Your app THEME-COLOR
        fontFamily: 'Manrope',
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();
  var userData;

  TextEditingController controllerUser = new TextEditingController();
    TextEditingController controllerPassword = new TextEditingController();

  _validateUser() {
    final _formkey = formKey.currentState;

    //  if (_formkey.validate()) {
    //   Navigator.of(context).push(
    //           new MaterialPageRoute(
    //             builder: (BuildContext context) => Calendar(),
    //           ));
        
    // }

    if(_formkey.validate() && controllerUser.text.contains('admin')){
        Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => Calendar(),
              ));
    } else if(_formkey.validate() && controllerUser.text.contains('humas')){
         Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => CalendarHumas(),
              ));
    } else if(_formkey.validate() && controllerUser.text.contains('protokol')){
         Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => CalendarProtokol(),
              ));
  }
  }

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text("SIPJW"),
      //   backgroundColor: Colors.red,
      //   automaticallyImplyLeading: false,
      // ),

      body: 
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                  child: new Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                    
                        
                        Text(
                          "SIPJW",
                          style: TextStyle(
                              fontSize: 40.0,
                              color: Color(0xFF20283e),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LeckerliOne'),
                        ),
                     

                      //username
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.5),
                              margin:
                                  const EdgeInsets.only(left: 00.0, right: 10.0),
                            ),
                            new Expanded(
                              child: TextFormField(
                                controller: controllerUser,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Username',
                                  hintStyle:
                                      TextStyle(color: Colors.grey, fontSize: 14.0),
                                ),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Isi username anda terlebih dahulu';
                                  } else if (!val.contains('admin') && !val.contains('humas') && !val.contains('protokol')){
                                    return 'username salah';
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),

                      //password
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.lock_open,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.5),
                              margin:
                                  const EdgeInsets.only(left: 00.0, right: 10.0),
                            ),
                            new Expanded(
                              child: TextFormField(
                                obscureText: true,
                                controller: controllerPassword,
                                decoration: InputDecoration(
                                  
                                  border: InputBorder.none,
                                  hintText: 'Enter password',
                                  hintStyle:
                                      TextStyle(color: Colors.grey, fontSize: 14.0),
                                ),
                                 validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Isi password anda terlebih dahulu';
                                  } else if (!val.contains('admin') && !val.contains('humas') && !val.contains('protokol')){
                                    return 'password salah';
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(10.0),
                        child: new RaisedButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            child: new Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: Color(0xFF20283e),
                            textColor: Colors.white,
                            onPressed: () {
                              _validateUser();
                            }),
                      ),
                    ],
                  ),
                
              ),
            ),
          ),
        
    );
  }
}
