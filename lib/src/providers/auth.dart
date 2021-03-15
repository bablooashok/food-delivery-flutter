import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/src/helpers/user.dart';
import 'package:flutter_food_delivery/src/models/user.dart';

enum Status{Uninitialized, Unauthenticated, Authenticating, Authenticated}

class AuthProvider with ChangeNotifier{
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Firestore _firestore = Firestore.instance;
  UserServices _userServices = UserServices();
  UserModel _userModel;

  Status get status => _status;
  FirebaseUser get user => _user;
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthProvider.initialize(): _auth = FirebaseAuth.instance{
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future <bool> signUp() async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((result) {
        _firestore.collection('users').document(result.user.uid).setData({
          "name": name.text,
          "email": email.text,
          "id": result.user.uid
        });
      });
      return true;
    }catch(e){
      return _onError(e.toString());
    }
  }

  Future<bool> signIn() async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email:email.text.trim(), password: password.text.trim());
      return true;
    }catch(e){
      return _onError(e.toString());
    }
  }
  
  Future<void> signOut(){
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(FirebaseUser firebaseUser) async{
    if(user == null){
      _status = Status.Uninitialized;
    }
    else{
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(firebaseUser.uid);
    }
    notifyListeners();
  }

  bool _onError(String error){
    _status = Status.Unauthenticated;
    notifyListeners();
    print("We got an error: $error");
    return false;
  }

  void cleanControllers(){
    email.text = "";
    password.text ="";
    name.text = "";
  }
}