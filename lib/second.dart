import 'package:flutter/cupertino.dart';
import 'package:testing/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:testing/first.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flip_card/flip_card.dart';

class Second extends StatefulWidget {

  int value;

  Second({this.value});
  @override
  _SecondState createState() => _SecondState(value);
}

class _SecondState extends State<Second> {

  int value;
  _SecondState(this.value);
  List<dynamic> data;
  List fieldszz;
bool loading = false;
  void getapi() async{

   try{
     http.Response response = await http.get("https://coronavirus-19-api.herokuapp.com/countries");

     data = json.decode(response.body);


     // print(data);


     setState(() {
       fieldszz = data;
       loading = true;
     });
   }
   catch(e){
     print(e);
   }

    // debugPrint(fieldszz.toString());
  }

  void initState(){
    super.initState();
    getapi();


  }

Material myitems(String data,String heading,int color){
    return Material(

      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196f3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: Text(
                      heading,
                      style: TextStyle(
                        color: new Color(color),
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Times New Roman"
                      ),
                    ),
                  ),

                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(24),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        data,
                        style: TextStyle(
                            color:Colors.white,
                          fontSize: 20
                        ),

                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
}


  @override
  Widget build(BuildContext context) {
    return loading==true? Scaffold(


      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "Covid-19 Tracker",
          style: TextStyle(
              fontFamily: 'Times New Roman'
          ),
        ),
      ),
      body:StaggeredGridView.count(
         crossAxisCount: 2,
         crossAxisSpacing: 12.0,
         mainAxisSpacing: 12.0,
         padding:EdgeInsets.symmetric(vertical: 20.0,horizontal: 16.0),
         children: [


           myitems("${fieldszz[value]["country"]}","Country",0xFF00BCD4),
           myitems("${fieldszz[value]["cases"]}","Cases",0xFF00BCD4),
           myitems("${fieldszz[value]["todayCases"]}","New Cases",0xFF00BCD4),
           myitems("${fieldszz[value]["deaths"]}","Deaths",0xFF00BCD4),
           myitems("${fieldszz[value]["todayDeaths"]}","New Deaths",0xFF00BCD4),
           myitems("${fieldszz[value]["recovered"]}","Recovered",0xFF00BCD4),
           myitems(" ${fieldszz[value]["active"]}","Active",0xFF00BCD4),


//0xffed622b

         ],

         staggeredTiles: [



           StaggeredTile.extent(2,130.0),
           StaggeredTile.extent(1,150.0),
           StaggeredTile.extent(1,150.0),
           StaggeredTile.extent(1,150.0),
           StaggeredTile.extent(1,150.0),
           StaggeredTile.extent(1,150.0),
           StaggeredTile.extent(1,150.0),


         ],




       ),



    ): Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:SpinKitPumpingHeart(

          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          size: 80.0,

        ),

//        child: Container(
//          child: Text(
//            'loading...'
//          ),
//        ),
      )
    );

  }
}
