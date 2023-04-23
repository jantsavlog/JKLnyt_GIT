import 'package:flutter/material.dart';
import 'package:jklnyt/fetch_events.dart';
import 'event.dart';

class EventsProvider extends ChangeNotifier {
  List<Event> events = [];
  List<Event> shownEvents = [];
  Map<String, dynamic> categories = {};

  // vaihtaa kategoriavalinnan päinvastaiseksi, kirjoittaa tiedostoon ja muuttaa
  // event-listausta
  void categorySwitch(String category) {
    categories[category] = !categories[category];
    writeToFile(categories, 'categories.json');
    showEvents();
  }

  // luo mapin saatavilla olevista kategorioista, jos kategoria ei ole "uusi" ei
  // sille tehdä mitään, jotta käyttäjäpreferenssien eheys säilyisi
  void makeCategoryMap() {
    Map<String, int> newCategories = Map.fromEntries(
      categories.entries.map((entry) => MapEntry(entry.key, 0)),
    );
    for (Event event in events) {
      String category = event.info['category'];
      if (!categories.keys.contains(category)) {
        newCategories[category] = 1;
        categories[category] = event.show;
      } else {
        newCategories[category] = (newCategories[category] ?? 0) + 1;
      }
    }

    newCategories.forEach(
      (key, value) {
        if (categories.containsKey(key) && value == 0) {
          categories.remove(key);
        }
      },
    );

    writeToFile(categories, 'categories.json');
    notifyListeners();
  }

  // ohjelman käynniestyessä tiedostosta luetut kategoriat asetetaan muuttujaan
  void setCategories(Map<String, dynamic> categories) {
    this.categories = categories;
    makeCategoryMap();
  }

  // hyvin monitoiminen alustusmetodi, hakee eventit ja laittaa ne listaan,
  // hakee myös kategoriat ja laittaa ne mappiin sekä katsoo mitkä tapahtumat
  // kuuluu näyttää
  void setEvents() async {
    final eventContent = await loadEvents();
    events = convertToEventList(eventContent);
    final categoryContent = await loadCategories();
    setCategories(categoryContent);
    showEvents();
    notifyListeners();
  }

  // luo listan tapahtumista jotka kuuluu näyttää, kaikki joita ei kuulu näyttää
  // eivät tule tähän listaan ollenkaan
  void setShownEvents() {
    shownEvents = [];
    for (Event event in events) {
      if (event.show) {
        shownEvents.add(event);
      }
    }
  }

  // asettaa jokaisen tapahtumat show-arvon sen kategorian perusteella
  void showEvents() {
    for (Event event in events) {
      event.show = categories[event.info['category']];
    }

    setShownEvents();
    notifyListeners();
  }
}
