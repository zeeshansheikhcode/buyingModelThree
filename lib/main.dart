import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modelthree/screens/add_product.dart';
import 'package:modelthree/screens/cart_screen.dart';
import 'package:modelthree/screens/detail_screen.dart';
import 'package:modelthree/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'authenticate/login_screen.dart';
import 'model_provider/auth.dart';
import 'model_provider/cart.dart';
import 'model_provider/order.dart';
import 'model_provider/products.dart';
Future<void> main()  async
{
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> 
{
  final storage = const FlutterSecureStorage();
  
  Future<bool> checkLoginStatus() async
  {
    String? value =await storage.read(key: "userId");
    if(value == null)
     {
       return false;
     }
     return true;
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: 
    [
        ChangeNotifierProvider(
         create:(context)=> Auth(),
          ),
         ChangeNotifierProxyProvider<Auth,Products>
        ( 
          create: (context)=>Products('',[]),
          update: (context,auth,previousprod) =>
              Products(
                auth.userId,
                previousprod == null ? [] :previousprod.items)
        ),
        ChangeNotifierProxyProvider<Auth,Orders>
        ( 
          create: (context)=>Orders('',[]),
          update: (context,auth,previousorder) =>
              Orders(
                auth.userId,
                previousorder == null ? [] :previousorder.orders)
        ),
      ChangeNotifierProvider(
      create: (context)=> Cart(),
      ),
    ],
       child:   MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch:Colors.blue,
            accentColor: Colors.lightBlueAccent,
          ),
          home:  FutureBuilder(
            future: checkLoginStatus(),
            builder: (BuildContext context,AsyncSnapshot<bool> snapshot)
               {
                 if(snapshot.data== false)
                  {
                    return const LoginScreen();
                  }
                  if(snapshot.connectionState == ConnectionState.waiting)
                  {
                    return const SplashScreen();
                  }
                  return const HomeScreen();
               },),
          routes: 
          {
           DetailScreen.routeName: (context)   =>  const DetailScreen(),
           AddProduct.routeName  : (context)   =>  const AddProduct(value: '',creatervalue:'' ),
           CartScreen.routeName  : (context)   =>  const CartScreen(),
          }
      ),     
    );
  }
}


class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Timer(const Duration(seconds: 5), 
    //   () => Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (_)=> const HomeScreen()),
    //   ));
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: 
          const [
             Text('Buying It',
                   style: TextStyle(
                   fontSize: 30,
                   fontWeight: FontWeight.bold,
                   color: Colors.black,
                  ),
                ),
             SizedBox(height: 10,),
             Text('Welcome to your Dream Store',
                    style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10,),
                SpinKitThreeBounce(
                color: Colors.black,
                size: 30.0,
             ),
          ],
        ),
      ), 
    );
  }
}
