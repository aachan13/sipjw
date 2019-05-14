import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {

final List list;
  final int index;
  EditData({this.list, this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {

TextEditingController controllerAcara;
TextEditingController controllerTanggal;
TextEditingController controllerWaktu;
TextEditingController controllerTempat;
TextEditingController controllerKeterangan;
TextEditingController controllerTujuan;
TextEditingController controllerPJ;
TextEditingController controllerYangMenghadiri;
TextEditingController controllerPejabat;

void editData(){
  var url="http://192.168.1.14/sipjw/updateData.php";

  http.post(url, body: {
    "id": widget.list[widget.index]['id'],
    "acara": controllerAcara.text,
    "tanggal": controllerTanggal.text,
    "waktu": controllerWaktu.text,
    "tempat": controllerTempat.text,
    "tujuan_undangan": controllerTujuan.text,
    "penanggung_jawab": controllerPJ.text,
    "yang_menghadiri": controllerYangMenghadiri.text,
    "keterangan": controllerKeterangan.text,
    "pejabat": controllerPejabat.text,

  });
}

@override
  void initState() { 

    controllerAcara = new TextEditingController(text: widget.list[widget.index]['acara']);
    controllerTanggal = new TextEditingController(text: widget.list[widget.index]['tanggal']);
    controllerWaktu = new TextEditingController(text: widget.list[widget.index]['waktu']);
    controllerTempat = new TextEditingController(text: widget.list[widget.index]['tempat']);
    controllerKeterangan = new TextEditingController(text: widget.list[widget.index]['keterangan']);
    controllerTujuan = new TextEditingController(text: widget.list[widget.index]['tujuan_undangan']);
    controllerPJ = new TextEditingController(text: widget.list[widget.index]['penanggung_jawab']);
    controllerYangMenghadiri = new TextEditingController(text: widget.list[widget.index]['yang_menghadiri']);
    controllerPejabat= new TextEditingController(text: widget.list[widget.index]['pejabat']);
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Edit Data"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
                      editData();
                    Navigator.pop(context);
                    },
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                // new ListTile(
                //   title: new TextField(
                //     decoration: new InputDecoration(
                //         hintText: "Acara", labelText: "Nama Acara"),
                //   ),
                // ),

                new TextField(
                  keyboardType: TextInputType.text,
                  controller: controllerAcara,
                  decoration: new InputDecoration(
                      hintText: "Nama Acara", labelText: "Acara"),
                ),

                new TextField(
                  controller: controllerTanggal,
                  decoration: new InputDecoration(
                    hintText: "Tanggal Acara",
                    labelText: "Tanggal",
                    suffixIcon: Icon(Icons.date_range),
                  ),
                ),

                new TextField(
                  controller: controllerWaktu,
                  decoration: new InputDecoration(
                    hintText: "Waktu Acara",
                    labelText: "Waktu",
                    suffixIcon: Icon(Icons.keyboard_arrow_right),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(top: 16.0),
                //   child: new TextField(
                //         decoration: new InputDecoration(
                //           border: OutlineInputBorder(),
                //             hintText: "Deskripsi",
                //             labelText: "Deskripsi Acara",
                //         ),
                //         maxLines: 3,
                //       ),
                // ),

                // new ListTile(
                //   leading: const Icon(Icons.my_location),
                //   title: new TextField(
                //     decoration: new InputDecoration(
                //         hintText: "Acara", labelText: "Nama Acara"),
                //   ),
                // ),

                new TextField(
                  controller: controllerTempat,
                  decoration: new InputDecoration(
                      hintText: "Tempat Acara",
                      labelText: "Tempat",
                      suffixIcon: Icon(Icons.location_city)),
                ),

                new TextField(
                  controller: controllerKeterangan,
                  decoration: new InputDecoration(
                    hintText: "Keterangan",
                    labelText: "Keterangan",
                  ),
                ),

                new TextField(
                  controller: controllerTujuan,
                  decoration: new InputDecoration(
                      hintText: "Undangan ditujukan pada", labelText: "Tujuan"),
                ),

                new TextField(
                  controller: controllerPJ,
                  decoration: new InputDecoration(
                      hintText: "Penanggung Jawab",
                      labelText: "Penanggung Jawab"),
                ),

                  new TextField(
                    controller: controllerYangMenghadiri,
                  decoration: new InputDecoration(
                      hintText: "Yang Menghadiri",
                      labelText: "Yang menghadiri"),
                ),

                new TextField(
                  controller: controllerPejabat,
                  decoration: new InputDecoration(
                      hintText: "Nama Pejabat",
                      labelText: "Nama Pejabat yang menggantikan (opsional)"),
                ),


                // new ListTile(
                //   leading: Icon(Icons.notifications),
                //   title: Text("Reminder"),
                // ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}