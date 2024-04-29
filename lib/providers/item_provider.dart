import 'dart:io';

import 'package:ato/db/consts.dart';
import 'package:ato/db/references.dart';
import 'package:ato/models/cloth_item.dart';
import 'package:ato/models/item.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class ItemProvider extends ChangeNotifier {

  List<ItemModel> items = List.empty(growable: true);
  String error="";
  int status = -1;
  bool loading= false;
  ItemProvider() {
    Fire.itemRef
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        Map<String, dynamic> dataMap= doc.data() as Map<String, dynamic>;
        print(dataMap);
       ItemModel item;
        if(dataMap["category"]==toyCat ||dataMap["category"]==bookCat) {
          item = ItemModel.fromJson(dataMap);
        }
        else{
          item = ClothModel.fromJson(dataMap);
        }
        if (items.contains(item)) {
          int index = items.indexOf(item);
          items[index] = item;
          // print(item.toString());
          notifyListeners();
        } else {
          items.add(item);
          notifyListeners();
        }
      }
    });
  }

  Future<String?> uploadImage(String itemId, File imageFile) async {
    try{
      Reference ref= Fire.itemImageRef.child(itemId);
      final uploadTask = ref.putFile(imageFile);
      final storageSnap = await uploadTask.whenComplete(() => null);
      final downloadUrl = await storageSnap.ref.getDownloadURL();
      return downloadUrl;
    }
    catch(err){
      status = 0;
      error = err.toString();
      loading= false;
      notifyListeners();
      return null;
    }
  }

  Future<void> upload(ItemModel item, File image) async {
    status = -1;
    error= "";
    loading = true;
    String? imageUrl= await uploadImage(item.id!, image);
    if(imageUrl != null){
      item.image= imageUrl;
      try{
        await Fire.itemRef.doc(item.id).set(item.toMap());
        loading= false;
        status = 1;
        notifyListeners();
      }
      catch(err){
        error= err.toString();
        status = 0;
        loading= false;
        notifyListeners();
      }

    }
  }

  Future<void> update(ItemModel item) async {
    error= "";
    status = -1;
    loading = true;
      try{
        await Fire.itemRef.doc(item.id).set(item);
        loading= false;
        notifyListeners();
      }
      catch(err){
        error= err.toString();
        loading= false;
        notifyListeners();
      }

    }
}
