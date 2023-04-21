import 'package:flutter/material.dart';
import 'package:jklnyt/events_provider.dart';
import 'package:provider/provider.dart';
import 'event.dart';
import 'event_tile.dart';

class BottomSheetWidget extends StatefulWidget {
  final ScrollController scrollController;

  const BottomSheetWidget({Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    List<Event> events = Provider.of<EventsProvider>(context).shownEvents;
    // luodaan bottom sheet, alla olevat double arvot ovat alkukoko, minimikoko,
    // maksimikoko, sekä kohdat mihin sheetti snappaa.
    return DraggableScrollableSheet(
      initialChildSize: 0.04,
      minChildSize: 0.04,
      maxChildSize: 0.9,
      snap: true,
      snapSizes: const [0.5],
      builder: (BuildContext context, ScrollController scrollController) {
        // koska appbar on nyt läpinäkyvä ja kartta venyy sen alle, pitää
        // sisältöä muokata laskemaan asiat hieman eri tavalla.
        return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1.0),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                // tämä widget on tässä jotta saadaan joku ankkuri bottom
                // sheetin avaamiselle.
                SingleChildScrollView(
                  controller: scrollController,
                  child: const SizedBox(
                    width: double.infinity,
                    child: Icon(Icons.drag_handle_rounded),
                  ),
                ),
                // luodaan kaiken saatavilla olevan tilan täyttävä listview,
                // joka on scrollattava luettelo widgettejä.
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Scrollbar(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events.elementAt(index);
                          return EventTile(event: event);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
