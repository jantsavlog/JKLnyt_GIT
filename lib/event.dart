class Event {
  final Map<String, dynamic> info;
  bool show;

  Event({
    required this.info,
    required this.show,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    bool eShow = true;
    if (json['show'] == 'false') {
      eShow = json['show'];
    }
    DateTime today = DateTime.now();
    today = DateTime(today.year, today.month, today.day);
    DateTime eDate = DateTime.now();
    if (json['month'] != "" && json['day'] != "") {
      eDate = DateTime(DateTime.now().year, int.parse(json['month']),
          int.parse(json['day']));
      if (eDate.isBefore(today)) {
        eDate = DateTime(eDate.year + 1, eDate.month, eDate.day);
      }
    } else if (json.containsKey('date')) {
      eDate = DateTime.parse(json['date']);
    }
    String eStart = json['tstart'].toString();
    eStart = eStart.length > 5 ? eStart.substring(0, 5) : eStart;
    String parseable = eStart.length >= 2 ? eStart.substring(0, 2) : eStart;
    if (eStart != '0') {
      if (!eStart.contains(':')) {
        eStart += ':00';
      }
    }
    String eEnd = json['tend'].toString();
    if (eEnd != '0') {
      if (!eEnd.contains(':')) {
        eEnd += ':00';
      }
    }
    eDate = eDate.add(Duration(hours: int.parse(parseable)));
    dynamic ePrice = json['price'];
    if (ePrice.runtimeType != String) {
      ePrice = ePrice.toString();
    }
    dynamic eAge = json['agelimit'];
    if (eAge.runtimeType != String) {
      eAge = "Ei ikärajaa";
    }
    Map<String, dynamic> eEvent = {
      'show': eShow,
      'name': json['name'],
      'date': eDate,
      'tstart': eStart,
      'tend': eEnd,
      'price': ePrice,
      'agelimit': eAge,
      'info': json['info'] as String,
      'venue': json['venue'] as String,
      'category': json['category'] as String,
      'lat': json['lat'],
      'lon': json['lon']
    };
    return Event(
      info: eEvent,
      show: eShow,
    );
  }

  compareTo(Event b) {
    return info['date'].compareTo(b.info['date']);
  }
}
