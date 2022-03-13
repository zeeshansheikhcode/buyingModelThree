import 'package:flutter/material.dart';
import 'package:modelthree/screens/order_screen.dart';
import 'package:modelthree/widget/search.dart';
import 'package:provider/provider.dart';

import '../model_provider/cart.dart';
import '../screens/cart_screen.dart';
import 'badge.dart';
PreferredSize CustomAppbar(BuildContext context){
  return  PreferredSize(
    preferredSize:const Size.fromHeight(60),
    child: AppBar(
         title: const Text('Welcome',
         style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
          ),
         ),
         centerTitle: true,
          actions: 
           [  
              Consumer<Cart>
              (
                builder:(_,cart,ch)=>BBadge(
                color: Theme.of(_).accentColor,
                child: ch! ,
                value: cart.itemCount.toString(),
                 ),
                child: IconButton(onPressed: (){
                Navigator.of(context).pushNamed(CartScreen.routeName);
                }, 
                icon: const Icon(Icons.shopping_cart)),  
                ),
                // CircleAvatar(
                //  backgroundImage: NetworkImage(url), 
                // )
                    IconButton(onPressed: ()
                   {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SearchPage()));
               
                   },
                   icon: const Icon(Icons.search,size: 25,)
                   ),
           ], 
       ),
  );
}