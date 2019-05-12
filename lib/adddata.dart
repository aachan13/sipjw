import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './calendar.dart';


class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

TextEditingController controllerAcara = new TextEditingController();
TextEditingController controllerTanggal = new TextEditingController();
TextEditingController controllerWaktu = new TextEditingController();
TextEditingController controllerTempat = new TextEditingController();
TextEditingController controllerKeterangan = new TextEditingController();
TextEditingController controllerTujuan = new TextEditingController();
TextEditingController controllerPJ = new TextEditingController();
TextEditingController controllerYangMenghadiri = new TextEditingController();
TextEditingController controllerPejabat = new TextEditingController();


void addData(){
  var url="http://054dc24d.ngrok.io/sipjw/addData.php";

  http.post(url, body: {
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
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2100));

    if (picked != null && picked != _date) {
      print('Date Selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add Data'),
        backgroundColor: Colors.red,
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
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: (){_selectDate(context);},
                ),

                new TextField(
                  controller: controllerWaktu,
                  decoration: new InputDecoration(
                    hintText: "Waktu Acara",
                    labelText: "Waktu",
                    suffixIcon: 
                        Icon(Icons.keyboard_arrow_right),
                        
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

                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: new RaisedButton(
                    child: new Text("Add Schedule"),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      addData();
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                          builder: (context) => Calendar()
                        )
                      );
                    },
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
