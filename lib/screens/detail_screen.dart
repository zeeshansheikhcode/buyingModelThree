
import 'package:flutter/material.dart';
import 'package:modelthree/screens/detail_chat.dart';
import 'package:provider/provider.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../features/chatsearch.dart';
import '../features/video_conference.dart';
import '../model_provider/auth.dart';
import '../model_provider/products.dart';
class DetailScreen extends StatefulWidget {
  
  const DetailScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = '/product_detail';

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  
  @override
  Widget build(BuildContext context) {
   // final authprovider =  Provider.of<Auth>(context,listen: false);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedproduct = Provider.of<Products>(context,listen :false).findbyId(productId);

    return LayoutBuilder(builder: (context,constraint)
    {
      return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(loadedproduct.title,
            style:const TextStyle(
              fontWeight: FontWeight.bold,) ,),
        ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: 
          [   SizedBox(height: constraint.maxHeight*0.03,),
              Container(
                 height:(
                            MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top ) * 0.5,
                 width: double.infinity,
                 decoration: const BoxDecoration(
                   color: Colors.white,
                 ),
                 child: Hero(
                  tag: loadedproduct.id,
                  child: Image.network(
                    loadedproduct.productImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
           Card(  
              margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.005,
                horizontal: constraint.maxWidth*0.02,
              ),
              color: Colors.white,
              elevation: 4,
              child: Column(
                children:<Widget>
                [
                  Container(
                  margin:  EdgeInsets.symmetric(
                    horizontal: constraint.maxWidth*0.02,
                    vertical: constraint.maxHeight*0.01),
                  height: constraint.maxHeight * 0.07,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                     [  
                     const  Text(' Price: ',
                       style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 18,
                       color: Colors.black,
                        ),
                       ),
                      SizedBox(width:  constraint.maxWidth*0.2,),
                       Text(loadedproduct.price.toString(),
                       style:const TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 15,
                       color: Colors.black,
                        ),
                       ),
                    ],
                  ),
                ),
                
                Container(
                  margin:  EdgeInsets.symmetric(
                    vertical: constraint.maxHeight*0.01,
                    horizontal: constraint.maxWidth*0.02,
                  ),
                  height: constraint.maxHeight * 0.07,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                    [  
                      const Text(' Description:',
                       style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 18,
                       color: Colors.black,
                        ),
                       ),
                     const SizedBox(width: 10,),
                       Text(loadedproduct.description,
                       style:const TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 15,
                       color: Colors.black,
                        ),
                       ),
                    ],
                  ),
                ),     
                ] 
              ),
            ),
             if(loadedproduct.category == 'Home Applaince')
             Card(  
              margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.005,
                horizontal: constraint.maxWidth*0.02,
              ),    
              color: Colors.white,
              elevation: 4,
              child: InkWell(
                child: Container(
                  margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.01,
                horizontal: constraint.maxHeight*0.01,
                ),
                  padding: const EdgeInsets.symmetric(horizontal:5,vertical: 5),
                  height: constraint.maxHeight * 0.09,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child:const Text('AUGMENTED REALITY ONLY FOR HOME APPLIANCE',
                  style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ), 
             Card(  
              margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.005,
                horizontal: constraint.maxWidth*0.02,
              ),    
              color: Colors.white,
              elevation: 4,
              child: InkWell(
                child: Container(
                  margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.01,
                horizontal: constraint.maxHeight*0.01,
                ),
                  padding: const EdgeInsets.symmetric(horizontal:5,vertical: 5),
                  height: constraint.maxHeight * 0.05,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text('Uploaded By:'+ loadedproduct.seller,
                  style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),   
            SizedBox(height: constraint.maxHeight*0.01,),
             Card(  
             margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.0001,
                horizontal: constraint.maxWidth*0.02,
              ),
              color: Colors.white,
              elevation: 4,
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: constraint.maxHeight*0.01,
                    horizontal: constraint.maxHeight*0.01,
                  ),
                   height: constraint.maxHeight * 0.07,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                     [  
                      Card(
                        child: InkWell(
                          onTap:()
                           {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> const VideoConference()));
                         },
                          child: Container(
                            padding:  EdgeInsets.symmetric(
                               horizontal:constraint.maxWidth*0.04,
                               vertical: constraint.maxHeight*0.01,
                               ),
                                height: constraint.maxHeight * 0.07,
                              width: constraint.maxWidth*0.4,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: const Text('Video Call',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),) ,
                          ),
                        ),
                      ),
                      // const SizedBox(width: 50,),
                     Card(
                       child: InkWell(
                         onTap: ()
                         {
                           Navigator.push(context, MaterialPageRoute(builder: 
                           (context)=>  DetailChat(sellername: loadedproduct.seller,)));
                         },
                          child: Container(
                           //  margin: const EdgeInsets.symmetric( horizontal:10),
                              padding:  EdgeInsets.symmetric(
                               horizontal:constraint.maxWidth*0.06,
                               vertical: constraint.maxHeight*0.01,
                               ),
                              height: constraint.maxHeight * 0.07,
                              width: constraint.maxWidth*0.4,
                              decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: const Text('Chat',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                          ),
                        ),
                     ),
                    ],
                  ),
                ),
              ),
            ),
           ],
        ),
      ),
     // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed:(){},
        child:const Icon(Icons.shopping_cart),
      ),     
    );
 
    });
     }
}