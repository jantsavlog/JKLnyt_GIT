import 'package:flutter/material.dart';
import 'event_tile.dart';

class BottomSheetWidget extends StatelessWidget {
  final ScrollController scrollController;
  final List<Map<String, dynamic>> events;

  const BottomSheetWidget(
      {Key? key, required this.scrollController, required this.events})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.05,
      minChildSize: 0.05,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.keyboard_arrow_up),
                  ],
                ),
                const SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return EventTile(event: event);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
