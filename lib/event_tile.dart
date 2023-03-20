import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  final Map<String, dynamic> event;
  const EventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event['venue']),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(event['name']),
          const SizedBox(height: 4),
          Text('Date: ${event['day']}/${event['month']}'),
          const SizedBox(height: 4),
          Text('Time: ${event['tstart']}-${event['tend']}'),
          const SizedBox(height: 4),
          Text('Ticket price: ${event['price']}'),
          const SizedBox(height: 4),
          Text('Age limit: ${event['agelimit']}'),
        ],
      ),
      onTap: () {},
    );
  }
}
