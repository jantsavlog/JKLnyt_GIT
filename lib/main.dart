import 'package:flutter/material.dart';
import 'package:jklnyt/navbar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'JKLnyt',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<Map> categories = [
    {'name': 'Music', "isChecked": false},
    {'name': 'Sports', "isChecked": false},
    {'name': 'Outdoors', "isChecked": false},
    {'name': 'Culture', "isChecked": false},
    {'name': 'Culture1', "isChecked": false},
    {'name': 'Culture2', "isChecked": false},
    {'name': 'Culture3', "isChecked": false},
    {'name': 'Culture4', "isChecked": false},
    {'name': 'Culture5', "isChecked": false},
    {'name': 'Culture6', "isChecked": false},
    {'name': 'Culture7', "isChecked": false},
    {'name': 'Culture8', "isChecked": false},
    {'name': 'Culture9', "isChecked": false},
    {'name': 'Culture11', "isChecked": false},
    {'name': 'Culture22', "isChecked": false},
    {'name': 'Culture33', "isChecked": false},
    {'name': 'Culture44', "isChecked": false},
    {'name': 'Culture55', "isChecked": false},
  ];

  void toggleCategory(int index) {
    categories[index]['isChecked'] = !categories[index]['isChecked'];
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      drawer: NavBar(
        categories: appState.categories,
        toggleCategory: appState.toggleCategory,
      ),
      body: Column(
        children: [
          AppBar(
            title: const Text('JKLnyt'),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "Oletettu kartta",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.yellow,
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "Lista",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
