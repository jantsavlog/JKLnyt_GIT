import 'package:flutter/material.dart';
import 'bottom_sheet.dart';
import 'google_maps.dart';
import 'package:jklnyt/navbar.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<_MyAppState>();
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          backgroundColor: Color.fromARGB(255, 85, 189, 250),
        ),
        drawer: NavBar(
        categories:  List<Map>,
        toggleCategory: ()=>false,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMapWidget(),
            BottomSheetWidget(scrollController: ScrollController()),
            
          ],
        ),
      ),
    );
  }
}
