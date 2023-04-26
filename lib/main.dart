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
  // perus initialize.
  @override
  void initState() {
    super.initState();
    // haetaan data backendista ja tehdään sille lukuisia asioita.
    getEvents();
    setState(() {
      context.read<EventsProvider>().setEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.white,
      ),
      // ohjelmaikkunan perusrakenne alkaa tästä.
      home: Scaffold(
        extendBodyBehindAppBar: false,
        // yläpalkki.
        appBar: AppBar(
          title: const Text('JKLnyt'),
          backgroundColor: Colors.lightBlue,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        // tässä luodaan sivusta tuleva kategoriavalikko.
        drawer: const NavBar(),
        // stack widgetillä voi luoda elementtejä jotka ovat toistensa päällä
        // -> järjestys on alimmasta päällimmäiseen.
        body: Stack(
          children: <Widget>[
            const GoogleMapWidget(),
            // sässä luodaan bottom sheet kartan päälle.
            BottomSheetWidget(
              scrollController: ScrollController(),
            ),
          ],
        ),
      ),
    );
  }
}
