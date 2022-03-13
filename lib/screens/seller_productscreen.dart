
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model_provider/products.dart';
import '../widget/drawer_screen.dart';
import '../widget/seller_productitem.dart';
import 'add_product.dart';
class SellerProductScreen extends StatelessWidget {
  const SellerProductScreen({ Key? key }) : super(key: key);
  static const routeName = '/seller_product';
  
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
        actions: <Widget> 
        [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(AddProduct.routeName);
          },
           icon:const Icon(Icons.add)
           ),
        ],
      ),
      drawer: const DrawerScreen(),
      body:
             Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  ListView.builder(
                    itemCount: productData.items.length,
                    itemBuilder: (_,i)=>Column(
                      children:
                      [
                        SellerProductItem(
                           id     : productData.items[i].id,
                         title    : productData.items[i].title,
                      productImage: productData.items[i].productImage,
                        ),
                        const Divider(),
                      ],
                     ),
                    ),
                 ),
          );
      
  }
}