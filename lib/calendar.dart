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

 DateTime _selectedDay;
 Map<DateTime, List> _events;
 Map<DateTime, List> _visibleEvents;
 List _selectedEvents;

 
  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    
    getdata();
    
    _selectedEvents = _events[_selectedDay] ?? [];
    _visibleEvents = _events;
    
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
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


  Future getdata() async {
      _events ={};
    final response = await http.get("http://192.168.1.15/sipjw/getData.php");
    var jsonData = json.decode(response.body);
    for(var i = 0; i < jsonData.length; i++) {
        _events[DateTime.parse(jsonData[i]['tanggal'])] = [jsonData[i]['acara']];
       }

  
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
                     events: _visibleEvents,
                     calendarStyle: CalendarStyle(
                        selectedColor: Colors.red,
                        todayColor: Colors.red[200],
                        markersColor: Colors.blue,
                     ) ,
                     onDaySelected: _onDaySelected,
                     onVisibleDaysChanged: _onVisibleDaysChanged,
                            ) ,
                            const SizedBox(height: 8.0),
               Expanded(
                 child:  _buildEventList()
                 
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

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Card(
                                  child: ListTile(
                    title: Text(event.toString()),
                    onTap: () => print('$event tapped!'),
                  ),
                ),
              ))
          .toList(),
    );
  }

}


// class ItemList extends StatelessWidget {
//   final List list;
//   ItemList({this.list});

//   @override
//   Widget build(BuildContext context) {
//     return new ListView.builder(
//       itemCount: list == null ? 0 : list.length,
//       itemBuilder: (context, i) {
//         return new Container(
//           child: new GestureDetector(
//             onTap: ()=>Navigator.of(context).push(
//               new MaterialPageRoute(
//                 builder: (BuildContext context) => new Details(list: list, index: i,)
//               )
//             ),

//             child: new Card(
//                 child: ListTile(
//                       title: Text(list[i]['acara']),
//                        subtitle: Text(list[i]['tempat']),
//                       trailing: Text(list[i]['waktu']),
//           ),
          
//         ),
//           ),
//         );
//       },
//     );
//   }
// }


