import 'package:flutter/material.dart';
import './editdata.dart';
import 'package:http/http.dart' as http;
import './calendar.dart';
import 'package:intl/intl.dart';
import 'Sambutan.dart';
import 'package:share/share.dart';
import 'package:open_file/open_file.dart';



class Details extends StatefulWidget {
  final List list;
  final int index;
  Details({this.index, this.list});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String _filePath;
  String _sambutan;
  final dateFormat = DateFormat('dd MMMM yyyy');
  var tanggal;
  String _openResult = 'Unknown';

 

  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.parse(widget.list[widget.index]['tanggal']);
    tanggal = dateFormat.format(date).toString();
    _sambutan = widget.list[widget.index]['sambutan'];
  }

  // void getFilePath() async {
  //   try {
  //     String filePath = await FilePicker.getFilePath(
  //         type: FileType.CUSTOM, fileExtension: 'pdf');
  //     if (filePath == null) {
  //       return null;
  //     } else {
  //       String basename = p.basename(filePath);

  //       setState(() {
  //         this._filePath = basename;
  //         updatePDF();
  //       });
  //     }
  //   } on PlatformException catch (e) {
  //     print("Error while picking the file: " + e.toString());
  //   }
  //   return null;
  // }

  void deleteData() {
    var url = "http://192.168.43.238/sipjw/deleteData.php";
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void updatePDF() {
    var url = 'http://192.168.43.238/sipjw/updateData.php';
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      'sambutan': _filePath,
    });
  }

  void confirm() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Text(
              "Apakah anda yakin ingin menghapus '${widget.list[widget.index]['acara']}' ?",
              style: TextStyle(color: Colors.grey),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "OK DELETE!",
                  style: new TextStyle(
                      color: Color(0xFF20283e), fontWeight: FontWeight.bold),
                ),
                color: Colors.white,
                onPressed: () {
                  deleteData();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Calendar()));
                },
              ),
              new FlatButton(
                child: new Text("CANCEL",
                    style: new TextStyle(color: Colors.grey)),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

   Future<void> openFile() async {
    final filePath = "${widget.list[widget.index]['sambutan']}";
    final message = await OpenFile.open(filePath);

    setState(() {
      _openResult = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Detail Event"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new EditData(
                        list: widget.list,
                        index: widget.index,
                      ),
                )),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => confirm(),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
Padding(
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

                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: _sambutan == null
                          ? new Text(
                              'Sambutan Tidak Ada.',
                              style: TextStyle(color: Colors.grey),
                            )
                          : 
                          
                          new FlatButton(
                            child: Text("Tap to open file", 
                                    style: TextStyle(
                                       color: Color(0xFF20283e),
                                       decoration: TextDecoration.underline
                                    ) ,),
                            onPressed: openFile
                            
                          )),

                          Text('open result: $_openResult\n'),

                
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
                        onPressed: () {
                         Share.share("Ada acara ${widget.list[widget.index]['acara']} pada $tanggal, di ${widget.list[widget.index]['tempat']}, apakah anda bersedia untuk hadir?");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        ],
              
      ),
    );
  }
}
