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
    String eStart = json['tstart'];
    if (eStart == "") {
      eStart = "0";
    }
    String eEnd = json['tend'];
    if (eEnd == "") {
      eEnd = "0";
    }

    return Event(
      name: json['name'] as String,
      day: int.parse(eDay),
      month: int.parse(eMonth),
      tstart: int.parse(eStart),
      tend: int.parse(eEnd),
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
