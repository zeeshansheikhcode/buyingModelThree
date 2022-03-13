import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Auth with ChangeNotifier
{
  final storage = const FlutterSecureStorage();
  String? Email;
  String? value;
  String? _userId;
  String? get userId 
  { 
   return _userId = value;
  }
 final  FirebaseAuth _auth = FirebaseAuth.instance;
 final  GoogleSignIn googleSignIn = GoogleSignIn();
 final  FirebaseFirestore  firestore = FirebaseFirestore.instance;
 Future<void> signInWithGoogle() async
{
  try{
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken
     );
  final userCredential  = await _auth.signInWithCredential(credential);
  final User? user = userCredential.user;
  print(user);
  assert(!user!.isAnonymous);
  assert(await user!.getIdToken() != null);
  final User? currentUser =  _auth.currentUser;
  assert(currentUser!.uid == user!.uid);
   if(user!=null)
        {user.updateProfile(displayName: user.displayName);
          await firestore.collection('users').doc(_auth.currentUser!.uid).set(
            {
                           'username' :    user.displayName,
                           'password' :    'null',
                           'email'    :    user.email,
                           'phone_no' :    user.phoneNumber,
                           'photoUrl' :    user.photoURL,
                           'status'   :    "Unavalible",
                            'uid'     :    _auth.currentUser!.uid,
            });
            await storage.write(key: "userId", value: _auth.currentUser!.uid);
            value = await storage.read(key: "userId");
      print(user);
        }
   notifyListeners();
  }
  catch(e)
  {
     print(e);
  }
}
   Future<void> createAccount(String name,String email,String password,String phoneNo) async
{    
       
    try
     {  
        User? user  = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
        if(user!=null)
        {
          user.updateProfile(displayName: name,);

          await firestore.collection('users').doc(_auth.currentUser!.uid).set(
            {
                          'username' :    name,
                           'password':    password,
                           'email'   :    email,
                           'phone_no':    phoneNo,
                          'photoUrl' :    'null',
                           'status'  :    "offline",
                            'uid'    :    _auth.currentUser!.uid,
            });
            notifyListeners();
             // return user;
        }
        else
        {
          print('Account creation Failed');
          //return user;
        }
       

     }
     catch(e)
     {
        print(e);
        return null;

     }
}

Future<void> logIn(String email,String password) async
{  
  
   try
   {  
     
     User? user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user; 
     if(user!=null)
     { 
       await 
       firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .get()
      .then((value) => user.updateProfile(displayName: value['username'],));
       Email = _auth.currentUser!.email;
       //print('Email: $Email');
       await storage.write(key: "userId", value: user.uid);
       value = await storage.read(key: "userId");
      //  await storage.write(key: "emailby", value: email);
      //  Email = await storage.read(key: "userId");
       notifyListeners();
     }
     else
     {
       //print('Login Failed');
     }
   }
   catch(e)
   {
    // print(e);
     return null;
   }
 }
   Future logOut (BuildContext context) async
  {
    FirebaseAuth auth = FirebaseAuth.instance;
   try
   { 
    // _userId = null;
     await auth.signOut();
     await storage.delete(key: "userId");
     notifyListeners();
    
   }
   catch(e) 
   {
    // print(e);
   }
  }
}

