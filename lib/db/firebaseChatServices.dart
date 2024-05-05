import 'package:ato/db/consts.dart';
import 'package:ato/db/references.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../models/cloth_item.dart';
import '../models/item.dart';

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
    var query = FirebaseFirestore.instance
        .collection("users")
        .where(Filter.or(
          Filter("role", isEqualTo: "Donor"),
          Filter("role", isEqualTo: "Beneficiary"),
        ))
        .snapshots();

    // Stream<QuerySnapshot> list1 = FirebaseFirestore.instance
    //     .collection("users")
    //     .where("role", isEqualTo: "Donor" )
    //     .snapshots();
    //
    // Stream<QuerySnapshot> list2 = FirebaseFirestore.instance
    //     .collection("users")
    //     .where("role", isEqualTo: "Beneficiary" )
    //     .snapshots();
    return query;
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

  Future<QuerySnapshot> getArticlesDetails()  {
    return  FirebaseFirestore.instance
        .collection("articles")
        .limit(1)
        .get();
  }
  updateArticleIsView(String articleId, bool isDonorView, bool isBeneficiaryView) {
    return FirebaseFirestore.instance
        .collection("articles")
        .doc(articleId)
        .update({'isBeneficiaryView': isBeneficiaryView,
      'isDonorView': isDonorView});
  }

    List<ItemModel> getUserDonatedItems(String UserId)  {
      List<ItemModel> items = List.empty(growable: true);
      Fire.itemRef
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {


        Map<String, dynamic> dataMap= doc.data() as Map<String, dynamic>;
        print(dataMap);
        if(dataMap["donorId"]==UserId){
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
          } else {
            items.add(item);
          }
        }


      }
    });

      return items;

  }


}
