import 'package:flutter/material.dart';
class MapProduct extends StatefulWidget {
  const MapProduct({ Key? key }) : super(key: key);

  @override
  _MapProductState createState() => _MapProductState();
}

class _MapProductState extends State<MapProduct> {
  
  // final appbar =AppBar(
  //       title: const Text('Map of Orders'),
  //       centerTitle: true,
  //     );
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context,constraint){
      return Scaffold(
      // appBar: appbar,
      // drawer: const Drawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: 
        [
          Card
          (
           color: Colors.white,
           margin: EdgeInsets.symmetric(
             vertical: constraint.maxHeight*0.01,
             horizontal: constraint.maxWidth*0.01, 
           ),
          child: Container(
              height: (     MediaQuery.of(context).size.height -
                           // appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top ) * 0.7,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: 
                [
                  SizedBox(height: constraint.maxHeight*0.01,),
                const  Text('Product Delievery Around You',
                       style: TextStyle(
                       fontSize: 22,
                       color: Colors.black,
                       fontWeight: FontWeight.bold
                     ),
                  ),
                  SizedBox(height: constraint.maxHeight*0.01,),
                   Card(  
              margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.005,
                horizontal: constraint.maxWidth*0.02,
              ),    
              color: Colors.white,
              elevation: 4,
              child: InkWell(
                child: Container(
                  margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.01,
                horizontal: constraint.maxHeight*0.01,
                ),
                  padding: const EdgeInsets.symmetric(horizontal:5,vertical: 5),
                  height: constraint.maxHeight * 0.07,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Text('Delievery 1',
                  style:  TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),  
                  SizedBox(height: constraint.maxHeight*0.01,),
                   Card(  
              margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.005,
                horizontal: constraint.maxWidth*0.02,
              ),    
              color: Colors.white,
              elevation: 4,
              child: InkWell(
                child: Container(
                  margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.01,
                horizontal: constraint.maxHeight*0.01,
                ),
                  padding: const EdgeInsets.symmetric(horizontal:5,vertical: 5),
                  height: constraint.maxHeight * 0.07,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Text('Delievery 2',
                  style:  TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),  
                  SizedBox(height: constraint.maxHeight*0.01,),
                   Card(  
              margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.005,
                horizontal: constraint.maxWidth*0.02,
              ),    
              color: Colors.white,
              elevation: 4,
              child: InkWell(
                child: Container(
                  margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.01,
                horizontal: constraint.maxHeight*0.01,
                ),
                  padding: const EdgeInsets.symmetric(horizontal:5,vertical: 5),
                  height: constraint.maxHeight * 0.07,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Text('Delievery 3',
                  style:  TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),  
                  SizedBox(height: constraint.maxHeight*0.01,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
 
      });
     }
}