
import 'package:flutter/material.dart';

import '../widget/bottom_container.dart';
import '../widget/drawer_screen.dart';
class AidScreen extends StatefulWidget {

  const AidScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AidScreen> createState() => _AidScreenState();
}

class _AidScreenState extends State<AidScreen> {
 final appbar =  AppBar(
        title:const Text('Buy It',
         style: TextStyle(
           fontSize: 26,
           fontWeight: FontWeight.bold,
           ),
         ),
         centerTitle: true,
         actions: 
         const [
           CircleAvatar(
          backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),

         ],   
      );
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraint)
    {
      return Scaffold(
      backgroundColor : Colors.white,
       appBar:appbar,
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
                      bottomContainerGarments(context : context, image:'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg' , name:"Red Shirt",   price: "1000PKR"),
                      bottomContainerGarments(context : context, image:'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg' , name:"Trousers",price: "1200PKR"),
                      bottomContainerGarments(context : context, image:'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg' , name:"Yellow Scarf",price: "1500PKR"),
                      bottomContainerGarments(context : context, image:'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg' , name:"A Pan'" ,price: "500PKR"),
                      bottomContainerGarments(context : context, image:'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg' , name:"Red Shirt",   price: "1000PKR"),
                      bottomContainerGarments(context : context, image:'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg' , name:"Trousers",price: "1200PKR"),
                      bottomContainerGarments(context : context, image:'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg' , name:"Yellow Scarf",price: "1500PKR"),
                      bottomContainerGarments(context : context, image:'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg' , name:"A Pan'" ,price: "500PKR"),
                      bottomContainerGarments(context : context, image:'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg' , name:"Red Shirt",   price: "1000PKR"),
                      bottomContainerGarments(context : context, image:'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg' , name:"Trousers",price: "1200PKR"),
                      bottomContainerGarments(context : context, image:'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg' , name:"Yellow Scarf",price: "1500PKR"),
                      bottomContainerGarments(context : context, image:'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg' , name:"A Pan'" ,price: "500PKR"),
                 
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
    return InkWell(
      onTap: (){
        // Navigator.push(context,MaterialPageRoute(builder: (_)=> FoodDetailScreen(
        //    imageUrl: image!,
        //        title: name!,
        //        price: price!,
        // )));
      },
      child: Container(
             height:   200, 
                          // (
                          //   MediaQuery.of(context).size.height -
                          //   appbar.preferredSize.height -
                          //   MediaQuery.of(context).padding.top ) * 0.1,
            width:  270,
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.rectangle,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  height: 200,
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
                   style:const TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  trailing: Text(price!,
                  style:const  TextStyle(fontSize:15,color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const  EdgeInsets.only(left: 10),
                  child: 
                  Row(
                    children:const [
                      Icon(Icons.star,color: Colors.white,size: 20,),
                      Icon(Icons.star,color: Colors.white,size: 20,),
                      Icon(Icons.star,color: Colors.white,size: 20,),
                      Icon(Icons.star,color: Colors.white,size: 20,),
                      Icon(Icons.star,color: Colors.white,size: 20,),
                    ],)
                ),
              ],),
      ),
    );
  }
}