import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:ushop_app/providers/cart.dart';
// import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
// import 'dart:convert';
import 'cart.dart';
//import 'package:ushop_app/providers/product_model.dart';
class OrderItem
{
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({ 
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
   });
}
class Orders with ChangeNotifier{
 
 
  List<OrderItem> _orders = [];
  String? userID ;
  Orders(this.userID,this._orders);
  List<OrderItem> get orders {
    return [..._orders];
  }
  Future<void> fetchAndSetOrders(List<OrderItem> loadedorder) async {
  
    try
    {
        WidgetsBinding.instance!.addPostFrameCallback((_){
         _orders = loadedorder;
         notifyListeners();
        });
    }
    catch(e)
    {
      // print(e);
    }
  }
  Future<void> addOrder(List<CartItem> cartProducts,double total) async
  {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final String orderuid = const Uuid().v4().substring(0,7);
    final timestamp = DateTime.now();
    try
    { 
     await FirebaseFirestore.instance.collection('Orders')
             .doc(orderuid)
             .set({
                  'id'   : orderuid,
                 'amount': total,
               'dateTime': timestamp.toIso8601String(),
              'CreatorID': _auth.currentUser!.uid,
               'products': cartProducts.map((cp) =>
               {
                 'id'    : cp.id,
               'title'   : cp.title,
               'quantity': cp.quantity,
               'price'   : cp.price,
               }).toList(),
     });
     _orders.insert(0,
     OrderItem(
       id: DateTime.now().toString(),
       amount: total,
       dateTime: DateTime.now(),
       products: cartProducts,
     ));
      notifyListeners();
    }
    catch(e)
    {
      //print(e);
    }
  }
}