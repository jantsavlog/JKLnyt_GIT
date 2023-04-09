import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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

  //List<Event> events = List.empty(growable: true);

  // mongoDB muodosta Event-objektiin
  //for (int i = 0; i < jsonArr.length; i++) {
  //events.add(Event.fromJson(jsonArr[i]));
  //}
  // luo JSON-lista
  //List<dynamic> jsonList = [];
  //for (int i = 0; i < events.length; i++) {
  //jsonList.add(events[i].toJson());
  //}

  // tee JSON objekti jonka sisään lista menee
  //Map<String, dynamic> jsonObject = {"events": []};
  //jsonObject["events"] = jsonList;

  final jsonString = jsonEncode(jsonArr);

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
