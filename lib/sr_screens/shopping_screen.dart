import 'package:ato/components/actions.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets/buttons.dart';
import 'package:ato/components/widgets/global.dart';
import 'package:ato/components/widgets/images.dart';
import 'package:ato/db/consts.dart';
import 'package:ato/models/shoe_item.dart';
import 'package:ato/providers/cart_provider.dart';
import 'package:ato/providers/item_provider.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/models/cloth_item.dart';
import 'package:ato/models/item.dart';
import 'package:ato/sr_screens/item_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingScreen extends StatefulWidget {
  static Tr title = Tr.shopping;

  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  final List<bool> _selectedCategories = List.generate(categories.length, (index) => true);
  final List<bool> _selectedGenders = List.generate(genders.length, (index) => true);
  final List<bool> _selectedUsSizes = List.generate(usSizes.length, (index) => true);
  final List<bool> _selectedUkSizes = List.generate(ukSizes.length, (index) => true);
  bool isClothSelected(){
    return _selectedCategories[categories.indexOf(clothCat)];
  }

  bool isShoeSelected(){
    return _selectedCategories[categories.indexOf(shoesCat)];
  }
  @override
  Widget build(BuildContext context) {
    setAsFullScreen(true);
    LocaleProvider loc = Provider.of(context);
    CartProvider cart = Provider.of(context);
    ItemProvider ipo = Provider.of(context);
    print("The ipo items are");
    print(ipo.items);
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
                  mainAxisSpacing: 10.0,
                  mainAxisExtent: 140,
                ),
                // shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  for (ItemModel item in ipo.items)
                    showItemCard(item, cart, loc),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItemCard(ItemModel item, CartProvider cart, LocaleProvider loc) {
    int catIndex = categories.indexOf(item.category);
    if (!_selectedCategories[catIndex]) {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
    if (item is ClothModel) {
      int genderIndex = genders.indexOf(item.forGender);
      int usSizeIndex = usSizes.indexOf(item.size);
      if (!_selectedGenders[genderIndex]
          || !_selectedUsSizes[usSizeIndex]) {
        return const SizedBox(
          height: 0,
          width: 0,
        );
      }
    }
    if (item is ShoeModel) {
      int genderIndex = genders.indexOf(item.forGender);
      int ukSizeIndex = ukSizes.indexOf(item.size);
      bool ukSizeSelected= ukSizes.length %7<= ukSizeIndex ;
      if (!ukSizeSelected|| !_selectedGenders[genderIndex]) {
        return const SizedBox(
          height: 0,
          width: 0,
        );
      }
    }
    return atoItemCard(context, item, cart, loc);
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
            Text("${loc.of(Tr.forGender)}:"),
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
                  SizedBox(
                    width: screenSize(context).width/3,
                  child:atoCheckBox(
                    context: context,
                    index: i,
                    text: loc.ofStr(categories[i]),
                    val: _selectedCategories[i],
                    onChange: (index, value) {
                      setState(() {
                        _selectedCategories[index] = value;
                      });
                    },
                    ), ),
              ],
            ),
            if(isClothSelected() || isShoeSelected())
            Text("${loc.of(Tr.size)}(US):"),
            if(isClothSelected() || isShoeSelected())
            Wrap(
              direction: Axis.horizontal,
              children: [
                for (int i = 0; i < usSizes.length; i++)
                  SizedBox(
                    width: 80,
                    child: atoCheckBox(
                      context: context,
                      index: i,
                      text: loc.ofStr(usSizes[i]),
                      val: _selectedUsSizes[i],
                      onChange: (index, value) {
                        setState(() {
                          _selectedUsSizes[index] = value;
                        });
                      },
                    ),
                  ),
              ],
            ),
            if(isClothSelected())
            Text("${loc.of(Tr.size)}(UK):"),
            if(isClothSelected())
            Wrap(
              direction: Axis.horizontal,
              children: [
                for (int i = 0; i < ukSizes.length; i+=7)
                  SizedBox(
                    width: 120,
                    child: atoCheckBox(
                      context: context,
                      index: i,
                      text: "${ukSizes[i]} - ${ukSizes.length> i+6? ukSizes[i+6]: ukSizes.length}",
                      val: _selectedUkSizes[i],
                      onChange: (index, value) {
                        setState(() {
                          _selectedUkSizes[index] = value;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

atoItemCard(BuildContext context, ItemModel item, CartProvider cart,
    LocaleProvider loc) {
  String text = item.name;
  return Card(
    color: cardBackgroundColor,
    shape: ShapeBorder.lerp(LinearBorder.none, LinearBorder.none, 0),
    child: Stack(
        children: [
      Container(
        alignment: Alignment.topCenter,
        width: 200,
        child: IconButton(
          onPressed: () {
            goToScreen(context, ItemInfoScreen(item: item));
          },
          icon: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: atoNetworkImage(
                item.image,
                height: 100,
                alignment: Alignment.topCenter,
                fit: BoxFit.fitHeight,
              )),
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(right: loc.isAr()? 24:0, left: loc.isAr()?0: 24),
        child: Text(
          maxLines: 1,
          text,
          style: const TextStyle(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      Container(

          alignment: Alignment.bottomRight,
          child: IconButton(
              padding: const EdgeInsets.all(4),
              alignment: Alignment.bottomRight,
              onPressed: () {
                cart.addToCart(item);
                atoToastSuccess(context, loc.of(Tr.itemAddedSuccessfully));
              },
              icon: atoAssetOfIcon("add-to-cart.png",
                  color: Colors.red, width: 20, height: 20))),
          if (item is ClothModel)
            Container(
              padding: const EdgeInsets.all(4),
              alignment: Alignment.topLeft,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                    color: Color(item.color),
                    border: const Border.fromBorderSide(BorderSide(width: 1, color: Colors.grey)),
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),

        ]
    ),
  );
}

class SearchBarDelegate extends SearchDelegate<ItemModel?> {
  List<ItemModel> items = [];

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
    LocaleProvider loc = Provider.of<LocaleProvider>(context);
    CartProvider cart = Provider.of<CartProvider>(context);
    ItemProvider ipo = Provider.of<ItemProvider>(context);

    List<ItemModel> items = ipo.items.where((item) {
      return item.searchData().contains(query.toLowerCase());
    }).toList();

    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(fontSize: 18.0),
        ),
      );
    } else {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              mainAxisExtent: 135,
            ),

            itemCount: items.length,
            itemBuilder: (context, index) {
              ItemModel item = items[index];
              return atoItemCard(
                  context, item, cart, loc);
            },
          ),
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    final List<String> suggestions = [

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
