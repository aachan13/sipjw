import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './calendar.dart';
import 'package:intl/intl.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final formKey = GlobalKey<FormState>();
  // final dateFormat = DateFormat('dd MMMM yyyy');
  final dateFormat = DateFormat('yyyy-MM-dd');
  final timeFormat = DateFormat('hh:mm a');
  String _acara;
  String _password;
  String _tanggal;
  String _waktu;
  String _tempat;
  String _keterangan;
  String _tujuan;
  String _penanggungJawab;
  String _yangMenghadiri;

  TextEditingController controllerAcara = new TextEditingController();
  TextEditingController controllerTanggal = new TextEditingController();
  TextEditingController controllerWaktu = new TextEditingController();
  TextEditingController controllerTempat = new TextEditingController();
  TextEditingController controllerKeterangan = new TextEditingController();
  TextEditingController controllerTujuan = new TextEditingController();
  TextEditingController controllerPJ = new TextEditingController();
  TextEditingController controllerYangMenghadiri = new TextEditingController();
  TextEditingController controllerPejabat = new TextEditingController();

  void addData() {
    var url = "http://3dfece03.ngrok.io/sipjw/addData.php";

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

  void _validate() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      addData();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Calendar()));
    }
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
        controllerTanggal =
            TextEditingController(text: dateFormat.format(_date));
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      print('Time Selected: ${_time.toString()}');
      setState(() {
        _time = picked;
        final timerubah = new DateTime.now();
        final timesekarang = new DateTime(timerubah.year, timerubah.month,
            timerubah.day, _time.hour, _time.minute);
        controllerWaktu =
            TextEditingController(text: timeFormat.format(timesekarang));
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

                Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          controller: controllerAcara,
                          decoration: new InputDecoration(
                              hintText: "Nama Acara", labelText: "Acara"),
                          validator: (val) =>
                              val.isEmpty ? 'Field ini harus di isi' : null,
                          onSaved: (val) => _acara = val,
                        ),

                        new TextFormField(
                          controller: controllerTanggal,
                          decoration: new InputDecoration(
                            hintText: "Tanggal Acara",
                            labelText: "Tanggal",
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                _selectDate(context);
                              },
                            ),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Field ini wajib di isi, tekan icon disebelah kanan';
                            } else if (val.length > 25) {
                              return 'Character terlalu banyak';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) => _tanggal = val,
                        ),

                        new TextFormField(
                          controller: controllerWaktu,
                          decoration: new InputDecoration(
                            hintText: "Waktu Acara",
                            labelText: "Waktu",
                            suffixIcon: IconButton(
                              icon: Icon(Icons.keyboard_arrow_right),
                              onPressed: () {
                                _selectTime(context);
                              },
                            ),
                          ),
                          validator: (val) {
                            Pattern pattern =
                                r'^([0][1-9]|[1][0-2]):[0-5][0-9] {1}(AM|PM|am|pm)$';
                            RegExp regex = new RegExp(pattern);
                            if(val.isEmpty){
                              return 'Field ini wajib diisi';
                            }
                            else if (!regex.hasMatch(val))
                              return 'Format jam salah, klik icon disebelah kanan';
                            else
                              return null;
                          },
                          onSaved: (val) => _waktu = val,
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

                        new TextFormField(
                          controller: controllerTempat,
                          decoration: new InputDecoration(
                              hintText: "Tempat Acara",
                              labelText: "Tempat",
                              suffixIcon: Icon(Icons.location_on)),
                               validator: (val) =>
                              val.isEmpty ? 'Field ini harus di isi' : null,
                          onSaved: (val) => _tempat = val,

                        ),

                        new TextFormField(
                          controller: controllerKeterangan,
                          decoration: new InputDecoration(
                            hintText: "Keterangan",
                            labelText: "Keterangan",
                          ),
                           validator: (val) =>
                              val.isEmpty ? 'Field ini harus di isi' : null,
                          onSaved: (val) => _keterangan= val,
                        ),

                        new TextFormField(
                          controller: controllerTujuan,
                          decoration: new InputDecoration(
                              hintText: "Undangan ditujukan pada",
                              labelText: "Tujuan"),
                               validator: (val) =>
                              val.isEmpty ? 'Field ini harus di isi' : null,
                          onSaved: (val) => _tujuan = val,
                        ),

                        new TextFormField(
                          controller: controllerPJ,
                          decoration: new InputDecoration(
                              hintText: "Penanggung Jawab",
                              labelText: "Penanggung Jawab"),
                               validator: (val) =>
                              val.isEmpty ? 'Field ini harus di isi' : null,
                          onSaved: (val) => _penanggungJawab = val,
                        ),

                        new TextFormField(
                          controller: controllerYangMenghadiri,
                          decoration: new InputDecoration(
                              hintText: "Yang Menghadiri",
                              labelText: "Yang menghadiri"),
                               validator: (val) =>
                              val.isEmpty ? 'Field ini harus di isi' : null,
                          onSaved: (val) => _yangMenghadiri = val,
                        ),

                        new TextFormField(
                          controller: controllerPejabat,
                          decoration: new InputDecoration(
                              hintText: "Nama Pejabat",
                              labelText:
                                  "Nama Pejabat yang menggantikan (opsional)"),
                                   validator: (val) =>
                              val.length < 3 ? 'Karakter terlalu singkat' : null,
                          onSaved: (val) => _tempat = val,
                        ),
                      ],
                    )),

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
                      _validate();
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
