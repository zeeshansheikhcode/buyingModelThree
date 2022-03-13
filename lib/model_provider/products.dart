import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modelthree/model_provider/products_model.dart';
import 'package:uuid/uuid.dart';
class Products with ChangeNotifier
{
   
   final storage = const FlutterSecureStorage();
   List<Product>? _items = [];
   String? userID ;
   Products(this.userID,this._items);
   List<Product> get items 
   {
    return [..._items!];
   }
   final List<Product>? _trendingItems = 
   [
      Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      quantity: 2,
      price: 29.99,
      category: 'Trending',
      CreatorID: 'p',
      //emailby: 'sheikh@',
      productImage:'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      quantity: 2,
      category: 'Trending',
      CreatorID: 'p',
     // emailby: 'sheikh@',
      productImage:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      quantity: 2,
      category: 'Trending',
      CreatorID: 'p',
     // emailby: 'sheikh@',
      productImage:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      quantity: 2,
    //  emailby: 'sheikh@',
      category: 'Trending',
      CreatorID: 'p',
      productImage:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  
   ];
   List<Product> get trendingItems
   {
     return [..._trendingItems!];
   }
 

  Product findbyId(String id)
  {
    return _items!.firstWhere((prod) => prod.id == id);
  }
  FirebaseAuth auth = FirebaseAuth.instance;     
 
      String? value;
      Future<bool> checkUserId() async
     {
         value = auth.currentUser!.uid;
         if(value == null)
          {
            return false;
          }
          return true;
      }
  void fetchAndSetProducts(List<Product> loadedProducts) 
  {   
       try
       {
         
         WidgetsBinding.instance!.addPostFrameCallback((_){
        _items = loadedProducts;
        notifyListeners();
       });
       
       }
       catch(error)
       {
        // print(error);
       }
  }
  // Future<List<Product>> fetchAndSetProducts() async {  
  //    print('here11');
  //            List<Product> loadedProducts =[]; 
  //            List<Product> actualProducts =[];
  //           // List<Product> trendingProducts =[];
  //           FirebaseAuth auth = FirebaseAuth.instance;
  //     try
  //      { print('here14');
  //       //  FutureBuilder(
  //       //  future: checkUserId(),
  //       //  builder: (context,AsyncSnapshot<bool> snapshot)
  //       //  {  print('here22');
  //       //          if(snapshot.data==false)
  //       //           {
  //       //             return const Center(child: CircularProgressIndicator());
  //       //           }         
  //         StreamBuilder<QuerySnapshot>(
  //         stream: FirebaseFirestore.instance.collection("Products")
  //        .where('CreatorID' , isEqualTo: 'Q5xFtrh5SGgNIYymL1RW27idQRl1',)
  //        .snapshots(),
  //         builder: (context, snapshot)
  //        { print('here33');
  //           if(!snapshot.hasData)
  //          {
  //            return  const TrendingProducts();
  //          } 
  //            final  products = snapshot.data!.docs;  
  //             products.forEach((element) 
  //             { 
  //                loadedProducts.add(
  //                     Product(
  //                     id:            element['id'],
  //                     title:         element['title'],
  //                     description:   element['description'],
  //                     price:         element['price'],
  //                     quantity:      element['quantity'],
  //                     productImage:  element['productImage'],
  //                     category:      element['category'],
  //                     CreatorID:     element['CreatorID']
  //                     )
  //                     );

  //             });   
  //         //    for(int index = 0 ;index<products.length;index++)
  //         // {
  //         //    loadedProducts.add(
  //         //             Product(
  //         //             id:            products[index]['id'],
  //         //             title:         products[index]['title'],
  //         //             description:   products[index]['description'],
  //         //             price:         products[index]['price'],
  //         //             quantity:      products[index]['quantity'],
  //         //             productImage:  products[index]['productImage'],
  //         //             category:      products[index]['category'],
  //         //             CreatorID:     products[index]['CreatorID']
  //         //             )
  //         //             );
  //         //             if(products[index]['category'] !='360 Product')
  //         //          {
  //         //             actualProducts.add(
  //         //             Product(
  //         //             id:            products[index]['id'],
  //         //             title:         products[index]['title'],
  //         //             description:   products[index]['description'],
  //         //             price:         products[index]['price'],
  //         //             quantity:      products[index]['quantity'],
  //         //             productImage:  products[index]['productImage'],
  //         //             category:      products[index]['category'],
  //         //             CreatorID:     products[index]['CreatorID']
  //         //                 )
  //         //               );
  //         //          }
  //         //      }
  //              print('last here');
  //             _items = loadedProducts; 
  //             notifyListeners();
  //              return loadedProducts as Widget;
  //            });
  //      }
  //      catch(error)
  //      {
  //        print(error);
  //      }
  //     return loadedProducts;
  //}
  Future<void> addproducts(Product product) async
  {   final String productuid = const Uuid().v4().substring(0,7);
    try
    { 

         await FirebaseFirestore.instance.collection('Products')
             .doc(productuid)
             .set({
                'id'          : productuid,
                'title'       : product.title,
                'price'       : product.price,
                'quantity'    : product.quantity,
                'description' : product.description,
                'productImage': product.productImage,
                'CreatorID'   : product.CreatorID,
                'category'    : product.category,
             //   'emailby'     : product.emailby,
               });
     
      
     
     final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      productImage: product.productImage,
      quantity: product.quantity,
      id: productuid,
      category: product.category,
      CreatorID: product.CreatorID,
    //  emailby: product.emailby,
    );
    _items!.add(newProduct);
    notifyListeners();
    }
     catch(error)
     {
      //print(error);
      throw error;
     }
  }
  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items!.indexWhere((prod) => prod.id == id);
    if (prodIndex != null)
    {  
       
          FirebaseFirestore.instance.collection('Products')
           .doc(id)
           .update({
             'id'            : newProduct.id,
             'title'         : newProduct.title,
             'price'         : newProduct.price,
             'quantity'      : newProduct.quantity,
             'description'   : newProduct.description,
             'productImage'  : newProduct.productImage,
             'CreatorID'     : newProduct.CreatorID,
             'category'      : newProduct.category,
           //  'emailby'       : newProduct.emailby,
           });
       
      _items![prodIndex] = newProduct;
      notifyListeners();
    } else {
     // print('...');
    }
  }
  Future<void> deleteProduct(String id) async
   {
        await  FirebaseFirestore.instance.collection('Products')
        .doc(id)
        .delete();
      final existingProductIndex = _items!.indexWhere((prod) => prod.id ==id);
      var   existingProduct = _items![existingProductIndex];
            _items!.removeAt(existingProductIndex); 
            notifyListeners();     
  }
}