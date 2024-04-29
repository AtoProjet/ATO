import 'package:ato/components/actions.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets/buttons.dart';
import 'package:ato/components/widgets/cards.dart';
import 'package:ato/components/widgets/global.dart';
import 'package:ato/components/widgets/images.dart';
import 'package:ato/db/consts.dart';
import 'package:ato/providers/item_provider.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/models/cloth_item.dart';
import 'package:ato/models/item.dart';
import 'package:ato/sr_screens/item_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingScreen extends StatefulWidget {
  static Tr title = Tr.shopping;

  ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  // final List<ItemModel> items = [
  //   ItemModel(
  //       id: "123",
  //       name: "Test",
  //       category: "toys",
  //       quantity: 50,
  //       donorId: "123",
  //       details: "details",
  //       image: "assets/items/1.png"),
  //   ClothModel(
  //       id: "123",
  //       name: "Test",
  //       category: "books",
  //       quantity: 50,
  //       donorId: "123",
  //       details: "details",
  //       image: "assets/items/2.png",
  //       size: "L",
  //       forGender: "women",
  //       color: Colors.blue.value),
  //   ItemModel(
  //       id: "123",
  //       name: "Test",
  //       category: "toys",
  //       quantity: 50,
  //       donorId: "123",
  //       details: "details",
  //       image: "assets/items/3.png"),
  //   ClothModel(
  //       id: "123",
  //       name: "Test",
  //       category: "clothes",
  //       quantity: 50,
  //       donorId: "123",
  //       details: "details",
  //       image: "assets/items/4.png",
  //       size: "L",
  //       forGender: "men",
  //       color: Colors.blue.value),
  //   ClothModel(
  //       id: "123",
  //       name: "Test",
  //       category: "shoesAndBags",
  //       quantity: 50,
  //       donorId: "123",
  //       details: "details",
  //       image: "assets/items/5.png",
  //       size: "L",
  //       forGender: "women",
  //       color: Colors.blue.value),
  //   ClothModel(
  //       id: "123",
  //       name: "Test",
  //       category: "clothes",
  //       quantity: 50,
  //       donorId: "123",
  //       details: "details",
  //       image: "assets/items/6.png",
  //       size: "L",
  //       forGender: "children",
  //       color: Colors.blue.value),
  // ];

  final List<bool> _selectedCategories = [true, true, true, true];
  final List<bool> _selectedGenders = [true, true, true];
  final List<bool> _selectedSizes = [true, true, true, true, true];
  final List<Color> _selectedColors = [
    Colors.black,
    Colors.black,
    Colors.black
  ];



  @override
  Widget build(BuildContext context) {
    setAsFullScreen(true);
    LocaleProvider loc = Provider.of(context);
    ItemProvider ipo = Provider.of(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchBarDelegate());
            },
          ),
        ],
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: atoAssetOfIcon("filter.png"),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          );
        }),
      ),
      drawerScrimColor: Colors.transparent,
      endDrawer: atoDrawer(loc),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Stack(
            children: [
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 20.0,
                  mainAxisExtent: 160,
                ),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  for (ItemModel item in ipo.items)
                    showItemCard(loc: loc, item: item),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItemCard({required ItemModel item, required LocaleProvider loc}) {
    int catIndex = categories.indexOf(item.category);
    if (!_selectedCategories[catIndex]) {
      return const SizedBox(
        height: 0,
      );
    }
    if (item is ClothModel) {
      int genderIndex = genders.indexOf(item.forGender);
      int sizeIndex = sizes.indexOf(item.size);
      if (!_selectedGenders[genderIndex] || !_selectedSizes[sizeIndex]) {
        return const SizedBox(
          height: 0,
        );
      }
    }
    String text = item.name +
        ((item is ClothModel) ? " ${loc.of(Tr.size)}:${item.size}" : "");

    return atoShopItemCard(context, item, loc);
  }

  Drawer atoDrawer(LocaleProvider loc) {
    return Drawer(
      backgroundColor: Colors.grey.shade300,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Text(
              loc.of(Tr.filter),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            Text("${loc.of(Tr.forG)}:"),
            Wrap(
              direction: Axis.horizontal,
              children: [
                for (int i = 0; i < genders.length; i++)
                  SizedBox(
                    width: 120,
                    child: atoCheckBox(
                      context: context,
                      index: i,
                      text: loc.ofStr(genders[i]),
                      val: _selectedGenders[i],
                      onChange: (index, value) {
                        setState(() {
                          _selectedGenders[index] = value;
                        });
                      },
                    ),
                  ),
              ],
            ),
            Text("${loc.of(Tr.categories)}:"),
            Wrap(
              direction: Axis.horizontal,
              children: [
                for (int i = 0; i < categories.length; i++)
                  atoCheckBox(
                    context: context,
                    index: i,
                    text: loc.ofStr(categories[i]),
                    val: _selectedCategories[i],
                    onChange: (index, value) {
                      setState(() {
                        _selectedCategories[index] = value;
                      });
                    },
                  ),
              ],
            ),
            Text("${loc.of(Tr.size)}:"),
            Wrap(
              direction: Axis.horizontal,
              children: [
                for (int i = 0; i < sizes.length; i++)
                  SizedBox(
                    width: 80,
                    child: atoCheckBox(
                      context: context,
                      index: i,
                      text: loc.ofStr(sizes[i]),
                      val: _selectedSizes[i],
                      onChange: (index, value) {
                        setState(() {
                          _selectedSizes[index] = value;
                        });
                      },
                    ),
                  ),
              ],
            ),
            Text("${loc.of(Tr.color)}:"),
            Wrap(
              children: [
                for (int i = 0; i < 3; i++)
                  SizedBox(
                    width: 80,
                    child: atoColorPickerButton(
                        context: context,
                        selectedColor: _selectedColors[i],
                        onChange: (color) {
                          setState(() {
                            _selectedColors[i] = color;
                          });
                        }),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SearchBarDelegate extends SearchDelegate<ItemModel?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    List<ItemModel> items = [];



    return Center(
        child: Stack(children: [
      Text('${loc.of(Tr.searchResultsFor)}: $query'),
      GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 20.0,
          mainAxisExtent: 160,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          for (ItemModel item in items) atoShopItemCard(context, item, loc),
        ],
      ),
    ]));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    final List<String> suggestions = [
      loc.of(Tr.clothes),
    ];

    final List<String> filteredSuggestions = suggestions
        .where((suggestion) =>
            suggestion.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        final String suggestion = filteredSuggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            showResults(context);
          },
        );
      },
    );
  }
}
