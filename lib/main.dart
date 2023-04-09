import 'dart:convert';
import 'package:flutter/material.dart';
import 'bottom_sheet.dart';
import 'event_controller.dart';
import 'google_maps.dart';
import 'package:jklnyt/navbar.dart';
import 'fetch_events.dart';
import 'event.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // Lista, jonka sisällä useampi Mappi, tämän on tarkoitus saada sisältönsä
  // assets-kansion events.json tiedostosta, johon myöhemmin ohjataan skreipattu
  // data.
  Events events = Events({});

  // Perus initialize.
  @override
  void initState() {
    super.initState();
    // Tässä käsketään ohjelman käynnistyessä lataamaan tapahtumien data
    // taustalla events listaan.
    getEvents();
    loadEvents();
  }

  Map<Event, bool> convertToEventMap(List<Map<String, dynamic>> content) {
    Map<Event, bool> events = {};
    content.forEach((element) {
      events[Event.fromJson(element)] = true;
    });
    events = Map.fromEntries(
        events.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
    return events;
  }

  // Tämä taustalla ajettava Future etsii events.jsonin, dekoodaa sen, ja
  // sijoittaa sen listaan.
  Future<void> loadEvents() async {
    // JSON-file haetaan fetch_events.dartissa
    final jsonData = await readJSONFile();
    final content = json.decode(jsonData).cast<Map<String, dynamic>>();
    // setState()-metodi päivittää StatefulWidgetin tilan.
    setState(() {
      events = Events(convertToEventMap(content));
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
