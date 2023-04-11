import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// hae tapahtumat palvelimelta
void getEvents() async {
  Uri url = Uri.parse('https://mobdevsrv-1.it.jyu.fi/get');
  final res = await http.get(url);

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
