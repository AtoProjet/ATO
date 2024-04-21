
import 'package:ato/db/references.dart';
import 'package:ato/models/item.dart';
import 'package:ato/models/locale.dart';
import 'package:ato/models/user.dart';
import 'package:flutter/cupertino.dart';




class CartProvider extends ChangeNotifier {
   List<ItemModel> items= List.empty(growable: true);

    CartProvider (){
      items.clear();
   }
void addToCart(ItemModel item){
    items.add(item);
    notifyListeners();
  }

   void removeFromCart(ItemModel item){
     items.remove(item);
     notifyListeners();
   }

   void clear(){
     items.clear();
     notifyListeners();
   }

}

