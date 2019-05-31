// import 'package:http/http.dart' as http;
// import 'dart:convert';

class Jadwal {
  final String tanggal;
  final String waktu;
  final String tempat;
  final String acara;
  final String tujuanUndangan;
  final String penanggungJawab;
  final String yangMenghadiri;
  final String keterangan;
  final String pejabat;
  final String sambutan;

 Jadwal({this.tanggal, this.waktu, this.tempat, this.acara, this.tujuanUndangan, this.penanggungJawab, this.yangMenghadiri, this.keterangan,this.pejabat, this.sambutan});
  

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      tanggal: json['tanggal'],
      waktu: json['waktu'],
      tempat: json['tempat'],
      acara: json['acara'],
      tujuanUndangan: json['tujuan_undangan'],
      penanggungJawab: json['penanggung_jawab'],
      yangMenghadiri: json['yang_menghadiri'],
      keterangan: json['keterangan'],
      pejabat: json['pejabat'],
      sambutan: json['sambutan'],
    );
  }
}

// class JadwalViewModel{
//       static Jadwal jadwal;

//     static Future<Jadwal> fetchPost() async {
//       jadwal = new Jadwal();

//       try{
//         final response = await http.get("http://192.168.1.7/sipjw/getData.php");
//         jadwal = new Jadwal.fromJson(json.decode(response.body));
//       } catch(e){

//       }
//       return jadwal;
// }