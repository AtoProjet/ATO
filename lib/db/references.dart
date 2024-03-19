import 'package:ato/db/references.dart';
import 'package:ato/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
class Fire{
  static FirebaseApp? app;
  static FirebaseAuth? auth;
  static FirebaseFirestore? db;
  bool _ready= false;
  late final CollectionReference userRef;
  late final Reference userImageRef;
  static final Fire _ref= Fire();

  void _initDBReferences() {
    db = FirebaseFirestore.instanceFor(app: app!);
    userRef = db!.collection("users");
  }

  void _initStorageReferences() {
    final FirebaseStorage storage = FirebaseStorage.instanceFor(app: app );
    userImageRef = storage.ref().child("users");
  }
  static Fire instance(){
    if(_ref._ready){
      return _ref;
    }
    _ref._initDBReferences();
    _ref._initStorageReferences();
    _ref._ready= true;
    return _ref;
  }
}
