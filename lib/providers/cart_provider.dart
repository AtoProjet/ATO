import 'package:ato/models/item.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  Map<ItemModel, int> items = {};

  CartProvider() {
    print("in CartProvider");
    items.clear();
  }

  void addToCart(ItemModel item) {
    if (items.keys.contains(item)) {
      items.update(item, (value) => value + 1);
    } else {
      items.putIfAbsent(item, () => 1);
    }
    notifyListeners();
  }

  void removeFromCart(ItemModel item) {
    items.remove(item);
    notifyListeners();
  }

  int count() {
    return items.length;
  }

  void clear() {
    items.clear();
    notifyListeners();
  }

  Map<String, int> get pickedItems {
    Map<String, int> itemMap = items.map((item, quantity) {
      return MapEntry(item.id!, quantity);
    });
    return itemMap;
  }
}
