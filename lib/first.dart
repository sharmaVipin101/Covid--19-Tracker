import 'dart:math';

import 'package:flutter/material.dart';
import 'package:testing/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:testing/second.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
List<dynamic> data;
List fieldszz;
int value;
bool loadingq = false;

final TextEditingController _controller = TextEditingController();
final globalKey = new GlobalKey();
String _searchText = "";
bool _isSearching=false;
List searchResult = new List();


  void getapi() async{

    try{
      http.Response response = await http.get("https://coronavirus-19-api.herokuapp.com/countries");

      data = json.decode(response.body);

     // print(data);


      setState(() {
        fieldszz = data;
        loadingq = true;
      });
    }
catch(e){
      print(e);
}

  }

  Widget appBarTitle = new Text(
   "Covid-19 Tracker",
   style: TextStyle(
     color: Colors.white
   ),
  );

  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  void initState(){
  super.initState();
  getapi();
  }

  void _handleSearchStart(){
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd(){
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );

      this.appBarTitle = new Text(
        "Covid-19 Tracker",
        style: TextStyle(
          color: Colors.white,
        ),
      );

      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String text){

    searchResult.clear();
    if(_isSearching!=null)
      {
        for(int i=0;i<fieldszz.length;i++)
          {
            String data = fieldszz[i];
            if(data.toLowerCase().contains(text.toLowerCase()))
              {
                searchResult.add(data);
              }
          }
      }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      title: appBarTitle,
      actions: [
        IconButton(
          icon: icon,
          onPressed: (){
            setState(() {
              if(this.icon.icon==Icons.search){
                this.icon = new Icon(
                  Icons.close,
                  color: Colors.white,
                );
              this.appBarTitle = new TextField(
                controller: _controller,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                  prefixIcon:new Icon(Icons.search,color: Colors.white,) ,
                  hintText: "Search...",
                  hintStyle: new TextStyle(color: Colors.white)
                ),
                onChanged: searchOperation,
              );
              _handleSearchStart();
              }else _handleSearchEnd();
            });
          },
        )
      ],
    ),
      body: loadingq==true?ListView.builder(


        itemCount: fieldszz==null?0:fieldszz.length,
        itemBuilder: (context,index){
          return Card(
            color: Colors.white,
            child: ListTile(

              onTap: ()async {

                value = index;

                Navigator.push(context, new MaterialPageRoute(
                  builder:(context)=> Second(value:value),
                ));
//                  Navigator.pushNamed(context, '/second',arguments: value);
              },
              title: Text(
                "${fieldszz[index]["country"]}",
                style: TextStyle(
                    fontSize: 28.0,
                    fontFamily: "Times New Roman"
                ),
              ),
              subtitle: Text(
                "New Cases ${fieldszz[index]["todayCases"]}",
              ),
              autofocus: true,

            ),

          );
        },
      )
          :Center(
    child:SpinKitPumpingHeart(
     color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    size: 80.0,
    ),
    ),
    );
  }
}


