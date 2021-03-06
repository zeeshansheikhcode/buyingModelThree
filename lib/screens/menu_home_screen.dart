import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modelthree/model_provider/products.dart';
import 'package:modelthree/screens/cart_screen.dart';
import 'package:modelthree/screens/trending.dart';
import 'package:modelthree/widget/search.dart';
import 'package:provider/provider.dart';
import '../360images/threeDgrid.dart';
import '../CategoryScreens/fashion_screen.dart';
import '../CategoryScreens/hardware_screen.dart';
import '../CategoryScreens/home_appliance.dart';
import '../CategoryScreens/real_estate.dart';
import '../model_provider/products_model.dart';
import '../widget/drawer_screen.dart';
import '../widget/product_grid.dart';
import '../food_delivery/foodhome_screen.dart';
class MenuHomeScreen extends StatefulWidget {
  const MenuHomeScreen({ Key? key }) : super(key: key);
  @override
  State<MenuHomeScreen> createState() => _MenuHomeScreenState();
}

class _MenuHomeScreenState extends State<MenuHomeScreen> {
 
  final storage1 = const FlutterSecureStorage();
  List<Product> trending =[];
  FirebaseAuth auth = FirebaseAuth.instance;
   String? value;
      @override
  void initState() {
    // TODO: implement initState
    super.initState();
     value = auth.currentUser!.uid;
  }
    // var _isLoading = false;
    // var _isInit = true;
  // @override
  // Future<void> didChangeDependencies() async {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   if(_isInit)
  //   {
  //     print('here1');
  //     setState(() {
  //       _isLoading = true;
  //     });
  //   List<Product> pro = await   Provider.of<Products>(context,listen: false).fetchAndSetProducts();
  //   //   then((pro) => 
  //    setState(() {
  //       _isLoading = false;
  //     });
  //    print('here3');      
  //   }
  //   _isInit = false;
  // }

  @override
  Widget build(BuildContext context) {
  final prod = Provider.of<Products>(context);
  trending = prod.items;
    return LayoutBuilder(builder: (context,constriant)
    {
      return Scaffold(
      floatingActionButton: FloatingActionButton(
         onPressed:()
         {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartScreen()));
         },
        child:const Icon(Icons.shopping_cart)
      ),    
      backgroundColor: Colors.white,
  
      drawer: const DrawerScreen(),
      body:   
         SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>
            [
              
              Card(  
                margin:  EdgeInsets.symmetric(
                  vertical: constriant.maxHeight*0.02,
                  horizontal: constriant.maxWidth*0.02,
                ),
                color: Colors.white,
                elevation: 4,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder:(_)=>const FoodHomeScreen() ));
                  },
                  child: Card(
                    child: Container(
                      margin:  EdgeInsets.symmetric(
                        vertical: constriant.maxHeight*0.05,
                        horizontal: constriant.maxWidth*0.07,
                      ),
                      height: (
                                MediaQuery.of(context).size.height -
                              //  appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top ) * 0.07,
                      width: double.infinity,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: 
                         [  
                        const   Text(' Fast Food',
                           style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 30,
                           color: Colors.black,
                           fontStyle: FontStyle.italic
                            ),
                           ),
                          SizedBox(width: constriant.maxWidth*0.2,),
                         const Icon(
                          Icons.restaurant,
                          color: Colors.black,
                          size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                color: Colors.white,
                elevation: 4,
                child: Column(
                  children: <Widget>
                  [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>
                      [
                        Card( 
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_)=>const HomeAppliance()),
                              );
                            },
                            child: Container(
                              margin:  EdgeInsets.symmetric(
                                    vertical: constriant.maxHeight  * 0.01,
                                    horizontal: constriant.maxWidth * 0.005,
                              ),
                              padding:  EdgeInsets.symmetric(
                                        vertical: constriant.maxHeight * 0.01,
                                        horizontal: constriant.maxWidth* 0.003,
                                      ),
                              height:constriant.maxHeight * 0.1,
                                width: constriant.maxWidth*0.53,
                               child:Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:const  [
                                   Text('Home Appliance',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black,
                                     ),
                                  ),
                                  Icon(Icons.tv, color: Colors.black,),
                                ],
                              ),
                              decoration:const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                         Card(
                           child: InkWell(
                             onTap: (){
                             Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_)=>const FashionScreen()),
                              );},
                             child: Container(
                               margin:  EdgeInsets.symmetric(
                                    vertical: constriant.maxHeight  * 0.01,
                                    horizontal: constriant.maxWidth * 0.005,
                              ),
                              padding:  EdgeInsets.symmetric(
                                        vertical: constriant.maxHeight * 0.01,
                                        horizontal: constriant.maxWidth* 0.01,
                                      ),
                             height:constriant.maxHeight * 0.1,
                              width: constriant.maxWidth*0.34,
                              child:Row(
                                children:const [
                                   Text('Fashion',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black,
                                     ),
                                  ),
                                  Icon(Icons.sports_hockey,color: Colors.black,)
                                ],
                              ),
                              decoration:const BoxDecoration(
                               color: Colors.white,
                              ),
                             )
                           ),
                         )
                      ],
                     ),
                     Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>
                      [
                        Card(
                          child: InkWell(
                             onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_)=>const RealEstateScreen()),
                              );},
                            child: Container(
                                             margin:  EdgeInsets.only(
                                    left:   constriant.maxWidth * 0.06,
                                    right:  constriant.maxWidth * 0.01,
                                    top:    constriant.maxHeight  * 0.01,
                                    bottom: constriant.maxHeight  * 0.01,
                              ),
                              padding:  EdgeInsets.symmetric(
                                        vertical: constriant.maxHeight * 0.01,
                                        horizontal: constriant.maxWidth* 0.01,
                                      ),
                              height:constriant.maxHeight * 0.1,
                              width: constriant.maxWidth*0.4,
                              child:Row(
                                children: const [
                                  Text('Real Estate',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black,
                                     ),
                                  ),
                                  Icon(Icons.home,color: Colors.black,)
                                ],
                              ),
                              decoration:const BoxDecoration(
                               color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                         Card(
                           child: InkWell(
                              onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_)=>const Hardware()),
                              );},
                             child: Container(
                                margin:  EdgeInsets.only(
                                    left:   constriant.maxWidth * 0.01,
                                    right:  constriant.maxWidth * 0.01,
                                    top:    constriant.maxHeight  * 0.01,
                                    bottom: constriant.maxHeight  * 0.01,
                              ),
                              padding:  EdgeInsets.symmetric(
                                        vertical: constriant.maxHeight * 0.01,
                                        horizontal: constriant.maxWidth* 0.03,
                                      ),
                               height: constriant.maxHeight * 0.1,
                                width: constriant.maxWidth  * 0.4,
                              child:Row(
                                children:const [
                                   Text('Hardware',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black,
                                     ),
                                  ),
                                  Icon(Icons.hardware,color: Colors.black,)
                                ],
                              ),
                              decoration:const BoxDecoration(
                               color: Colors.white,
                              ),
                             ),
                           ),
                         ),
                      ],
                     ),
                  ],
                ),
              ),
               Card(  
                margin:  EdgeInsets.symmetric(
                  vertical: constriant.maxHeight*0.01,
                  horizontal: constriant.maxWidth*0.02,
                  ),
                color: Colors.white,
                elevation: 4,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder:(_)=>const ThreeDGrid() ));
                  },
                  child: Card(
                    child: Container(
                      margin:  EdgeInsets.symmetric(
                        vertical: constriant.maxHeight*0.02,
                        horizontal: constriant.maxWidth*0.05,
                      ),
                      height: (
                                MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top ) * 0.07,
                      width: double.infinity,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: 
                        const [  
                           Text('  360 View of Products',
                           style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 22,
                           color: Colors.black,
                           fontStyle: FontStyle.italic
                            ),
                           ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
                    SizedBox(height: constriant.maxHeight*0.01),
                 if( storage1.read(key: "userId") != null ) 
                        ProductsGrid(value : value!)      
                    
                      else const Text('No Data')
                    
                    ],
                    ),
             )
      );
               });
     }
}