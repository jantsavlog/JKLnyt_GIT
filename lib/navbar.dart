import 'package:flutter/material.dart';
import 'package:jklnyt/events_provider.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  // perus initialize.
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<EventsProvider>(context).categories;
    return Drawer(
      child: Column(
        children: [
          // safearea estää tavaraa menemästä esim. laitteen kameran syvennöksen
          // alle.
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: const Center(
                child: Text(
                  'Kategoriat',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
          // divider luo ohuen viivan widgettien väliin.
          const Divider(height: 0.0),
          // expanded varmistaa, että widget on aina juuri niin iso kuin sille
          // on tilaa annettu.
          Expanded(
            // scrollbar tuo mukaan näkyvän scrollauspalkin (jos koko sisältö ei
            // mahdu ruudulle).
            child: Scrollbar(
              // builder voi ottaa kourallisen elementtejä käsittelyyn ja luo
              // niistä scrollattavan visuaalisen listan.
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: categories.values.elementAt(index)
                            ? const Icon(Icons.check, color: Colors.blue)
                            : const Icon(Icons.add, color: Colors.blue),
                        title: Text(categories.keys.elementAt(index)),
                        onTap: () => setState(
                              () => context
                                  .read<EventsProvider>()
                                  .categorySwitch(
                                      categories.keys.elementAt(index)),
                            ));
                  }),
            ),
          )
        ],
      ),
    );
  }
}
