import 'package:flutter/material.dart';
import 'package:modelthree/authenticate/signup_screen.dart';
import 'package:provider/provider.dart';
import '../model_provider/auth.dart';
import '../screens/home_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email    = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isLoading = false;
  final appBar = AppBar(
        title:const Text('Login',
         style: TextStyle(
           fontSize: 26,
           fontWeight: FontWeight.bold,
           ),
         ),
         centerTitle: true,
         actions: 
       const  [
          //  FlatButton(onPressed: (){},
          //   child:const Icon(Icons.add,
          //   size: 30,
          //    color: Colors.white,)
          //   ),
         ],   
      );
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return  LayoutBuilder(builder: (context,constraints)
    {
      return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
       appBar:appBar, 
       body: _isLoading 
             ?
             const Center(child:CircularProgressIndicator())
             :
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height:    (
                            MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top ) * 0.9,

                width:  constraints.maxWidth*1.0,
                margin:   EdgeInsets.symmetric(
                  vertical: constraints.maxHeight*0.01,
                  horizontal: constraints.maxWidth*0.01
                ), 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: 
                  [  
                   SizedBox(height: constraints.maxHeight*0.01,),
                   TextFormField(
                   controller: _email,
                   decoration: InputDecoration(
                   labelText: 'Email' ,
                   hintText:  'Enter Email',
                   border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                         ),
                      ),
                    ),
                   SizedBox(height: constraints.maxHeight*0.01,),
                  TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                  labelText: 'Password' ,
                  hintText:  'Enter Password',   
                  border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                        ),
                      ),
                    ),
                 SizedBox(height: constraints.maxHeight*0.01,),
                 Container(
                   margin:  EdgeInsets.only(
                     bottom:constraints.maxHeight*0.01,
                     left: constraints.maxWidth*0.01,
                     right:constraints.maxWidth*0.01,
                     ),
                  height: constraints.maxHeight*0.1,
                  width: constraints.maxWidth*0.55,
                 decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightBlueAccent,
                ),
                child: ElevatedButton(
                  onPressed: () async {
              if(_email.text.isNotEmpty && _password.text.isNotEmpty)
               {
                 setState(() {
                   _isLoading = true;
                 });
                  await auth.logIn(_email.text, _password.text);
                   setState(() {
                   _isLoading = false;
                 });  
                 Navigator.push(context,MaterialPageRoute(builder:(context)=>const HomeScreen()));    
              }
              else
              {
                //print('Please fill form correctly');
              }
           },
                  child: const Text('Login',
                  style: TextStyle(
                     fontSize: 22,  
                     ),
                    ),
                  ),
                ),
                Container(
                  height: constraints.maxHeight*0.1,
                  width: constraints.maxWidth*0.55,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightBlueAccent,
                ),
                 child: ElevatedButton(
                 onPressed:(){
                 Navigator.of(context).push(MaterialPageRoute(
                 builder: (_)=>const SignUpScreen()));
                },
                child: const Text('Create Account',
                style: TextStyle(
                fontSize: 22,  
                     ),
                    ),
                  ),
              ),
            ]
          ),
       ),
            ],
          ),
    );
    });
    
  }
}