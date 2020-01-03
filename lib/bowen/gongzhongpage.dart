import 'package:flutter/material.dart';
 class GongzhongPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_GongzhongPageState();
   
 }
 class _GongzhongPageState extends State<GongzhongPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
     child: Scaffold(
      appBar: PreferredSize(
          child: AppBar(
           backgroundColor: Colors.redAccent,
           centerTitle: true,
           actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.search), onPressed: () {}),
           ],
           title: Text('公众号'),
          ),
          preferredSize: Size.fromHeight(45)),
     ),
    );
  }
   
 }