import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../features/chat_room.dart';
class DetailChat extends StatefulWidget {
  final String sellername;
  const DetailChat({ Key? key,required this.sellername }) : super(key: key);

  @override
  State<DetailChat> createState() => _DetailChatState();
}

class _DetailChatState extends State<DetailChat> with WidgetsBindingObserver{
     Map<String,dynamic>? usermap;        
    bool isLoading = false;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
     @override
     void  initState()
     { super.initState();
       WidgetsBinding.instance!.addObserver(this);
       setStatus("Online");
       onSearch();
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
         .where("email",isEqualTo: widget.sellername)
         .get()
         .then((value)
          {
            setState(() {
              usermap = value.docs[0].data();
              isLoading=false;
            });
          // print(usermap);
          });
     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Creating Chat'),
        ),
        body: isLoading 
          ?
          const CircularProgressIndicator()
          :
          usermap != null
                 ?
                 ListTile(
                   onTap: ()
                   {
                     String roomId = chatRoomId(
                                  _auth.currentUser!.displayName!,usermap!['username']);
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

      
    );
  }
}