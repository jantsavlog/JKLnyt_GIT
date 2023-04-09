import 'package:flutter/material.dart';
import 'event_controller.dart';

class NavBar extends StatefulWidget {
  final Events events;

  const NavBar({Key? key, required this.events}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Map<String, bool> categories = {};

  // Perus initialize.
  @override
  void initState() {
    super.initState();
    // Tässä vain luodaan mappi jota käytetään ns. "kytkimenä", onko kategoria
    // valittu vai ei.
    categories = makeCategoryMap();
  }

  // Tämä metodi käy läpi venueCategories mapin ja vertaa omia avainarvojaan
  // events-listaan, jos arvot käyvät yhteen (kyseisestä paikasta löytyy
  // tapahtuma) lisätään tapahtuman kategoria kategorialistaan (ellei se jo ole
  // siellä).
  Map<String, bool> makeCategoryMap() {
    var availableCategories = <String, bool>{};
    widget.events.events.forEach((event, show) {
      String category = event.category;
      if (!availableCategories.keys.contains(category)) {
        availableCategories[category] = show;
      }
    });

    return availableCategories;
  }

  // Kytkee tapahtuman valituksi ja pois.
  void toggleCategory(String category) {
    categories[category] = !categories[category]!;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // SafeArea estää tavaraa menemästä esim. laitteen kameran syvennöksen
          // alle.
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: const Center(
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
          // Divider luo ohuen viivan widgettien väliin.
          const Divider(height: 0.0),
          // Expanded varmistaa, että widget on aina juuri niin iso kuin sille
          // on tilaa annettu.
          Expanded(
            // Scrollbar tuo mukaan näkyvän scrollauspalkin (jos koko sisältö ei
            // mahdu ruudulle).
            child: Scrollbar(
              // Builder voi ottaa kourallisen elementtejä käsittelyyn ja luo
              // niistä scrollattavan visuaalisen listan.
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: categories.values.elementAt(index)
                            ? const Icon(Icons.check)
                            : const Icon(Icons.add),
                        title: Text(categories.keys.elementAt(index)),
                        onTap: () => setState(
                              () => toggleCategory(
                                  categories.keys.elementAt(index)),
                            ));
                  }),
            ),
          ),
          const Divider(height: 0.0),
          // Tämän containerin sisältä löytyy kielenvaihtonapit, pitää miettiä
          // tehdäänkö niitä loppuun asti.
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    // functionality
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF002F6C),
                  ),
                  child: const Text(
                    'FI',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                TextButton(
                  onPressed: () {
                    // functionality
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFCF142B),
                  ),
                  child: const Text(
                    'EN',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
