import 'package:flutter/material.dart';
import 'event.dart';

class EventTile extends StatelessWidget {
  final Event event;
  const EventTile({Key? key, required this.event}) : super(key: key);

  String formatTime(Event event) {
    if (event.tend == '0') {
      if (event.tstart == '0') {
        return 'Ei tiedossa';
      }
      return '${event.tstart}-';
    }

    return '${event.tstart}-${event.tend}';
  }

  String formatDate(Event event) {
    return '${event.date.day}.${event.date.month}';
  }

  String formatPrice(Event event) {
    if (event.price == 'Ei tiedossa') {
      return event.price;
    }

    return '${event.price}€';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(event.venue),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.name),
            const SizedBox(height: 4),
            Text('Päivämäärä: ${formatDate(event)}'),
            const SizedBox(height: 4),
            Text('Aika: ${formatTime(event)}'),
            const SizedBox(height: 4),
            Text('Hinta: ${formatPrice(event)}'),
            const SizedBox(height: 4),
            Text('Ikäraja: ${event.ageLimit}'),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
