import 'event.dart';

class Events {
  final Map<Event, bool> events;

  Events(this.events);

  void showEvents(String category) {
    events.forEach((event, show) {
      if (event.category == category) {
        show = !show;
      }
    });
  }
}
