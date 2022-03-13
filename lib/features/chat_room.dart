//simport 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
class ChatRoom extends StatelessWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, required this.userMap});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
   File? imagefile;
  Future getImage() async
  {
    ImagePicker picker = ImagePicker();

     await picker.pickImage(source: ImageSource.gallery).then((xfile) 
     {
       if(xfile!=null)
       {
         imagefile =File(xfile.path);
         uploadimage();
       }
     });
  }
  Future uploadimage() async
  {
    String filename = Uuid().v1();
    int status =1;
    await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats').doc(filename).set({
        "sendby": _auth.currentUser!.displayName,
        "message": "",
        "type" : "img",
        "time": FieldValue.serverTimestamp(),

          });

    var ref =FirebaseStorage.instance.ref().child('images').child("$filename.jpg");
    var uploadTask =  await ref.putFile(imagefile!).catchError((error) async
    { 
        await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(filename)
          .delete();
          status = 0;
    });
     if(status==1)
     {
       String  ImageUrl =  await uploadTask.ref.getDownloadURL();
        await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(filename).update({
            "message" : ImageUrl
          });
        print(ImageUrl);
     }
  
  
  }
  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser!.displayName,
        "message": _message.text,
        "type" : "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream:
              _firestore.collection("users").doc(userMap['uid']).snapshots(), 
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Container(
                child: Column(
                  children: [
                    Text(userMap['username']),
                    Text(
                      snapshot.data!['status'],
                      style:const TextStyle(fontSize: 14,color: Colors.white),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chatroom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
               
             builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
                 {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic>? map =
                            snapshot.data!.docs[index].data() as Map<String, dynamic>?;
                        return messages(size, map!,context);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height / 17,
                      width: size.width / 1.3,
                      child: TextField(
                        controller: _message,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: ()=>getImage(), icon: Icon(Icons.photo)),
                            hintText: "Send Message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.send), onPressed: onSendMessage),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map,BuildContext context) {
    return map['type'] == 'text' 
    ? 
    Container(
      width: size.width,
      alignment: map['sendby'] == _auth.currentUser!.displayName
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        child: Text(
          map['message'],
          style:const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    )
     :
     Container(
       height:  size.height/2.5,
       width: size.width,
       padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
       alignment: map['sendby'] == _auth.currentUser!.displayName 
          ? Alignment.centerRight
          : Alignment.centerLeft,
          child: InkWell(
            onTap: () =>
            
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ShowImage(ImageUrl: map['message']))),
            
            child: Container(
              height: size.height/2.5,
              width: size.width/2,
              decoration: BoxDecoration(border: Border.all()),
              alignment:  map['message'] !=  "" ? null : Alignment.center,
              child: map['message'] != ""
                 ? 
                 Image.network(map['message'],
                 fit: BoxFit.cover,)
                 :
                 CircularProgressIndicator(),
            ),
          ),

     );
  }
}
class ShowImage extends StatelessWidget {
  final String ImageUrl;

  const ShowImage({ required this.ImageUrl ,Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
     
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(ImageUrl),

      ),
      
    );
  }
}
//

