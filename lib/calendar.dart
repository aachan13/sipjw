import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import './adddata.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './details.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {

final dateFormat = DateFormat('yyyy-MM-dd');
 DateTime _selectedDay;
 Map<DateTime, List<String>> _events;
 Map<DateTime, List<String>> _visibleEvents;
 List _selectedEvents;
 var jsonData;
 var tanggal;
 AnimationController _controller;

 
  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    
     tanggal = dateFormat.format(_selectedDay);
    getdata();
    
    _selectedEvents = _events[_selectedDay] ?? [];

    _visibleEvents = _events;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _controller.forward();
    fetchPost();
   
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    tanggal = dateFormat.format(day);
    
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
      this.tanggal = tanggal;
    });

    fetchPost();
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    setState(() {
      _visibleEvents = Map.fromEntries(
        _events.entries.where(
          (entry) =>
              entry.key.isAfter(first.subtract(const Duration(days: 1))) &&
              entry.key.isBefore(last.add(const Duration(days: 1))),
        ),
      );

       });
  }

  getdata() async {
    _events ={};
    
   final response = await http.get('http://192.168.43.238/rest-server-sipjw/api/jadwal');
    
    if(response.statusCode ==200){
    jsonData = json.decode(response.body)['data'];
    
         for (var obj in jsonData) {
             final key = DateTime.parse(obj['tanggal']);
             if (_events[key] == null) _events[key] = <String>[];
                 _events[key].add(obj['acara']);
          }

       setState(() {
         this._events = _events;
       });

      }
    
     else {
    // If that response was not OK, throw an error.
      _events = null;
    }
  }

  Future<List> fetchPost() async {
  final response =
      await http.get('http://192.168.43.238/rest-server-sipjw/api/jadwal?tanggal='+tanggal);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON

    var jsonData = json.decode(response.body)['data'];
    print(jsonData);
    return jsonData;

  } else {
    // If that response was not OK, throw an error.
    // throw Exception('Failed to load post');
    return null;
  }
}



  
    
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title:  new Text("Jadwal Walikota"),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text("Admin"),
              accountEmail: Text("Diskominfo Balikpapan"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "A",
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

      body: new Column(
                children: <Widget>[
                  
                  TableCalendar(
                       locale: 'en-US',
                       events: _visibleEvents,
                       calendarStyle: CalendarStyle(
                          selectedColor: Color(0xFF20283e),
                          todayColor: Colors.lightBlue[900],
                          markersColor: Colors.orange[900],
                       ) ,
                       onDaySelected: _onDaySelected,
                       onVisibleDaysChanged: _onVisibleDaysChanged,
                              ) ,
                              const SizedBox(height: 8.0),
                 Expanded(
                   
                   child: FutureBuilder(
                      future: fetchPost(),
                      builder: (context, snapshot){
                        return snapshot.connectionState == ConnectionState.done
                         ? snapshot.hasData 
                                ? new ItemList(list: snapshot.data,)
                                : new Center(
                            child: InkWell(
                              child: Text('Tidak ada jadwal pada tanggal ini'),
                              onTap: () => {
                                
                              },
                            ),
                          )

                          : CircularProgressIndicator();
                      }
                   ),
                   
           ),
        ],

      
      ),
       
      // Color(0xFF20283e),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.deepOrange,
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
              elevation: 4.0,
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


