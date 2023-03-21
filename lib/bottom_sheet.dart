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
    // Luodaan bottom sheet, alla olevat double arvot ovat alkukoko, minimikoko,
    // maksimikoko, sekä kohdat mihin sheetti snappaa.
    return DraggableScrollableSheet(
      initialChildSize: 0.038,
      minChildSize: 0.038,
      maxChildSize: 0.9,
      snap: true,
      snapSizes: const [0.5],
      builder: (BuildContext context, ScrollController scrollController) {
        // Koska appbar on nyt läpinäkyvä ja kartta venyy sen alle, pitää
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
                // Tämä widget on tässä jotta saadaan joku ankkuri bottom
                // sheetin avaamiselle.
                SingleChildScrollView(
                  controller: scrollController,
                  child: const SizedBox(
                    height: 32,
                    width: double.infinity,
                    child: Icon(Icons.drag_handle_rounded),
                  ),
                ),
                // Luodaan kaiken saatavilla olevan tilan täyttävä listview,
                // joka on scrollattava luettelo widgettejä.
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return EventTile(event: event);
                      },
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
