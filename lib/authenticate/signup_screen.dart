import 'package:flutter/material.dart';
import '../model_provider/auth.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _name     = TextEditingController();
  final TextEditingController _email    = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phonenum = TextEditingController();
  bool _isLoading = false;
  final appBar = AppBar(
        title:const Text('Sign Up',
         style: TextStyle(
           fontSize: 26,
           fontWeight: FontWeight.bold,
           ),
         ),
         centerTitle: true,   
      );

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return LayoutBuilder(builder: (context,constraints)
    {
       return Scaffold(
      backgroundColor: Colors.white,
     // appBar: AppBar(),
      appBar: appBar,
      body: _isLoading 
           ?
           const Center(child: CircularProgressIndicator(),)
           :
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height:  (
                            MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top ) * 1.0,
                  width:  double.infinity,
                  margin:  const EdgeInsets.all(10), 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                    [  const SizedBox(height: 10,),
                       TextFormField(
                       controller: _name,
                       decoration: InputDecoration(
                       labelText : 'Name' ,
                       hintText  : 'Enter Name',
                       border    : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                          ),
                       ),
                     ),
                     const SizedBox(height: 5,),
                      TextFormField(
                      controller: _phonenum,
                      decoration: InputDecoration(
                      labelText : 'Phone Number',
                      hintText  : 'Enter Phone Number',
                      border    : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                     TextFormField(
                     controller: _email,
                     decoration: InputDecoration(
                     labelText: 'Email' ,
                     hintText:  'Enter Email',
                     border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                           ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                    TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                    labelText: 'Password' ,
                    hintText:  'Enter Password',   
                    border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                          ),
                        ),
                      ),
                   const SizedBox(height: 10,),
                   SignInButton(
                   Buttons.Google,
                   elevation: 4.0,
                   onPressed:() {
                     setState(() {
                       _isLoading = true;
                          });
                     auth.signInWithGoogle();
                    setState(() {
                       _isLoading = false;
                                });
                 Navigator.push(context,MaterialPageRoute(builder:(context)=>const LoginScreen()));
                  }),
                  // const SizedBox(height: 5,),
                  // SignInButton(
                  //   Buttons.Facebook, 
                  //   elevation: 4.0,
                  //   onPressed:() {
                  //   //signInWithGoogle();
                  // }),
                  const SizedBox(height: 5,),
                  Container(
                  margin: const EdgeInsets.only(bottom:10,left: 10,right: 10),
                  height: constraints.maxHeight*0.07,
                  width: constraints.maxWidth*0.5,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 82, 85, 90),
                  ),
       child: ElevatedButton(
       onPressed: ()  async{
     if(_name.text.isNotEmpty && _phonenum.text.isNotEmpty &&_email.text.isNotEmpty && _password.text.isNotEmpty)
        {    
          setState(() {
             _isLoading = true;
           });
         await  auth.createAccount(_name.text,_email.text,_password.text,_phonenum.text);
              setState(() {
             _isLoading = false;
           });
          Navigator.push(context,MaterialPageRoute(builder:(context)=>const LoginScreen()));     
        }
      },
        child: const Text('Sign Up',
               style: TextStyle(
               fontSize: 22,  
                 ),
               ),
            ),
                ),
                 Container(
                  margin: const EdgeInsets.only(bottom:10,left: 10,right: 10),
                  height: constraints.maxHeight*0.07,
                  width: constraints.maxWidth*0.5,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent,
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push((context), MaterialPageRoute(builder: (context)=> const LoginScreen()));
                    },
                    child: const Text('Cancel',
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
         ),
      );
    });
  }
  
}