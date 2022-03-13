// import 'package:chat_app/Authenticate/Methods.dart';
//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_room.dart';
class ChatSearch extends StatefulWidget {
  const ChatSearch({ Key? key }) : super(key: key);

  @override
  _ChatSearchState createState() => _ChatSearchState();
}

class _ChatSearchState extends State<ChatSearch> with WidgetsBindingObserver{
     Map<String,dynamic>? usermap;        
    bool isLoading = false;
    final TextEditingController _search = TextEditingController();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
     @override
     void  initState()
     { super.initState();
       WidgetsBinding.instance!.addObserver(this);
       setStatus("Online");
     }
     void setStatus(String status) async
     { 
       await _firestore.collection('users').doc(_auth.currentUser!.uid).update({ "status" : status});
     }
     @override
     void didChangeAppLifecycleState(AppLifecycleState state)
     {
       if(state==AppLifecycleState.resumed)
       {
          setStatus("Online");
       }
       else
       {
         setStatus("Offline");
       }
     }
   
  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else 
    {
      return "$user2$user1";
    }
  }

     void onSearch() async
     {
       FirebaseFirestore _firestore = FirebaseFirestore.instance;
       setState(() {
         isLoading = true;
       });
       await  _firestore
         .collection('users')
         .where("email",isEqualTo: _search.text)
         .get()
         .then((value)
          {
            setState(() {
              usermap = value.docs[0].data();
              isLoading=false;
            });
           print(usermap);
          });
     }
    //String name = _auth.currentUser!.displayName!;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
     appBar: AppBar(
       centerTitle: true,
       title: const  Text('Search Seller Or Buyer by Email',
       style: TextStyle(fontSize: 16),),
      //  actions: [
      //   //  IconButton(onPressed: () {
      //   //     logOut(context); }, 
      //   //     icon: Icon(Icons.logout))
      //  ],
     ),
     body: isLoading ?
        const Center(
            child:  CircularProgressIndicator(),
          )
        :
        SingleChildScrollView(
          child:  Column(
             children: 
             [
               SizedBox(height: size.height/20,),
               Container(
                 height: size.height/14,
                 width: size.width,
                 alignment: Alignment.center,
                 child: Container(
                   height: size.height/14,
                   width: size.width/1.14,
                   child: TextField(
                     controller: _search,
                     decoration: InputDecoration(
                       hintText: "Search",
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                     ),
                   ),
                 ),
               ),
               SizedBox(height: size.height/50,),
               ElevatedButton(onPressed: onSearch, child:const Text('Search')),
               SizedBox(height: size.height/30,),
                // ignore: unnecessary_null_comparison
                usermap != null
                 ?
                 ListTile(
                   onTap: ()
                   {
                     String roomId = chatRoomId(
                                  _auth.currentUser!.displayName!, usermap!['username']);

                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                      ChatRoom(  chatRoomId : roomId,
                                 userMap  : usermap!,
                                 ) ,
                        ));
                        
                   },
                   leading:const Icon(Icons.account_box, color: Colors.black,
                   ),
                   title: Text(
                     usermap!['username'],
                     style: const TextStyle(
                       color: Colors.black,
                       fontSize: 17,
                       fontWeight: FontWeight.w700,
                     ),
                   ),
                   subtitle: Text(usermap!['email']),
                   trailing:const Icon(Icons.chat,color: Colors.black,),
                 )
                 :
                 Container()
                  
             ],
          ),
        ),

      
    );
  }
}
/*
import 'package:chat_app/Authenticate/Methods.dart';
import 'package:chat_app/Screens/ChatRoom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late Map<String, dynamic> userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => logOut(context))
        ],
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                Container(
                  height: size.height / 14,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height / 14,
                    width: size.width / 1.15,
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                ElevatedButton(
                  onPressed: onSearch,
                  child: Text("Search"),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                userMap != null
                    ? ListTile(
                        onTap: () {
                          String roomId = chatRoomId(
                              _auth.currentUser!.displayName! , userMap['name']);

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ChatRoom(
                                chatRoomId: roomId,
                                usermap: userMap,
                              ),
                            ),
                          );
                        },
                        leading: Icon(Icons.account_box, color: Colors.black),
                        title: Text(
                          userMap['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(userMap['email']),
                        trailing: Icon(Icons.chat, color: Colors.black),
                      )
                    : Container(),
              ],
            ),
    );
  }
}
*/