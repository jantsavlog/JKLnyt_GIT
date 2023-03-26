import 'package:flutter/material.dart';
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

  Map<String, dynamic> toJson() => {
        'name': name,
        'day': day,
        'month': month,
        'tstart': tstart,
        'tend': tend,
        'price': price,
        'agelimit': ageLimit,
        'info': info
      };

  const Event({
    required this.name,
    required this.day,
    required this.month,
    required this.tstart,
    required this.tend,
    required this.price,
    required this.ageLimit,
    required this.info,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    //String eName = json['name'].toString();
    //int day = int.parse(json['day']);
    String eMonth = json['month'];
    if (eMonth == "") {
      eMonth = "0";
    }

    return Event(
      name: json['name'] as String,
      day: int.parse(json['day']),
      month: int.parse(eMonth),
      tstart: int.parse(json['tstart']),
      tend: int.parse(json['tend']),
      price: json['price'] as String,
      ageLimit: json['agelimit'] as String,
      info: json['info'] as String,
    );
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

void resToJSON(String response) async {
  final List<dynamic> jsonArr =
      jsonDecode(response).cast<Map<String, dynamic>>();

  List<Event> events = List.empty(growable: true);

  // mongoDB muodosta Event-objektiin
  for (int i = 0; i < jsonArr.length; i++) {
    events.add(Event.fromJson(jsonArr[i]));
  }
  // luo JSON
  List<dynamic> jsonList = [];
  for (int i = 0; i < events.length; i++) {
    jsonList.add(events[i].toJson());
  }

  final jsonString = jsonEncode(jsonList);

  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/test.json');
  await file.writeAsString(jsonString);
  print("--- TALLENNETTU ${file.path}");
}
