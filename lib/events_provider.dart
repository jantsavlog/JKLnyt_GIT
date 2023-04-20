import 'package:flutter/material.dart';
import 'package:jklnyt/fetch_events.dart';
import 'event.dart';

class EventsProvider extends ChangeNotifier {
  List<Event> events = [];
  List<Event> shownEvents = [];
  Map<String, bool> categories = {};

  // void buildCategoriesMap(Map<String, bool> newData) async {
  //   getCategories();
  //   categories.addAll(newData);

  //   notifyListeners();
  // }

  // void getCategories() async {
  //   String categoriesJSON = await categoryFile.readAsString();
  //   categories = json.decode(categoriesJSON);
  // }

  void makeCategoryMap() {
    for (Event event in events) {
      String category = event.info['category'];
      categories[category] = event.show;
    }

    writeToFile(categories, 'categories.json');
    notifyListeners();
  }

  void setCategories(Map<String, bool> categories) {
    this.categories = categories;
  }

  void setEvents(List<Event> events) {
    this.events = events;
    shownEvents = events;
    notifyListeners();
  }

  void setShownEvents() {
    shownEvents = [];
    for (Event event in events) {
      if (event.show) {
        shownEvents.add(event);
      }
    }
  }

  void showEvents(String category) {
    for (Event event in events) {
      if (event.info['category'] == category) {
        event.show = !event.show;
      }
    }

    setShownEvents();
    notifyListeners();
  }
}
