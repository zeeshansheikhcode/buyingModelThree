import 'package:flutter/material.dart';
class Rider extends StatefulWidget {
  const Rider({ Key? key }) : super(key: key);

  @override
  _RiderState createState() => _RiderState();
}

class _RiderState extends State<Rider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Rider',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22, 
         ),
        ),
        centerTitle: true,
      ),
    );
  }
}