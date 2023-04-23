import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'event.dart';

class EventTile extends StatelessWidget {
  final Event event;
  const EventTile({Key? key, required this.event}) : super(key: key);

  String formatTime(Event event) {
    if (event.info['tend'] == '0') {
      if (event.info['tstart'] == '0') {
        return 'Ei tiedossa';
      }
      return '${event.info['tstart']}-';
    }

    return '${event.info['tstart']}-${event.info['tend']}';
  }

  String formatDate(Event event) {
    return '${event.info['date'].day}.${event.info['date'].month}';
  }

  String formatPrice(Event event) {
    if (event.info['price'] == 'Ei tiedossa') {
      return event.info['price'];
    }

    return '${event.info['price']}€';
  }

  Future<void> _launchInfo() async {
    String url = event.info['info'];
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            if (event.info['info'] == "") ...[
              Text(event.info['venue']),
            ] else ...[
              Text(event.info['venue']),
              IconButton(
                icon: const Icon(Icons.info),
                onPressed: _launchInfo,
              )
            ]
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.info['name']),
            const SizedBox(height: 4),
            Text('Päivämäärä: ${formatDate(event)}'),
            const SizedBox(height: 4),
            Text('Aika: ${formatTime(event)}'),
            const SizedBox(height: 4),
            Text('Hinta: ${formatPrice(event)}'),
            const SizedBox(height: 4),
            Text('Ikäraja: ${event.info['agelimit']}'),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
