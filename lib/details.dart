import 'package:flutter/material.dart';
import './editdata.dart';
import 'package:http/http.dart' as http;
import './calendar.dart';

class Details extends StatefulWidget {

final List list;
  final int index;
  Details({this.index,this.list});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

void deleteData(){

var url="http://054dc24d.ngrok.io/sipjw/deleteData.php";

http.post(url, body: {
    'id': widget.list[widget.index]['id']
  });
}

void confirm(){
   AlertDialog alertDialog = new AlertDialog(
    content: new Text("Are You sure want to delete '${widget.list[widget.index]['acara']}'"),
    actions: <Widget>[
      new RaisedButton(
        child: new Text("OK DELETE!",style: new TextStyle(color: Colors.red),),
        color: Colors.white,
        onPressed: (){
          deleteData();
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context)=> new Calendar(),
            )
          );
        },
      ),
      new RaisedButton(
        child: new Text("CANCEL",style: new TextStyle(color: Colors.green)),
        color: Colors.white,
        onPressed: ()=> Navigator.pop(context),
      ),
    ],
     );

  showDialog(context: context, child: alertDialog);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Detail Event"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: ()=>Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new EditData(list: widget.list, index: widget.index,),
              )
            ),
          ),

          IconButton(
            icon: Icon(Icons.delete),
            onPressed: ()=> confirm(),
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
                child: new Text(widget.list[widget.index]['tanggal'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new Row(children: <Widget>[
                  new Icon(
                    Icons.location_city,
                    color: Colors.grey,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text(widget.list[widget.index]['tempat'], 
                    style: TextStyle(color: Colors.grey)),
                  )
                ],),
              ),

              new Row(children: <Widget>[
                new Icon(
                  Icons.notifications,
                  color: Colors.grey,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: new Text("2 hari sebelum", 
                  style: TextStyle(color: Colors.grey)),
                )
              ],),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new Text("Undangan ditujukan kepada: ${widget.list[widget.index]['tujuan_undangan']}", 
                  style: TextStyle(color: Colors.grey),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new Text("Penanggung jawab: ${widget.list[widget.index]['penanggung_jawab']}", 
                  style: TextStyle(color: Colors.grey)),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new Text("Yang menghadiri: ${widget.list[widget.index]['yang_menghadiri']}", 
                  style: TextStyle(color: Colors.grey)),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new Text("Keterangan: ${widget.list[widget.index]['keterangan']}", 
                  style: TextStyle(color: Colors.grey)),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new Text("Pejabat yang menggantikan: ${widget.list[widget.index]['pejabat']}", 
                  style: TextStyle(color: Colors.grey)),
              )

            ],
          ),
      ),

      bottomNavigationBar: BottomAppBar(
        
        child: Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              
                
                  IconButton(
                    icon: Icon(Icons.attachment),
                    onPressed: (){},
                  ),
                 
                
              
              IconButton(
                icon: Icon(Icons.share),
                onPressed: (){},
              )
            ],
          ),
        ),
      ),


    );
  }
}