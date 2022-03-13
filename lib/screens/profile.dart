import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
   ProfileScreen({ Key? key }) : super(key: key);

  
 final FirebaseAuth _auth = FirebaseAuth.instance; 
 static String? _userphoto;
 static String? _username;
 static String? _useremail;
 String? get  username
   {
      return _username;
   }
   String? get  useremail
   {
      return _useremail;
   }
   String? get  userurl
   {
      return _userphoto;
   }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints)
    {
      return Scaffold(
      body:  
      StreamBuilder<DocumentSnapshot>(
         stream: FirebaseFirestore.instance.collection("users")
         .doc(_auth.currentUser!.uid)
        .snapshots(),
         builder: (context, snapshot) 
         { 
          if(!snapshot.hasData)
          {
             return const Center(child: Text('No Profile'));       
          }
               var userinfo  =   snapshot.data!;
                 _userphoto  =   userinfo['photoUrl'];
                 _username   =   userinfo['username'];
                 _useremail  =   userinfo['email'];
            return Column(
            mainAxisAlignment:  MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
            [
               SizedBox(height: constraints.maxHeight*0.05),
                  Container(
                     height: constraints.maxHeight*0.5,
                     width: double.infinity,
                     decoration: const BoxDecoration(
                       color: Colors.white,
                     ),
                     child:  Image(
                       image: NetworkImage(_userphoto!),
                       fit: BoxFit.cover,
                       ),
                     ),
                  Card(  
                  margin: const EdgeInsets.all(10),
                  color: Colors.white,
                  elevation: 4,
                  child: Column(
                    children:<Widget>
                    [
                      Container(
                      margin: const EdgeInsets.all(10),
                      height: constraints.maxHeight*0.06,
                      width: double.infinity,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: 
                         [  
                          const Text('Name: ',
                           style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 22,
                           color: Colors.black,
                            ),
                           ),
                         const  SizedBox(width: 50,),
                           Text(username!,
                           style: const TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 18,
                           color: Colors.black,
                            ),
                           ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: constraints.maxHeight*0.06,
                      width: double.infinity,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: 
                        [  
                         const  Text('Email:',
                           style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 22,
                           color: Colors.black,
                            ),
                           ),
                           const SizedBox(width: 10,),
                           Text(_useremail!,
                           style: const TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 18,
                           color: Colors.black,
                            ),
                           ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: constraints.maxHeight*0.06,
                      width: double.infinity,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: 
                        [  
                         const  Text('Phone No.:',
                           style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 22,
                           color: Colors.black,
                            ),
                           ),
                           const SizedBox(width: 10,),
                           Text(userinfo['phone_no'],
                           style: const TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 18,
                           color: Colors.black,
                            ),
                           ),
                        ],
                      ),
                    ),
                    ] 
                  ),
                ), 
                            
            ],
          );
        }
      ),
    );
    });
   
  }
}