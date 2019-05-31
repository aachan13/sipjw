import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'Calendar.dart';

class Sambutan extends StatefulWidget {
  final List list;
  final int index;
  Sambutan({this.list, this.index});
  
  

  @override
  _SambutanState createState() => _SambutanState();
}

class _SambutanState extends State<Sambutan> {
  String _filePath;

  void updatePDF() {
    var url = 'http://192.168.43.238/sipjw/updateData.php';
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "acara": widget.list[widget.index]['acara'],
    "tanggal": widget.list[widget.index]['tanggal'],
    "waktu": widget.list[widget.index]['waktu'],
    "tempat": widget.list[widget.index]['tempat'],
    "tujuan_undangan": widget.list[widget.index]['tujuan_undangan'],
    "penanggung_jawab": widget.list[widget.index]['penanggung_jawab'],
    "yang_menghadiri": widget.list[widget.index]['yang_menghadiri'],
    "keterangan": widget.list[widget.index]['keterangan'],
    "pejabat": widget.list[widget.index]['pejabat'],
    "reminder": widget.list[widget.index]['reminder'],
     "sambutan": _filePath,
    });

    
    
  }
  
  @override
  void initState() {
  
    super.initState();

  }

  void getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(
          type: FileType.CUSTOM, fileExtension: 'pdf');
      if (filePath == null) {
        return null;
      } else {
        String basename = p.basename(filePath);

        setState(() {
          this._filePath = basename;
          // updatePDF();
        });
      }
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Sambutan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              _filePath == null
                  ? new Text('File Sambutan: Tidak Ada.',
                      style: TextStyle(color: Colors.grey))
                  : new Text('File Sambutan: ' + _filePath,
                      style: TextStyle(color: Colors.grey)),
              Row(
                children: <Widget>[
                  FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add_circle_outline,
                            size: 14.0,
                          ),
                          Text(
                            "   CHOOSE FILE",
                            style: TextStyle(
                                color: Color(0xFF20283e),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      onPressed: () {
                        getFilePath();
                      }),
                  FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.file_upload,
                          size: 14.0,
                        ),
                        Text(
                          "    Submit",
                          style: TextStyle(
                            color: Color(0xFF20283e),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                        updatePDF();
                        Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) => Calendar()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
