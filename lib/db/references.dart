import 'dart:ffi';

import 'package:ato/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
class Fire{
  static  FirebaseApp? _app;
  static  FirebaseAuth? _auth;
  static  FirebaseFirestore? _db;
  static FirebaseStorage? _storage;
  static CollectionReference? _userRef;
  static Reference? _userImageRef;
  static FirebaseApp get app => _app!;

  static init() async{
   _app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
     _auth = FirebaseAuth.instanceFor(app: app);
     _db = FirebaseFirestore.instanceFor(app: app);
     _storage = FirebaseStorage.instanceFor(app: app);
     _initDBReferences();
     _initStorageReferences();
  }

  static void _initDBReferences() {
    _userRef = db.collection("users");
  }
  static void _initStorageReferences() {
    _userImageRef = storage.ref().child("users");
  }

  static FirebaseAuth get auth => _auth!;

  static FirebaseFirestore get db => _db!;

  static FirebaseStorage get storage => _storage!;

  static CollectionReference get userRef => _userRef!;

  static Reference get userImageRef => _userImageRef!;
}
