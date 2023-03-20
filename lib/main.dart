//import 'dart:convert';
//import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bottom_sheet.dart';
import 'google_maps.dart';
import 'package:jklnyt/navbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map> categories = [];
  List<Map<String, dynamic>> events = [];

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    final jsonFile = await rootBundle.loadString('assets/events.json');
    final jsonData = json.decode(jsonFile);
    setState(() {
      events = List<Map<String, dynamic>>.from(jsonData['events']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('JKLnyt'),
          backgroundColor: const Color.fromARGB(255, 85, 189, 250),
        ),
        drawer: NavBar(
          categories: categories,
          toggleCategory: (int) => 0,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMapWidget(),
            BottomSheetWidget(
              scrollController: ScrollController(),
              events: events,
            ),
          ],
        ),
      ),
    );
  }
}
