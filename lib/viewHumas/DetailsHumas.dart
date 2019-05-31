import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sipjww/Sambutan.dart';

class DetailsHumas extends StatefulWidget {
  final List list;
  final int index;
  DetailsHumas({this.index, this.list});

  @override
  _DetailsHumasState createState() => _DetailsHumasState();
}

class _DetailsHumasState extends State<DetailsHumas> {
 
  String _sambutan;
  final dateFormat = DateFormat('dd MMMM yyyy');
  var tanggal;

  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.parse(widget.list[widget.index]['tanggal']);
    tanggal = dateFormat.format(date).toString();
    _sambutan = widget.list[widget.index]['sambutan'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Detail Event"),
      
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 8.0,
          child: new Container(
            padding: const EdgeInsets.all(16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  widget.list[widget.index]['acara'],
                  style: TextStyle(fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: new Text(
                    tanggal,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: new Row(
                    children: <Widget>[
                      new Icon(
                        Icons.location_city,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Text(widget.list[widget.index]['tempat'],
                            style: TextStyle(color: Colors.grey)),
                      )
                    ],
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.notifications,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: new Text(widget.list[widget.index]['reminder'],
                          style: TextStyle(color: Colors.grey)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: new Text(
                    "Undangan ditujukan kepada: ${widget.list[widget.index]['tujuan_undangan']}",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: new Text(
                      "Penanggung jawab: ${widget.list[widget.index]['penanggung_jawab']}",
                      style: TextStyle(color: Colors.grey)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: new Text(
                      "Yang menghadiri: ${widget.list[widget.index]['yang_menghadiri']}",
                      style: TextStyle(color: Colors.grey)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: new Text(
                      "Keterangan: ${widget.list[widget.index]['keterangan']}",
                      style: TextStyle(color: Colors.grey)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: new Text(
                      "Pejabat yang menggantikan: ${widget.list[widget.index]['pejabat']}",
                      style: TextStyle(color: Colors.grey)),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _sambutan == null
                        ? new Text(
                            'Sambutan Tidak Ada.',
                            style: TextStyle(color: Colors.grey),
                          )
                        : new Text(
                            "Sambutan: ${widget.list[widget.index]['sambutan']}", style: TextStyle(color: Colors.grey),
                          )),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add_circle_outline,
                            size: 14.0,
                          ),
                          Text(
                            "   UPLOAD",
                            style: TextStyle(
                                color: Color(0xFF20283e),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      onPressed: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Sambutan(
                                  list: widget.list,
                                  index: widget.index,
                                ),
                          )),
                    ),
                    FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.share,
                            size: 14.0,
                          ),
                          Text(
                            "    SHARE",
                            style: TextStyle(
                              color: Color(0xFF20283e),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
