import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import './calendar.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(new MyApp()));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "SIPJW",
        home: new Home(),
        routes: {
          "/logout": (_) => new Home(),
          "/calendar": (_) => new Calendar(),
        },
         theme: new ThemeData(
        primarySwatch: Colors.red, // Your app THEME-COLOR
      ),
    );
  }

}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text("SIPJW"),
      //   backgroundColor: Colors.red,
      //   automaticallyImplyLeading: false,
      // ),

      body: Center(
         child: Padding(
           padding: const EdgeInsets.all(16.0),
           child: new Column(
             mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("SIPJW", style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                ),),
                new TextField(
                  decoration: new InputDecoration(
                    hintText: "Username",
                    labelText: "Username",
                  ),
                ),
                new TextField(
                  decoration: new InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: new RaisedButton(
                    
                    child: new Text("Login"),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder:(BuildContext context) => new Calendar(),
                  ),
                    ),
                  ),
                ),
              ],
            ),
         ),
        ),
      

      // body: new TableCalendar(
      //   locale: 'en-US',
      //   formatAnimation: FormatAnimation.slide,
      // ) ,
      // floatingActionButton: new FloatingActionButton(
      //   child: new Icon(
      //     Icons.add,
      //   ),
      //   onPressed: (){},

      // ),
    );
  }
}
