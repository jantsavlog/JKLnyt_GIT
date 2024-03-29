import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'event.dart';

// ----- BACKEND FETCH -----
// hae tapahtumat palvelimelta
void getEvents() async {
  const apiKey = '';
  const url = 'https://mobdevsrv-1.it.jyu.fi/get';

  final res = await http.get(
    Uri.parse(url),
    headers: {'X-API-KEY': apiKey},
  );

  // vastaus ok
  if (res.statusCode == 200) {
    resToJSON(res.body);
  } else {
    // jotain meni vikaan
    throw Exception('Tapahtumien haku epäonnistui');
  }
}

// ----- USER PREFERENCE HANDLING -----
Future<Map<String, dynamic>> loadCategories() async {
  final jsonData = await readJSONFile('categories.json');
  if (jsonData.isNotEmpty) {
    final content = json.decode(jsonData);
    return content;
  }
  return {};
}

// ----- EVENT HANDLING -----
// haetaan json-file ja palautetaan sisältö
Future<List<Map<String, dynamic>>> loadEvents() async {
  final jsonData = await readJSONFile('test.json');
  final content = json.decode(jsonData).cast<Map<String, dynamic>>();
  return content;
}

// muutetaan lista json-objekteja Event-listaksi, samalla Eventit laitetaan
// aikajärjestykseen
List<Event> convertToEventList(List<Map<String, dynamic>> content) {
  List<Event> events = [];
  for (var element in content) {
    events.add(Event.fromJson(element));
  }
  events.sort((a, b) => a.compareTo(b));
  return events;
}

// ----- FILE HANDLING -----
// muuta vastaus JSON:iksi
void resToJSON(String response) async {
  final List<dynamic> jsonArr =
      jsonDecode(response).cast<Map<String, dynamic>>();

  final jsonString = jsonEncode(jsonArr);

  // tallenna tiedostoon
  //final directory = await getApplicationDocumentsDirectory();
  final file = await localFile('test.json');
  await file.writeAsString(jsonString);
}

// tiedostoon kirjoituksen apumetodi
void writeToFile(Map<String, dynamic> contents, String fileName) async {
  final file = await localFile(fileName);
  await file.writeAsString(jsonEncode(contents));
}

// haetaan lokaalien tiedostojen kansio
Future<String> localPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

// haetaan lokaalien tiedostojen kansioista oikea tiedosto
Future<File> localFile(String fileName) async {
  final path = await localPath();
  return File('$path/$fileName');
}

// luetaan tiedostosta ja palautetaan json-string, jos ei onnistu palautetaan
// tyhjä.
Future<String> readJSONFile(String fileName) async {
  try {
    final file = await localFile(fileName);
    // lue JSON
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    // jos ei onnistu, palauta tyhjä string
    return "";
  }
}
