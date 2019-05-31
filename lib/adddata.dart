import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import './calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'dart:typed_data';
import './main.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final formKey = GlobalKey<FormState>();
  // final dateFormat = DateFormat('dd MMMM yyyy');
  final dateFormat = DateFormat('yyyy-MM-dd');
  final timeFormat = DateFormat('hh:mm a');
  var _valueDropdown = "1";
  DateTime schedule;
  String reminder ="1 hari sebelum";
  var timer;

  TextEditingController controllerAcara = new TextEditingController();
  TextEditingController controllerTanggal = new TextEditingController();
  TextEditingController controllerWaktu = new TextEditingController();
  TextEditingController controllerTempat = new TextEditingController();
  TextEditingController controllerKeterangan = new TextEditingController();
  TextEditingController controllerTujuan = new TextEditingController();
  TextEditingController controllerPJ = new TextEditingController();
  TextEditingController controllerYangMenghadiri = new TextEditingController();
  TextEditingController controllerPejabat = new TextEditingController();
  // TextEditingController controllerReminder = new TextEditingController();

  @override
  initState() {
    super.initState();

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('assignment');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                },
              )
            ],
          ),
    );
  }

  void addData() {
    var url = 'http://192.168.43.238/sipjw/addData.php';

    http.post(url, body: {
      'acara': controllerAcara.text,
      'tanggal': controllerTanggal.text,
      'waktu': controllerWaktu.text,
      'tempat': controllerTempat.text,
      'tujuan_undangan': controllerTujuan.text,
      'penanggung_jawab': controllerPJ.text,
      'yang_menghadiri': controllerYangMenghadiri.text,
      'keterangan': controllerKeterangan.text,
      'pejabat': controllerPejabat.text,
      'reminder': reminder,
    });
  }

  void _validate() {
    final form = formKey.currentState;

    if (form.validate()) {
      addData();
      _showNotif();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Calendar()));
    }
  }

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  //select tanggal
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

  Future<void> _showNotif() async {
    final jadwal = DateTime.now();
    final difference = schedule.difference(jadwal).inDays;
    print(difference);
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(days: difference));
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
      vibrationPattern: vibrationPattern,
      playSound: true,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Penjadwalan Walikota',
        'Ada acara untuk besok! Cek aplikasi sekarang!',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  // Future<Null> _selectTimeReminder(BuildContext context) async {
  //   final TimeOfDay picked =
  //       await showTimePicker(context: context, initialTime: _time);

  //   if (picked != null && picked != _time) {
  //     print('Time Selected: ${_time.toString()}');
  //     setState(() {
  //       _time = picked;
  //       final timerjadwal = new DateTime.now();
  //       timer = new DateTime(timerjadwal.year, timerjadwal.month,
  //           timerjadwal.day, _time.hour, _time.minute);
  //       print(timer);
  //       controllerReminder =
  //           TextEditingController(text: timeFormat.format(timer));
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add Data'),
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
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: new RaisedButton(
                    child: new Text('Add Schedule'),
                    color: Color(0xFF20283e),
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
