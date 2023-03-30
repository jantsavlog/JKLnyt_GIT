import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Event {
  final String name;
  final int day;
  final int month;
  final int tstart;
  final int tend;
  final String price;
  final String ageLimit;
  final String info;
  final String venue;
  final String category;
  final double lat;
  final double lon;

  Map<String, dynamic> toJson() => {
        'name': name,
        'day': day,
        'month': month,
        'tstart': tstart,
        'tend': tend,
        'price': price,
        'agelimit': ageLimit,
        'info': info,
        'venue': venue,
        'category': category,
        'lat': lat,
        'lon': lon
      };

  const Event(
      {required this.name,
      required this.day,
      required this.month,
      required this.tstart,
      required this.tend,
      required this.price,
      required this.ageLimit,
      required this.info,
      required this.category,
      required this.venue,
      required this.lat,
      required this.lon});

  factory Event.fromJson(Map<String, dynamic> json) {
    // jos numerotyyppinen arvo puuttuu JSON:ista ja koitetaan int.parse(),
    // tulee error, siksi eka muutetaan Stringiksi ja tarkistetaan onko tyhjä
    // vai ei ja sitten parsitaan vasta numeroksi
    String eMonth = json['month'];
    if (eMonth == "") {
      eMonth = "0";
    }
    String eDay = json['day'];
    if (eDay == "") {
      eDay = "0";
    }
    dynamic eStart = json['tstart'];
    if (eStart.runtimeType != int) {
      eStart = 0;
    }
    dynamic eEnd = json['tend'];
    if (eEnd.runtimeType != int) {
      eEnd = 0;
    }
    dynamic ePrice = json['price'];
    if (ePrice.runtimeType != String) {
      ePrice = ePrice.toString();
    }
    dynamic eAge = json['agelimit'];
    if (eAge.runtimeType != String) {
      eAge = "Ei ikärajaa";
    }

    return Event(
        name: json['name'] as String,
        day: int.parse(eDay),
        month: int.parse(eMonth),
        tstart: eStart,
        tend: eEnd,
        price: ePrice as String,
        ageLimit: eAge,
        info: json['info'] as String,
        venue: json['venue'] as String,
        category: json['category'] as String,
        lat: json['lat'],
        lon: json['lon']);
  }
}

// hae tapahtumat palvelimelta
void getEvents() async {
  final res = await http.get(Uri.parse('https://mobdevsrv-1.it.jyu.fi/get'));

  // vastaus ok
  if (res.statusCode == 200) {
    resToJSON(res.body);
  } else {
    // jotain meni vikaan
    throw Exception('Tapahtumien haku epäonnistui');
  }
}

// muuta vastaus JSON:iksi
void resToJSON(String response) async {
  final List<dynamic> jsonArr =
      jsonDecode(response).cast<Map<String, dynamic>>();

  List<Event> events = List.empty(growable: true);

  // mongoDB muodosta Event-objektiin
  for (int i = 0; i < jsonArr.length; i++) {
    events.add(Event.fromJson(jsonArr[i]));
  }
  // luo JSON-lista
  List<dynamic> jsonList = [];
  for (int i = 0; i < events.length; i++) {
    jsonList.add(events[i].toJson());
  }

  // tee JSON objekti jonka sisään lista menee
  Map<String, dynamic> jsonObject = {"events": []};
  jsonObject["events"] = jsonList;

  final jsonString = jsonEncode(jsonObject);

  // tallenna tiedostoon
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/test.json');
  await file.writeAsString(jsonString);
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/test.json');
}

Future<String> readJSONFile() async {
  try {
    final file = await _localFile;

    // lue JSON
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    // jos ei onnistu, palauta tyhjä string
    return "";
  }
}
