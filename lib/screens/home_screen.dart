
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modelthree/features/chatsearch.dart';
import 'package:modelthree/screens/sellproduct_screen.dart';
import 'package:provider/provider.dart';
import '../model_provider/cart.dart';
import '../widget/badge.dart';
import '../widget/drawer_screen.dart';
import '../widget/widget_app.dart';
import 'cart_screen.dart';

import 'map_product.dart';
import 'menu_home_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    int page =0;
    List pageoptions = 
   const [
      MenuHomeScreen(),
      SellProduct(),
      MapProduct(),
      ChatSearch(),
      
    ];
   TextStyle myStyle(double size,[Color? color,FontWeight fw = FontWeight.w700])
  {
    return GoogleFonts.montserrat(
     fontSize: size,
     fontWeight:  fw,
     color: color,
   );
  }

  @override
  Widget build(BuildContext context) {
     
   return Scaffold(
     appBar:  CustomAppbar(context),
     drawer: const DrawerScreen(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: myStyle(14,Colors.blue),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: myStyle(14,Colors.black),
        currentIndex: page,
        onTap: (index){
          setState(() {
            page = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: 
       const  
       [
            BottomNavigationBarItem(
            label: 'Home'
             ,
            icon: Icon(Icons.home,size: 24,)
            ),
            BottomNavigationBarItem(
             label: 'Sell'
             ,
            icon: Icon(Icons.shopping_bag,size: 24,)
            ),
            BottomNavigationBarItem(
            label: 'Rider'
             ,
            icon: Icon(Icons.electric_bike,size: 24,)
            ),
             BottomNavigationBarItem(
            label: 'Chat'
             ,
            icon: Icon(Icons.chat,size: 24,)
            ),
        ]),
       body: pageoptions[page],

    );
  }
 
}
