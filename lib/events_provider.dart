import 'package:flutter/material.dart';
import 'event.dart';

class EventsProvider extends ChangeNotifier {
  List<Event> _events;

  EventsProvider(this._events);

  List<Event> get events => _events;

  void updateEvents(List<Event> events) {
    _events = events;
    notifyListeners();
  }
}
