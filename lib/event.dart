class Event {
  final Map<String, dynamic> info;
  final bool show;
  // final String name;
  // final DateTime date;
  // final String tstart;
  // final String tend;
  // final String price;
  // final String ageLimit;
  // final String info;
  // final String venue;
  // final String category;
  // final double lat;
  // final double lon;

  const Event({
    required this.info,
    required this.show,
    //required this.name,
    //required this.date,
    //required this.tstart,
    //required this.tend,
    //required this.price,
    //required this.ageLimit,
    //required this.info,
    //required this.category,
    //required this.venue,
    //required this.lat,
    //required this.lon
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    // jos numerotyyppinen arvo puuttuu JSON:ista ja koitetaan int.parse(),
    // tulee error, siksi eka muutetaan Stringiksi ja tarkistetaan onko tyhjä
    // vai ei ja sitten parsitaan vasta numeroksi
    bool eShow = true;
    if (json['show'] == 'false') {
      eShow = json['show'];
    }
    DateTime eDate = DateTime.now();
    if (json['month'] != "" && json['day'] != "") {
      eDate = DateTime(DateTime.now().year, int.parse(json['month']),
          int.parse(json['day']));
      if (eDate.isBefore(DateTime.now())) {
        eDate = DateTime(eDate.year + 1, eDate.month, eDate.day);
      }
    } else if (json['date']) {
      eDate = DateTime.parse(json['date']);
    }
    String eStart = json['tstart'].toString();
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
      //name: json['name'] as String,
      //date: eDate,
      //tstart: eStart,
      //tend: eEnd,
      //price: ePrice as String,
      //ageLimit: eAge,
      //info: json['info'] as String,
      //venue: json['venue'] as String,
      //category: json['category'] as String,
      //lat: json['lat'],
      //lon: json['lon']
    );
  }

  compareTo(Event b) {
    return info['date'].compareTo(b.info['date']);
  }
}
