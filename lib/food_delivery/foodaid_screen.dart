import 'package:flutter/material.dart';
import '../widget/drawer_screen.dart';
import 'fooddetaitscreen.dart';
class FoodAidScreen extends StatefulWidget {
  const FoodAidScreen({ Key? key }) : super(key: key);

  @override
  _FoodAidScreenState createState() => _FoodAidScreenState();
}

class _FoodAidScreenState extends State<FoodAidScreen> {
   @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraint)
    {
      return Scaffold(
      backgroundColor : Colors.white,
     //  appBar:appbar,
      drawer: const DrawerScreen(),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: 
            [
                SizedBox(height: constraint.maxHeight*0.01,),
                    GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: constraint.maxWidth*0.01,
                    mainAxisSpacing:  constraint.maxHeight*0.03,
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    childAspectRatio:  constraint.maxHeight*0.0008,
                    children: [
                      bottomContainer( image:'assets/images/1.png' , name:"All",   price: "1000"),
                      bottomContainer( image:'assets/images/2.png' , name:"Burger",price: "1200"),
                      bottomContainer( image:'assets/images/3.png' , name:"Recipe",price: "1300"),
                      bottomContainer( image:'assets/images/4.png' , name:"Pizza" ,price: "1100"),
                      bottomContainer( image:'assets/images/5.png' , name:"Drink" ,price: "1245"),
                      bottomContainer( image:'assets/images/6.png' , name:"Pizza" ,price: "1232"),
                      bottomContainer( image:'assets/images/7.png' , name:"Drink" ,price: "1245"),
                      bottomContainer( image:'assets/images/8.png' , name:"Pizza" ,price: "1254"),
                      bottomContainer( image:'assets/images/9.png' , name:"Drink" ,price: "1233"),
                   ],
                    ),
            ],
          ),
        ),
      
    );
 
    });
     }
   Widget bottomContainer({String? image, String? name , String? price})
  {
    return LayoutBuilder(
      builder: (context,constriant){
      return InkWell(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (_)=> FoodDetailScreen(
             imageUrl: image!,
                 title: name!,
                 price: price!,
          )));
        },
        child: Card(
          elevation: 4,
          child: Container(
                 height: constriant.maxHeight*0.25,
                width:  constriant.maxWidth*0.4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                ),
              //  margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      height: constriant.maxHeight*0.6,
                       width: double.infinity,
                      decoration: const  BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Image(image: AssetImage(image!),
                      fit: BoxFit.cover,
                      ),
                      
                      ),
                    ListTile(
                      leading: Text(name!,
                       style:const TextStyle(fontSize: 20,color: Colors.black),
                      ),
                      trailing: Text(price!,
                      style:const  TextStyle(fontSize:15,color: Colors.black),
                      ),
                    ),
                     Padding(
                    padding:   EdgeInsets.only(
                      left: constriant.maxWidth*0.05),
                      child: 
                      Row(
                        children:const [
                          Icon(Icons.star,color: Colors.black,size: 20,),
                          Icon(Icons.star,color: Colors.black,size: 20,),
                          Icon(Icons.star,color: Colors.black,size: 20,),
                          Icon(Icons.star,color: Colors.black,size: 20,),
                          Icon(Icons.star,color: Colors.black,size: 20,),
                        ],)
                    ),
                  ],),
          ),
        ),
      );
      }
    );
  }
}