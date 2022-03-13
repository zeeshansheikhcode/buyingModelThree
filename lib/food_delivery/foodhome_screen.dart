import 'package:flutter/material.dart';
import 'package:modelthree/food_delivery/pizza.dart';
import 'package:modelthree/food_delivery/shawarma.dart';
import 'package:modelthree/widget/search.dart';
import '../widget/bottom_container.dart';
import '../widget/drawer_screen.dart';
import '../widget/widget_app.dart';
import 'burger.dart';
import 'foodaid_screen.dart';
class FoodHomeScreen extends StatefulWidget {
  const FoodHomeScreen({ Key? key }) : super(key: key);

  @override
  State<FoodHomeScreen> createState() => _FoodHomeScreenState();
}

class _FoodHomeScreenState extends State<FoodHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraint)
    {
      return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CustomAppbar(context),
       drawer: const DrawerScreen(),
       body: SingleChildScrollView(
         child: Column(
           children: <Widget>
           [
            Card(
              margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.01,
                horizontal: constraint.minWidth*0.02
              ),
              color: Colors.white,
              elevation: 4,
              child: Column(
                children: <Widget>
                [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>
                    [ 
                     // SizedBox(width: constraint.maxWidth*0.05),
                      Card(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_)=> const ShawarmaScreen()));
                          },
                          child: Container(
                            margin:  EdgeInsets.symmetric(
                              horizontal: constraint.maxWidth*0.03 ,
                              vertical:   constraint.maxHeight*0.02 ,   
                              ),
                            padding: EdgeInsets.symmetric(
                              vertical:   constraint.maxHeight*0.015,
                              horizontal: constraint.minWidth*0.05,
                            ),
                               height:  constraint.maxHeight * 0.08,
                                width:  constraint.maxWidth*0.4,
                            child:const Text('Shawarma',
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                               ),
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
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_)=> const BurgerScreen()));
                          },
                           child: Container(
                            margin:  EdgeInsets.symmetric(
                              horizontal: constraint.maxWidth*0.025 ,
                              vertical: constraint.maxHeight*0.02 ,   
                              ),
                             padding: EdgeInsets.symmetric(
                              vertical:  constraint.maxHeight*0.015,
                              horizontal: constraint.minWidth*0.05,
                            ),
                           height: constraint.maxHeight * 0.08,
                            width: constraint.maxWidth*0.4,
                            child:const Text('Burger',
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                               ),
                            ),
                            decoration:const BoxDecoration(
                            color: Colors.white,
                            ),
                           ),
                         ),
                       ),
                    ],
                   ),
                   Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>
                    [  //const SizedBox(width: 20,),
                      Card(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_)=> const PizzaScreen()));
                          },
                          child: Container(
                            margin:  EdgeInsets.symmetric(
                              horizontal: constraint.maxWidth*0.033 ,
                              vertical:   constraint.maxHeight*0.02 ,   
                              ),
                            padding: EdgeInsets.symmetric(
                              vertical:  constraint.maxHeight*0.015,
                              horizontal: constraint.minWidth*0.05,
                            ),
                            height:
                               constraint.maxHeight * 0.08,
                                width: constraint.maxWidth*0.4,
                            child:const Text('Pizza',
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                               ),
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
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_)=> const FoodAidScreen()));
                          },
                           child: Container(
                            margin:  EdgeInsets.symmetric(
                              horizontal: constraint.maxWidth*0.022 ,
                              vertical: constraint.maxHeight*0.02 ,   
                              ),
                            padding: EdgeInsets.symmetric(
                              vertical:  constraint.maxHeight*0.015,
                              horizontal: constraint.minWidth*0.045,
                            ),
                            height:constraint.maxHeight * 0.08,
                                width: constraint.maxWidth*0.4,
                            child:const Text('Sandwich',
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                               ),
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
             SizedBox(height: constraint.maxHeight*0.01,),
                  GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: constraint.maxWidth*0.01,
                  mainAxisSpacing:  constraint.maxHeight*0.03,
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  childAspectRatio: constraint.maxHeight*0.0008,
                  children: [
                      bottomContainer(context : context, image:'assets/images/1.png' , name:"All",   price: "1000"),
                      bottomContainer(context : context, image:'assets/images/2.png' , name:"Burger",price: "1200"),
                      bottomContainer(context : context, image:'assets/images/3.png' , name:"Recipe",price: "1300"),
                      bottomContainer(context : context, image:'assets/images/4.png' , name:"Pizza" ,price: "1100"),
                      bottomContainer(context : context, image:'assets/images/5.png' , name:"Drink" ,price: "1245"),
                      bottomContainer(context : context, image:'assets/images/6.png' , name:"Pizza" ,price: "1232"),
                      bottomContainer(context : context, image:'assets/images/7.png' , name:"Drink" ,price: "1245"),
                      bottomContainer(context : context, image:'assets/images/8.png' , name:"Pizza" ,price: "1254"),
                      bottomContainer(context : context, image:'assets/images/9.png' , name:"Drink" ,price: "1233"),
                  ],
                  ),

           ],

         ),
       ),
    );
    });
    
  }
}