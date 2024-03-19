import 'package:ato/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Refs{
  bool _ready= false;
  late final CollectionReference userRef;
  late final Reference userImageRef;
  static final Refs _ref= Refs();

  void _initDBReferences() {
    final FirebaseFirestore db = FirebaseFirestore.instanceFor(app: app);
    userRef = db.collection("users");
  }

  void _initStorageReferences() {
    final FirebaseStorage storage = FirebaseStorage.instanceFor(app: app);
    userImageRef = storage.ref().child("users");
  }
  static Refs instance(){
    if(_ref._ready){
      return _ref;
    }
    _ref._initDBReferences();
    _ref._initStorageReferences();
    _ref._ready= true;
    return _ref;
  }
}
