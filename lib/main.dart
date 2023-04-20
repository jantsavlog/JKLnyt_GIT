import 'package:flutter/material.dart';
import 'package:jklnyt/events_provider.dart';
import 'package:provider/provider.dart';
import 'bottom_sheet.dart';
import 'google_maps.dart';
import 'package:jklnyt/navbar.dart';
import 'fetch_events.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (_) => EventsProvider(),
      child: const MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // Perus initialize.
  @override
  void initState() {
    super.initState();
    // Tässä käsketään ohjelman käynnistyessä lataamaan tapahtumien data
    // taustalla events listaan.
    getEvents();
    loader();
  }

  void loader() async {
    final content = await loadEvents();
    setState(() {
      context.read<EventsProvider>().setEvents(convertToEventList(content));
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
        drawer: const NavBar(),
        // Stack widgetillä voi luoda elementtejä jotka ovat toistensa päällä
        // -> Järjestys on alimmasta päällimmäiseen.
        body: Stack(
          children: <Widget>[
            const GoogleMapWidget(),
            // Tässä luodaan bottom sheet kartan päälle.
            BottomSheetWidget(
              scrollController: ScrollController(),
            ),
          ],
        ),
      ),
    );
  }
}
