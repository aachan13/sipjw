import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:sipjww/model/jadwal.dart';

class Api{
  static final url = "http://3dfece03.ngrok.io/sipjw/getData.php";
  List<Jadwal> listJadwal = [];

 Future <List<Jadwal>> getData() async{
     listJadwal.clear();
     final http.Response apiResponse = await http.get(url);

       if(json.decode(apiResponse.body)['status'] == "ok"){
      final listData = json.decode(apiResponse.body);

      listData.forEach(
        (data) => listJadwal.add(Jadwal.fromJson(data))
      );

      return listJadwal;
    }
    
    else {
      return listJadwal = [];
    }
 }

}