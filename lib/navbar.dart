import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final List<Map> categories;
  final Function(int) toggleCategory;

  const NavBar(
      {Key? key, required this.categories, required this.toggleCategory})
      : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: const Center(
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const Divider(height: 0.0),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: widget.categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: widget.categories[index]['isChecked']
                            ? const Icon(Icons.check)
                            : const Icon(Icons.add),
                        title: Text(widget.categories[index]['name']),
                        onTap: () => setState(
                              () => widget.toggleCategory(index),
                            ));
                  }),
            ),
          ),
          const Divider(height: 0.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    // functionality
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF002F6C),
                  ),
                  child: const Text(
                    'FI',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                TextButton(
                  onPressed: () {
                    // functionality
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFCF142B),
                  ),
                  child: const Text(
                    'EN',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
