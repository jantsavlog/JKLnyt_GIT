import 'package:flutter/material.dart';

import 'event_controller.dart';

class EventsProvider extends ChangeNotifier {
  Events _events;

  EventsProvider(this._events);

  Events get events => _events;

  void updateEvents(Events events) {
    _events = events;
    notifyListeners();
  }
}
