import 'dart:ffi';
import 'dart:io';

import 'package:ato/db/consts.dart';
import 'package:ato/db/references.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

import '../components/tools.dart';
import '../models/cloth_item.dart';
import '../models/item.dart';
import '../models/user.dart';

class FirebaseChatServices {
  createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();
    if (snapshot.exists) {
      print("The snapshot already exists");
      return true;
    } else {
      print("The snapshot does not exists, creating new");
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future addMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfomap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfomap);
  }



  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatroomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatroomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String userId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: userId)
        .get();
  }

  Future<Stream<QuerySnapshot>> getChatLists(String userId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("time", descending: true)
        .where("users", arrayContains: userId)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getUserAccounts() async {
    var query = await FirebaseFirestore.instance
        .collection("users")
        .where(Filter.or(
          Filter("role", isEqualTo: "Donor"),
          Filter("role", isEqualTo: "Beneficiary"),
        ))
        .snapshots();
    return query;
  }

  Future<List<Map<String, dynamic>>> getUserAccountsSN() async {
    List<Map<String, dynamic>> myList = [];
    await FirebaseFirestore.instance
        .collection("users")
        .where(Filter.or(
          Filter("role", isEqualTo: "Donor"),
          Filter("role", isEqualTo: "Beneficiary"),
        ))
        .get()
        .then((querySnapshot) {
      myList = processQuerySnapshot(querySnapshot);
    }).catchError((error) {
      print("Error getting documents: $error");
    });
    return myList;
  }

  List<Map<String, dynamic>> processQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Map<String, dynamic>> newDataList = [];

    for (var doc in snapshot.docs) {
      Map<String, dynamic> newData = Map.from(doc.data());
      newData['isChecked'] = false;

      newDataList.add(newData);
    }
    return newDataList;
  }

  disableUserAccount(String userId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update({'isActive': false});
  }

  enableUserAccount(String userId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update({'isActive': true});
  }

  Future<QuerySnapshot> getArticlesDetails(String articleId) {
    return FirebaseFirestore.instance.collection("articles").where("id", isEqualTo: articleId).get();
  }

  updateArticleIsView(
      String articleId, bool isDonorView, bool isBeneficiaryView) {
    return FirebaseFirestore.instance
        .collection("articles")
        .doc(articleId)
        .update({
      'isBeneficiaryView': isBeneficiaryView,
      'isDonorView': isDonorView
    });
  }

  Future<List<ItemModel>> getUserDonatedItems(String UserId) async {
    List<ItemModel> items = List.empty(growable: true);
    Fire.itemRef.snapshots().listen((event) {
      for (var doc in event.docs) {
        Map<String, dynamic> dataMap = doc.data() as Map<String, dynamic>;

        if (dataMap["donorId"] == UserId) {
          ItemModel item;
          if (dataMap["category"] == toyCat || dataMap["category"] == bookCat) {
            item = ItemModel.fromJson(dataMap);
          } else {
            item = ClothModel.fromJson(dataMap);
          }
          if (items.contains(item)) {
            int index = items.indexOf(item);
            items[index] = item;
          } else {
            items.add(item);
          }
        }
      }
    });

    return items;
  }

  Future addNotification(String notId, Map<String, dynamic> notificationDetailsMap) async {
    return FirebaseFirestore.instance
        .collection("userNotifications")
        .doc(notId)
        .set(notificationDetailsMap);

  }


  Future<Stream<QuerySnapshot>> getUserNotifications(String userId) async {
    return FirebaseFirestore.instance
        .collection("userNotifications")
        .orderBy("time", descending: true)
        .where("receiverID", isEqualTo: userId)

        .snapshots();
    //return query;
  }

  updateUserNotification(
      String notificationId) {
    return FirebaseFirestore.instance
        .collection("userNotifications")
        .doc(notificationId)
        .update({'isSeen': true});
  }

  Future<int> getNotificationCounts() async {
    UserModel user = UserModel.user!;
    print ("the user id is " + user.id);
    var query = await FirebaseFirestore.instance
        .collection("userNotifications")
        .where(Filter.and(
      Filter("receiverID", isEqualTo: user.id),
      Filter("isSeen", isEqualTo: false),
    ))
        .get();
    return query.size;
  }

  Future<Stream<QuerySnapshot>> getArticlesList() async {
    var query = await FirebaseFirestore.instance
        .collection("articles"  )
        .where(Filter.and(
      Filter("isActive", isEqualTo: true),
      Filter("isDeleted", isEqualTo: false),
    ))
        .snapshots();
    return query;
  }

  Future<String?> uploadImage(String itemId, File imageFile) async {
      Reference ref= Fire.articleImageRef.child(itemId);
      final uploadTask = ref.putFile(imageFile);
      final storageSnap = await uploadTask.whenComplete(() => null);
      final downloadUrl = await storageSnap.ref.getDownloadURL();
      return downloadUrl;
  }

  Future<bool> addArticle( String articleTitle, String articleContent, File image, bool isBeneficiaryView, bool isDonorView) async {
    bool isSuccess = false;
    String id = randomAlphanumeric(10);
    String? imageUrl= await uploadImage(id, image);

    if(imageUrl!.isNotEmpty){
      Map<String, dynamic> articleInfoMap = {
        "id" : id,
        "title": articleTitle,
        "content": articleContent,
        "createdOn": FieldValue.serverTimestamp(),
        "img": imageUrl,
        "isActive": true,
        "isDonorView": isDonorView,
        "isBeneficiaryView": isBeneficiaryView,
        "isDeleted": false
      };


      await FirebaseFirestore.instance
          .collection("articles")
          .doc(id)
          .set(articleInfoMap);

      isSuccess = true;

    }
    return isSuccess;

  }

  Future<Stream<QuerySnapshot>> getUserArticlesList() async {
    UserModel user = UserModel.user!;
    var query;
    if(user.role == "Beneficiary"){
      query = await FirebaseFirestore.instance
          .collection("articles"  )
          .where(Filter.and(
        Filter("isActive", isEqualTo: true),
        Filter("isDeleted", isEqualTo: false),
        Filter("isBeneficiaryView", isEqualTo: true),
      ))
          .snapshots();
    }
    else if (user.role == "Donor"){
      query = await FirebaseFirestore.instance
          .collection("articles"  )
          .where(Filter.and(
        Filter("isActive", isEqualTo: true),
        Filter("isDeleted", isEqualTo: false),
        Filter("isDonorView", isEqualTo: true),
      ))
          .snapshots();
    }


    return query;
  }


  Future<List<Map<String, dynamic>>> getItemCategories() async{

    List<Map<String, dynamic>> myList = [];
    await FirebaseFirestore.instance
        .collection("itemCategories")
        .get()
        .then((querySnapshot) {
      myList = processQuerySnapshot(querySnapshot);
    }).catchError((error) {
      print("Error getting documents: $error");
    });
    return myList;
  }
  updateItemCat(
      String catId, bool isView) {
    print("is view is " + isView.toString());
    return FirebaseFirestore.instance
        .collection("itemCategories")
        .doc(catId)
        .update({'isView': isView});
  }
  Stream<QuerySnapshot> getItemCatStream() {
    var query = FirebaseFirestore.instance
        .collection("itemCategories" ).snapshots();
    return query;
  }

  deleteItem(String itemId) {
    //print("is view is " + isView.toString());
    return FirebaseFirestore.instance
        .collection("items")
        .doc(itemId)
        .delete();
  }

  deleteArticle(String articleId) {
    //print("is view is " + isView.toString());
    return FirebaseFirestore.instance
        .collection("articles")
        .doc(articleId)
        .delete();
  }


  // removeItem(String ItemId) {
  //
  //
  //   FirebaseFirestore.instance
  //       .collection("orders")
  //       .where("pickedItems", arrayContains: ItemId)
  //       .snapshots();
  //
  //
  //    FirebaseFirestore.instance
  //       .collection("items")
  //       .doc(notificationId)
  //       .update({'isSeen': true});
  // }



  // Future<void> getArrayCount(String documentId) async {
  //   try {
  //     // Reference to the Firestore collection and document
  //     DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore.instance.collection("orders") .where("pickedItems", arrayContains: ItemId)
  //           .get();
  //
  //     // Fetch the document
  //     DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();
  //
  //     // Check if the document exists
  //     if (docSnapshot.exists) {
  //       // Get the data from the document
  //       Map<String, dynamic>? data = docSnapshot.data();
  //
  //       if (data != null && data.containsKey('your_array_field')) {
  //         List<dynamic> arrayField = data['your_array_field'] as List<dynamic>;
  //         int arrayCount = arrayField.length;
  //         print('Array count: $arrayCount');
  //       } else {
  //         print('Array field not found or is null');
  //       }
  //     } else {
  //       print('Document does not exist');
  //     }
  //   } catch (e) {
  //     print('Error getting document: $e');
  //   }
  // }





}


