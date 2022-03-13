import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
class Product with ChangeNotifier
{
   String id;
   String title;
   double price;
   double quantity;
   String description;
   String productImage;
   String category; 
   
   String CreatorID;
  Product(
    {
     required this.id,
     required this.title,
     required this.price,
     required this.quantity,
     required this.description, 
     required this.productImage,
     required this.category,
     required this.CreatorID,
     
    });
    
}
