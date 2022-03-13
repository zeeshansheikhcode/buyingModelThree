import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../model_provider/cart.dart';
import '../model_provider/products.dart';
import '../model_provider/products_model.dart';
import '../screens/detail_screen.dart';
import '../screens/trending.dart';

class ProductsGrid extends StatelessWidget {
   String value;
   ProductsGrid({
    Key? key,required this.value
  }) : super(key: key);
      FirebaseAuth auth = FirebaseAuth.instance;     
  @override
  Widget build(BuildContext context) {
     final productdata = Provider.of<Products>(context,listen: false);
    final cart = Provider.of<Cart>(context,listen: false);
             
         return StreamBuilder<QuerySnapshot>(
         stream: FirebaseFirestore.instance.collection("Products")
        .where('CreatorID' , isEqualTo: value,)
        .snapshots(),
         builder: (context, snapshot) {
          if(!snapshot.hasData)
          {
            return  const Center(child: CircularProgressIndicator());
          } 
          final  products = snapshot.data!.docs;  
          List<Product> loadedProducts =[]; 
          final List<Product> actualProducts =[];
          for(int index = 0 ;index<products.length;index++)
          {
            loadedProducts.add(
                    Product(
                      id:            products[index]['id'],
                      title:         products[index]['title'],
                      description:   products[index]['description'],
                      price:         products[index]['price'],
                      quantity:      products[index]['quantity'],
                      productImage:  products[index]['productImage'],
                      category:      products[index]['category'],
                      CreatorID:     products[index]['CreatorID'],
                       
                      )
                      );
                      if(products[index]['category'] !='360 Product')
                   {
                      actualProducts.add(
                      Product(
                      id:            products[index]['id'],
                      title:         products[index]['title'],
                      description:   products[index]['description'],
                      price:         products[index]['price'],
                      quantity:      products[index]['quantity'],
                      productImage:  products[index]['productImage'],
                      category:      products[index]['category'],
                      CreatorID:     products[index]['CreatorID'],
                      
                          )
                        );
                   }
                         
          } 
         productdata.fetchAndSetProducts(loadedProducts);          
          return GridView.builder(
            padding: const EdgeInsets.all(10),
             shrinkWrap: true,
             physics:const NeverScrollableScrollPhysics(),
             gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              mainAxisExtent: 175,
              crossAxisSpacing: 10,
               ),
             itemCount:actualProducts.length,
             itemBuilder: (context,index)
             {       
                 return  Container(
                 margin: const EdgeInsets.symmetric(vertical: 5),
                 child: ClipRRect(
                 borderRadius: BorderRadius.circular(15),
                 child: GridTile(
                 child:  GestureDetector(     
                 onTap: (){
              Navigator.of(context).
              pushNamed(
              DetailScreen.routeName ,
                 arguments: actualProducts[index].id);
            },
            child: Hero(
              tag: actualProducts[index].id,
              child: FadeInImage(
                  placeholder:const AssetImage('assets/images/product-placeholder.png'),
                  image: NetworkImage(actualProducts[index].productImage),
                  fit:BoxFit.cover,
                  ),
              ),
            ),
         footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
         actualProducts[index].title,
          textAlign: TextAlign.justify,
          ),
          trailing: IconButton
          (
           onPressed: (){  
             cart.addItem(
                  actualProducts[index].id, 
                  actualProducts[index].price,
                  actualProducts[index].title
                  );      
             Scaffold.of(context).hideCurrentSnackBar();
             Scaffold.of(context).showSnackBar(
                 SnackBar(content: const Text('Added Item to Cart'),
                 duration: const Duration(seconds: 2),
                 action: SnackBarAction(label: 'UNDO', 
                 onPressed: (){
                    }),
                 )
             );
           },
           color: Theme.of(context).accentColor,
           icon:const Icon(Icons.shopping_cart,size: 20,)),
                  ),
                 ),
              ),
               );
             }       
           );
        });
       
      }    
      
  } 

