import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EditData extends StatefulWidget {

final List list;
  final int index;
  EditData({this.list, this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {

final formKey = GlobalKey<FormState>();
String reminder;
var _valueDropdown = "1";
DateTime schedule;
final dateFormat = DateFormat('yyyy-MM-dd');
final timeFormat = DateFormat('hh:mm a');
var sambutan;

TextEditingController controllerAcara;
TextEditingController controllerTanggal;
TextEditingController controllerWaktu;
TextEditingController controllerTempat;
TextEditingController controllerKeterangan;
TextEditingController controllerTujuan;
TextEditingController controllerPJ;
TextEditingController controllerYangMenghadiri;
TextEditingController controllerPejabat;
TextEditingController controllerSambutan;

void editData(){
  var url="http://192.168.43.238/sipjw/updateData.php";

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
    "reminder": reminder,
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
        print(_date);
        controllerTanggal =
            TextEditingController(text: dateFormat.format(_date));
        this.schedule = _date;
      });
    }
  }

  //select time
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
        print(timesekarang);
        controllerWaktu =
            TextEditingController(text: timeFormat.format(timesekarang));
      });
    }
  }

@override
  void initState() { 
    reminder = widget.list[widget.index]['reminder'];
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
                     Navigator.pushReplacementNamed(context, "/calendar");
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
                Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          controller: controllerAcara,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: new InputDecoration(
                              hintText: 'Nama Acara', labelText: 'Acara'),
                          validator: (val) =>
                              val.isEmpty ? 'Field ini harus di isi' : null,
                        ),

                        new TextFormField(
                          controller: controllerTanggal,
                          decoration: new InputDecoration(
                            hintText: 'Tanggal Acara',
                            labelText: 'Tanggal',
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
                        ),

                        new TextFormField(
                          controller: controllerWaktu,
                          decoration: new InputDecoration(
                            hintText: 'Waktu Acara',
                            labelText: 'Waktu',
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
                            if (val.isEmpty) {
                              return 'Field ini wajib diisi';
                            } else if (!regex.hasMatch(val))
                              return 'Format jam salah, klik icon disebelah kanan';
                            else
                              return null;
                          },
                        ),

                        new TextFormField(
                          controller: controllerTempat,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: new InputDecoration(
                              hintText: 'Tempat Acara',
                              labelText: 'Tempat',
                              suffixIcon: Icon(Icons.location_on)),
                          validator: (val) =>
                              val.isEmpty ? 'Field ini harus di isi' : null,
                        ),

                        new TextFormField(
                          controller: controllerKeterangan,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: new InputDecoration(
                            hintText: 'Keterangan',
                            labelText: 'Keterangan',
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Field ini harus di isi' : null,
                        ),

                        new TextFormField(
                          controller: controllerTujuan,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: new InputDecoration(
                              hintText: 'Undangan ditujukan pada',
                              labelText: 'Tujuan'),
                          validator: (val) =>
                              val.isEmpty ? 'Field ini harus di isi' : null,
                        ),

                        new TextFormField(
                          controller: controllerPJ,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: new InputDecoration(
                              hintText: 'Penanggung Jawab',
                              labelText: 'Penanggung Jawab'),
                          validator: (val) =>
                              val.isEmpty ? 'Field ini harus di isi' : null,
                        ),

                        new TextFormField(
                          controller: controllerYangMenghadiri,
                          decoration: new InputDecoration(
                              hintText: 'Yang Menghadiri',
                              labelText: 'Yang menghadiri'),
                          validator: (val) =>
                              val.isEmpty ? 'Field ini harus di isi' : null,
                        ),

                        new TextFormField(
                          controller: controllerPejabat,
                          decoration: new InputDecoration(
                              hintText:
                                  'Nama Pejabat yang menggantikan (opsional)',
                              labelText: 'Nama Pejabat (opsional)'),
                          validator: (val) => val.length < 3
                              ? 'Karakter terlalu singkat'
                              : null,
                        ),

                        // new TextFormField(
                        //   controller: controllerReminder,
                        //   decoration: new InputDecoration(
                        //     hintText: 'Reminder',
                        //     labelText: 'Tentukan Reminder',
                        //     suffixIcon: IconButton(
                        //       icon: Icon(Icons.notifications_active),
                        //       onPressed: () {
                        //         _selectTimeReminder(context);

                        //       },
                        //     ),
                        //   ),
                        //   validator: (val) {
                        //     Pattern pattern =
                        //         r'^([0][1-9]|[1][0-2]):[0-5][0-9] {1}(AM|PM|am|pm)$';
                        //     RegExp regex = new RegExp(pattern);
                        //     if(val.isEmpty){
                        //       return 'Field ini wajib diisi';
                        //     }
                        //     else if (!regex.hasMatch(val))
                        //       return 'Format jam salah, klik icon disebelah kanan';
                        //     else
                        //       return null;
                        //   },

                        // ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text('Reminder', style: TextStyle(
                                  fontSize: 16,
                                ),),
                                flex: 4,
                              ),
                              Expanded(
                                flex: 3,
                                child: DropdownButton<String>(
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: "1",
                                      child: Text('1 hari sebelum'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "2",
                                      child: Text('2 hari sebelum'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "3",
                                      child: Text('Setiap hari'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _valueDropdown = value;
                                      if(value == "1"){
                                        reminder = "1 hari sebelum";
                                      } else if(value == "2"){
                                        reminder = "2 hari sebelum";
                                      } else {
                                        reminder = "setiap hari";
                                      }
                                    });
                                  },
                                  value: _valueDropdown,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),

              ],
            ),
          ],
        ),
      ),
    );
  }
}