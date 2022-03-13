
import 'package:flutter/material.dart';

import '../food_delivery/fooddetaitscreen.dart';
import '../screens/detail_screen.dart';

 Widget bottomContainer({BuildContext? context,String? image, String? name , String? price})
  { 
    return LayoutBuilder(builder: (context,constriant){
      return InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (_)=> FoodDetailScreen(
           imageUrl: image!,
               title: name!,
               price: price!,
        )));
      },
      child: Card(
        elevation: 4,
        child: Container(
               height: constriant.maxHeight*0.25,
                width:  constriant.maxWidth*0.4,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                     height: constriant.maxHeight*0.6,
                    width: double.infinity,
                    decoration: const  BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image(image: AssetImage(image!))),
                  ListTile(
                    leading: Text(name!,
                     style:const TextStyle(fontSize: 20,color: Colors.black),
                    ),
                    trailing: Text(price!,
                    style:const  TextStyle(fontSize:15,color: Colors.black),
                    ),
                  ),
                  
                  Padding(
                    padding:   EdgeInsets.only(
                      left: constriant.maxWidth*0.05),
                    child: 
                    Row(
                      children:const [
                        Icon(Icons.star,color: Colors.black,size: 20,),
                         Icon(Icons.star,color: Colors.black,size: 20,),
                         Icon(Icons.star,color: Colors.black,size: 20,),
                         Icon(Icons.star,color: Colors.black,size: 20,),
                         Icon(Icons.star,color: Colors.black,size: 20,),
                      ],)
                  ),
                ],),
        ),
      ),
    );
    });
    
  }
   Widget bottomContainerGarments({BuildContext? context,String? image, String? name , String? price})
  {
    return LayoutBuilder(
      builder: (context,constriant){
        return InkWell(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (_)=>const DetailScreen(
                
                    )));
        },
        child: Container(
              height: constriant.maxHeight*0.25,
              width:  constriant.maxWidth*0.4,
              decoration:  BoxDecoration(
                color: Colors.black,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    height: constriant.maxHeight*0.6,
                    width: double.infinity,
                    decoration: const  BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image(image: NetworkImage(image!),fit: BoxFit.cover,)),
                  ListTile(
                    leading: IconButton(icon:const Icon(Icons.favorite,color: Colors.white,),
                    onPressed: (){},),
                    // title: Text(name!,
                    //  style:const TextStyle(fontSize: 15,color: Colors.white),
                    // ),
                    trailing: Text(price!,
                    style:const  TextStyle(fontSize:10,color: Colors.white),
                    ),
                  ),
                  
                  Padding(
                    padding:   EdgeInsets.only(
                      left: constriant.maxWidth*0.02,
                      right: constriant.maxWidth*0.02,
                      top: constriant.maxHeight*0.01,
                      bottom: constriant.maxHeight*0.01,
                      ),
                    child: Text(name!,
                     style:const TextStyle(fontSize: 15,color: Colors.white),
                    ),
                 ),
                ],),
        ),
      );
      },
     
    );
  }