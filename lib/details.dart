import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './editdata.dart';
import 'package:http/http.dart' as http;
import './calendar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

class Details extends StatefulWidget {
  
  final List list;
  final int index;
  Details({this.index, this.list});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String _filePath;
  
  
  void getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      if(filePath == null){
        return null;
      } 
      else{
        String basename = p.basename(filePath);
      

      setState(() {
        this._filePath = basename;
      });
      }
      
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    } 
   return null;
  }

  void deleteData() {
    var url = "http://192.168.1.14/sipjw/deleteData.php";
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Text(
                "Are You sure want to delete '${widget.list[widget.index]['acara']}'"),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "OK DELETE!",
                  style: new TextStyle(color: Colors.red),
                ),
                color: Colors.white,
                onPressed: () {
                  deleteData();
                   Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => Calendar()
                        ));
                },
              ),
              new FlatButton(
                child: new Text("CANCEL",
                    style: new TextStyle(color: Colors.green)),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
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
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              widget.list[widget.index]['acara'],
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new Text(
                widget.list[widget.index]['tanggal'],
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
                  child: new Text("2 hari sebelum",
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
             
             
              child:
               _filePath == null
                  ? new Text('File Sambutan: Tidak Ada.',  style: TextStyle(color: Colors.grey))
                  : new Text('File Sambutan: ' + _filePath,  style: TextStyle(color: Colors.grey)),
                  
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Colors.white,
                    child: Text("Upload"),
                    onPressed: getFilePath,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Colors.white,
                    child: Text("Share"),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
