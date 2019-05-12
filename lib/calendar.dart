import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import './adddata.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './details.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Future<List> getdata() async {
    final response =
        await http.get("http://054dc24d.ngrok.io/sipjw/getData.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("SIPJW"),
        backgroundColor: Colors.red,
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text("SI PJW"),
              accountEmail: Text("diskominfobalikpapan@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "SI",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            new ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.exit_to_app),
              onTap: () => Navigator.pushReplacementNamed(context, "/logout"),
            ),
          ],
        ),
      ),

      body:
     
         new Column(
              children: <Widget>[
                
                TableCalendar(
                     locale: 'en-US',
           
                            ) ,
               Expanded(
                 child:  
                 new FutureBuilder<List>(
                  future: getdata(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? new ItemList(list: snapshot.data)
                        : new Center(
                            child: new CircularProgressIndicator(),
                          );
                  }
                ),
         ),
        ],

      
      ),
      
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.red,
        child: new Icon(
          Icons.add,
        ),
        onPressed: () => Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new AddData(),
              ),
            ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          child: new GestureDetector(
            onTap: ()=>Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new Details(list: list, index: i,)
              )
            ),

            child: new Card(
          child: ListTile(
          title: Text(list[i]['acara']),
          subtitle: Text(list[i]['tempat']),
          trailing: Text(list[i]['waktu']),
          ),
          
        ),
          ),
        );
      },
    );
  }
}


