import 'package:flutter/material.dart';
import 'event.dart';

class EventsProvider extends ChangeNotifier {
  List<Event> events = [];
  List<Event> shownEvents = [];

  // EventsProvider(this._events);

  // List<Event> get events => _events;

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
