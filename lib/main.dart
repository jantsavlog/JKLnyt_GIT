//import 'dart:convert';
//import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bottom_sheet.dart';
import 'google_maps.dart';
import 'package:jklnyt/navbar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // Lista kategorioista testaamista varten.
  List<Map> categories = [];
  // Lista, jonka sisällä useampi Mappi, tämän on tarkoitus saada sisältönsä
  // assets-kansion events.json tiedostosta, johon myöhemmin ohjataan skreipattu
  // data.
  List<Map<String, dynamic>> events = [];

  // Perus initialize.
  @override
  void initState() {
    super.initState();
    // Tässä käsketään ohjelman käynnistyessä lataamaan tapahtumien data
    // taustalla events listaan.
    loadEvents();
  }

  // Tämä taustalla ajettava Future etsii events.jsonin, dekoodaa sen, ja
  // sijoittaa sen listaan.
  Future<void> loadEvents() async {
    // Etsintä.
    final jsonFile = await rootBundle.loadString('assets/events.json');
    // Dekoodaus.
    final jsonData = json.decode(jsonFile);
    // setState()-metodi päivittää StatefulWidgetin tilan.
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
      // Itse ohjelmaikkunan perusrakenne alkaa tästä.
      home: Scaffold(
        extendBodyBehindAppBar: true,
        // Yläpalkki.
        appBar: AppBar(
          title: const Text('JKLnyt'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        // Tässä luodaan sivusta tuleva kategoriavalikko.
        drawer: NavBar(
          //categories: categories,
          events: events,
        ),
        // Stack widgetillä voi luoda elementtejä jotka ovat toistensa päällä
        // -> Järjestys on alimmasta päällimmäiseen.
        body: Stack(
          children: <Widget>[
            GoogleMapWidget(),
            // Tässä luodaan bottom sheet kartan päälle.
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
