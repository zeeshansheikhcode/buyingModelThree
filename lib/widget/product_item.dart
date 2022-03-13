// import 'package:buying/model_provider/products_model.dart';
// import 'package:buying/screens/detail_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// // import 'package:provider/provider.dart';
// // import 'package:ushop_app/providers/auth.dart';
// // import 'package:ushop_app/providers/cart.dart';
// // import '../providers/product_model.dart';
// // import 'package:ushop_app/screens/productdetail_screen.dart';
//  class ProductItem extends StatelessWidget {
//   //  final String id;
//   //  final String title;
//   //  final String imageUrl;
//   //  const ProductItem({ Key? key,required this.id,required this.title,required this.imageUrl }) : super(key: key);
//   //final List<Map<String,dynamic>>? prodVal;

//   //const ProductItem({Key? key, this.prodVal}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//      //final product = Provider.of<Product>(context,listen:false);
//     // final cart = Provider.of<Cart>(context,listen: false);
//     // final authData = Provider.of<Auth>(context,listen: false);
//     return ClipRRect(
//       borderRadius:  BorderRadius.circular(15),
//       child: GridTile(
//         child:  GestureDetector(     
//           onTap: (){
//             Navigator.of(context).
//             pushNamed(
//             DetailScreen.routeName ,
//              arguments:  product.id);
//           },
//           child: Hero(
//             tag: product.id,
//             child: FadeInImage(
//               placeholder: AssetImage('assets/images/product-placeholder.png'),
//               image: NetworkImage(product.productImage),
//               fit:BoxFit.cover,
//               ),
//             ),
//           ),
//        footer: GridTileBar(
//         backgroundColor: Colors.black87,
//         title: Text(
//         product.title,
//         textAlign: TextAlign.justify,
//         ),
//         trailing: IconButton
//         (
//          onPressed: (){  
//      
//            Scaffold.of(context).hideCurrentSnackBar();
//            Scaffold.of(context).showSnackBar(
//              SnackBar(content: const Text('Added Item to Cart'),
//              duration: const Duration(seconds: 2),
//              action: SnackBarAction(label: 'UNDO', 
//              onPressed: (){
//                 }),
//              )
//            );
//          },
//          color: Theme.of(context).accentColor,
//          icon:const Icon(Icons.shopping_cart,size: 20,)),
//        ),
//       ),
//     );
//   }
//  }