import 'package:device_info_plus/device_info_plus.dart';
import 'package:exif/exif.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import '../model_provider/products.dart';
import '../model_provider/products_model.dart';
import 'home_screen.dart';
class AddProduct extends StatefulWidget {
  final String value;
  final String creatervalue;
 static const routeName = '/add_product';
  const AddProduct({Key? key,required this.value, required this.creatervalue}) : super(key: key);
  @override 
  State<AddProduct> createState() => _AddProductState();
}
class _AddProductState extends State<AddProduct> {
    static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
   @override
  void initState() {
    super.initState();
    initPlatformState();
  }
   File? _pickedImage;
   String? productId;
   var storageImage;
   bool _isLoading =false;
   var _isInit = true;
   String? imageUrl;
   bool _pickingNormal = true;
   static int count=0;
   final Uuid _uuid =const  Uuid();
   String productname ='';
   String picname ='';
   String foldername = '';        
   final _formkey = GlobalKey<FormState>();
   var _initValues = {
    'id': '',
    'title': '',
    'price': '',
    'quantity': '',
    'description': '',
    'productImage': '',
    'category':'',
    'CreatorID':'',
  };
   var _editedProduct = Product(
    id: '0' ,
    title: '',
    price: 0,
    quantity : 0,
    description: '', 
    productImage: '',
    category: '',
    CreatorID: ''
  );
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_isInit)
    {
       productId = ModalRoute.of(context)!.settings.arguments as dynamic;
       if (productId != null) 
       {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findbyId(productId!);
        _initValues = 
        {
          'id'              : _editedProduct.id,
          'title'           : _editedProduct.title,
          'price'           : _editedProduct.price.toString(),
          'quantity'        : _editedProduct.quantity.toString(),
          'description'     : _editedProduct.description,
          'productImage'    : _editedProduct.productImage,
          'category'        : _editedProduct.category, 
          'CreatorID'       : _editedProduct.CreatorID,
        };
      }
      _isInit=false;
    }
  }
  showAlertDialog(BuildContext context)
{
  Widget okButton = TextButton(
    child:const Text("OK"),
    onPressed: () 
    {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title:const Text("Copyright"),
    content:const Text("This image has a copyright issue"),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};
    try {
      if (kIsWeb) {
       // deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
         // deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        } else if (Platform.isLinux) {
          //deviceData = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
        } else if (Platform.isMacOS) {
          //deviceData = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
        } else if (Platform.isWindows) {
          //deviceData =
            //  _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }
  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
       'brand': build.brand,
       'device': build.device,
       'id': build.id,
       'manufacturer': build.manufacturer,
       'model': build.model,
       'product': build.product,
       'androidId': build.androidId,
   
    };
  }
  void getUrl() async
  {
    // setState(() {
    //   _isLoading = true;
    // });
    // storageImage.putFile(File(_pickedImage!.path));
    //  imageUrl = await storageImage.getDownloadURL();
    //  setState(() {
    //   _isLoading = false;
    // });
  }

  void _pickNormalImage() async {
    final picker = ImagePicker();
    final XFile? pickedImageFile = await picker.pickImage(source: ImageSource.camera,
    imageQuality: 100,
    maxWidth: 150
    );
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });    
    storageImage = FirebaseStorage.instance.ref()
                   .child('UserImages').child(_uuid.v4().substring(0,5) + '.jpg');
  }
  Future getImagefromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedImageFile = await picker.pickImage(source: ImageSource.gallery,
    imageQuality: 100,
    maxWidth: 150
    );
    final fileBytes = File(pickedImageFile!.path).readAsBytesSync();
    final data = await readExifFromBytes(fileBytes);
    if (data.isEmpty) {
      return;
    }
    if(_deviceData['model']==data['Image Model'].toString())
    {
      setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    }
    else{   
     setState((){
      _pickedImage = null;
      showAlertDialog(context);
      });
    } 
  }

    void _saveNormalPhoto() async
      {
        final isValid = _formkey.currentState!.validate();
        if (!isValid) 
                   {
                       return;
                   }
           _formkey.currentState!.save();
           setState(() {
             _isLoading = true;
           });
           if (_editedProduct.id == '0') 
           {
             await storageImage.putFile(File(_pickedImage!.path));
             imageUrl = await storageImage.getDownloadURL();
               _editedProduct = Product(
                      id          : _editedProduct.id,
                      title       : _editedProduct.title,
                      price       : _editedProduct.price,
                      quantity    : _editedProduct.quantity,
                      description : _editedProduct.description,
                      productImage: imageUrl!,
                      CreatorID   : widget.creatervalue,
                      category    : widget.value,
                      );
           } 
          else
            {            
               _editedProduct = Product(
                      id          : _editedProduct.id,
                      title       : _editedProduct.title,
                      price       : _editedProduct.price,
                      quantity    : _editedProduct.quantity,
                      description : _editedProduct.description,
                      productImage: _editedProduct.productImage,
                      CreatorID   : _editedProduct.CreatorID,
                      category    : _editedProduct.category,     
                 ); 
             }   
           setState(() {
             _isLoading = false;
           });          
          if (_editedProduct.id != '0') 
           { 
               Provider.of<Products>(context, listen: false)
              .updateProduct(_editedProduct.id, _editedProduct);
               Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
               return;
            } 
       Provider.of<Products>(context, listen: false)
      .addproducts(_editedProduct);
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
  }
          //  String firstImage ='';
    Future<void> _pickThreeDImage() async
   { if(count<=3)
     {
        final picker = ImagePicker();
        final XFile? pickedImageFile = await picker.pickImage(source: ImageSource.camera,
        imageQuality: 100,
        maxWidth: 150
        );
          if(count==0)
          {
            picname = _uuid.v4().substring(0,5);
            foldername = widget.creatervalue+'_'+picname;
          }
            setState(()
            {
             _pickedImage = File(pickedImageFile!.path);
              count++;
            });
            if(count==1)
            {
               _pickingNormal = false;
              storageImage = FirebaseStorage.instance.ref()
              .child(foldername).child(picname+ '.jpg');
              storageImage.putFile(File(_pickedImage!.path));  
              await storageImage.putFile(File(_pickedImage!.path)); 
            }
            if(count>1 && count<3)
            {
              storageImage = FirebaseStorage.instance.ref()
              .child(foldername).child(_uuid.v4().substring(0,5) + '.jpg');
              await storageImage.putFile(File(_pickedImage!.path)); 
              
            }
            if(count==3)
            {
              storageImage = FirebaseStorage.instance.ref()
              .child(foldername).child(_uuid.v4().substring(0,5) + '.jpg');
             
            }
       
     }
       
  }
      void _saveThreeDPhoto() async
      {
            final isValid = _formkey.currentState!.validate();
              if (!isValid) 
                   {
                    return;
                   }
                   _formkey.currentState!.save();
                   setState(() {
                     _isLoading = true;
                   });
          if(_editedProduct.id == '0')
                {
                  await storageImage.putFile(File(_pickedImage!.path)); 
                  imageUrl = await storageImage.getDownloadURL();
                  _editedProduct = Product(
                      id          : _editedProduct.id,
                      title       : _editedProduct.title,
                      price       : _editedProduct.price,
                      quantity    : _editedProduct.quantity,
                      description : _editedProduct.description,
                      productImage: imageUrl!,
                      CreatorID   : widget.creatervalue,
                      category    : widget.value,
                      );
                }      
                else
                {
                      _editedProduct = Product(
                      id          : _editedProduct.id,
                      title       : _editedProduct.title,
                      price       : _editedProduct.price,
                      quantity    : _editedProduct.quantity,
                      description : _editedProduct.description,
                      productImage: _editedProduct.productImage,
                      CreatorID   : _editedProduct.CreatorID,
                      category    : _editedProduct.category,     
                 );
                } 
                 setState(() {
                     _isLoading = false;
                   });  
          if (_editedProduct.id != '0') 
           { 
             Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
             Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
             return;
           } 
       Provider.of<Products>(context, listen: false)
      .addproducts(_editedProduct);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
           }
 
  @override
  Widget build(BuildContext context) {
   
    return LayoutBuilder(builder: (context,constraints)
    {
      return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        title:  Text(productId!=null ? 'Update' : widget.value,
        style:const TextStyle(fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
        icon:const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(onPressed: _pickingNormal ? _saveNormalPhoto : _saveThreeDPhoto, 
          icon: const Icon(Icons.save))
        ],    
      ),
      body: _isLoading == true
             ?
             const Center(child : CircularProgressIndicator())
             :
          SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>
            [
               SizedBox(height: constraints.maxHeight*0.01,),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                color: Colors.black,
                child: Container(
                  margin:  const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  height:(MediaQuery.of(context).size.height -
                             // appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) * 1.15,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                            SizedBox(height: constraints.maxHeight*0.007,),
                           TextFormField(
                          // controller: folder,
                           initialValue: _initValues['title'],
                           decoration: InputDecoration(
                           labelText : 'Title' ,
                           hintText  : 'In English Ex. Jacket',
                           border    : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                              ),
                           ),
                             validator: (value) {
                                if (value!.isEmpty)
                                 {
                                      return 'Please provide a value.';
                                 }
                                   return null;
                               },
                     onSaved: (value1) {
                       //productname = value1!;
                    _editedProduct = Product(
                        title: value1!,
                        price: _editedProduct.price,
                        description: _editedProduct.description,
                        productImage: _editedProduct.productImage,
                        quantity: _editedProduct.quantity,
                        id: _editedProduct.id,
                        category: _editedProduct.category,
                        CreatorID:  _editedProduct.CreatorID,
                        );
                       // productname = _editedProduct.title;
                  },
        
                         ),
                          SizedBox(height: constraints.maxHeight*0.007,),
                          TextFormField(
                         
                         initialValue: _initValues['price'],
                          decoration: InputDecoration(
                          labelText : 'Price',
                          hintText  : 'In PKR Ex.10000',
                          border    : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                              ),
                            ),
                          validator: (value) {
                            if (value!.isEmpty) {
                             return 'Please enter a price.';
                             }
                             if (double.tryParse(value) == null) {
                             return 'Please enter a valid number.';
                                  }
                             if (double.parse(value) <= 0) {
                             return 'Please enter a number greater than zero.';
                            }
                           return null;
                          },
                           onSaved: (value) {
                       _editedProduct = Product(
                        title: _editedProduct.title,
                        price: double.parse(value!),
                        quantity: _editedProduct.quantity,
                        description: _editedProduct.description,
                        productImage: _editedProduct.productImage,
                        id: _editedProduct.id,
                        category: _editedProduct.category,
                        CreatorID: _editedProduct.CreatorID,
                        );
                      //  isFavourite: _editedProduct.isFavourite);
                  },
                          ),
                          SizedBox(height: constraints.maxHeight*0.007,),
                         TextFormField(
                         initialValue: _initValues['quantity'],
                         decoration : InputDecoration(
                         labelText  : 'Quantity' ,
                         hintText   : 'Number e.g.10,20',
                         border     : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                               ),
                            ),
                             validator: (value) {
                                if (value!.isEmpty)
                                 {
                                      return 'Please provide a value.';
                                 }
                                   return null;
                               },
                         onSaved: (value) {
                       _editedProduct = Product(
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        quantity: double.parse(value!),
                        description: _editedProduct.description,
                        productImage: _editedProduct.productImage,
                        id: _editedProduct.id,
                        category: _editedProduct.category,
                        CreatorID: _editedProduct.CreatorID,
                        );
                      //  isFavourite: _editedProduct.isFavourite);
                  },
                  ),
                         SizedBox(height: constraints.maxHeight*0.007,),
                        TextFormField(
                       // controller  : null,
                        initialValue: _initValues['description'],
                        keyboardType: TextInputType.multiline,  
                        decoration  : InputDecoration(
                        labelText   : 'Description' ,
                        hintText    : 'Max 20 to 25 Words', 
                        border      : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                              ),
                            ),
                   validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description.';
                    }
                    if (value.length < 10) {
                      return 'Should be at least 10 characters long.';
                    }
                    return null;
                  },
                   onSaved: (value) {
                       _editedProduct = Product(
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        quantity: _editedProduct.price,
                        description: value!,
                        productImage: _editedProduct.productImage,
                        id: _editedProduct.id,
                        category: _editedProduct.category,
                        CreatorID:_editedProduct.CreatorID,
                        );
                      //  isFavourite: _editedProduct.isFavourite);
                  },
                ),
                       SizedBox(height: constraints.maxHeight*0.02,),
                       widget.value=='360 Product'
                       ?
                       Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            productId!=null
                               ?
                                 Container(
                                 width:  constraints.maxWidth*0.4,
                                 height: constraints.maxHeight*0.265,
                                 decoration:  BoxDecoration(
                                 color: Colors.white,
                                 border: Border.all(), 
                                   ),
                                child:  Center( 
                                child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.grey,
                                backgroundImage: 
                                NetworkImage(_editedProduct.productImage)
                                       ),
                                     ),
                   
                              )
                              :
                               _pickedImage == null
                                ?
                               Container(
                                 width:  constraints.maxWidth*0.4,
                                 height: constraints.maxHeight*0.35,
                                 decoration:  BoxDecoration(
                                 color: Colors.white,
                                 border: Border.all(), 
                                   ),
                                child:const Center( 
                                child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.grey,
                                backgroundImage: 
                                AssetImage('assets/images/product-placeholder.png'),
                                       ),
                                     ),
                              )
                              :
                              Container(
                                 width:  constraints.maxWidth*0.4,
                                 height: constraints.maxHeight*0.265,
                                 decoration:  BoxDecoration(
                                 color: Colors.white,
                                 border: Border.all(), 
                                   ),
                                child:  Center( 
                                child:  Image.file(_pickedImage!)
                                     ),
                   
                            ),
                  Card(
                       elevation: 4.0,
                       margin:  EdgeInsets.symmetric(
                         vertical:   constraints.maxHeight*0.01,
                         horizontal: constraints.maxWidth*0.01
                         ),
                       child: Container(
                        width:  constraints.maxWidth*0.4,
                        height: constraints.maxHeight*0.4,
                         decoration: const BoxDecoration(
                           color: Colors.white
                         ),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: <Widget>
                           [
                              SizedBox(height: constraints.maxHeight*0.01),
                             const  Text('Take Photos',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black,
                               ),
                              ),
                              SizedBox(height: constraints.maxHeight*0.01),
                               Column(
                                 children: [
                                   InkWell(
                                     onTap: count<=3 ? _pickThreeDImage : null,
                                     child: Container(
                                     margin: EdgeInsets.symmetric(horizontal:constraints.maxWidth*0.01,),
                                     padding:  EdgeInsets.symmetric(
                                     vertical:    constraints.maxHeight*0.015,
                                     horizontal:  constraints.maxWidth*0.06,
                                     ),
                                     height: constraints.maxHeight*0.07,
                                     width: constraints.maxWidth*0.6,
                                     decoration:const  BoxDecoration(
                                       color: Colors.lightBlueAccent,
                                     ),
                                        child:  const Text('Camera',
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                           fontSize: 20,
                                           color: Colors.white),
                                          ), 
                                     ),
                                   ),
                               SizedBox(height: constraints.maxHeight*0.01),
                                InkWell(
                                     onTap: count<=3 ? getImagefromGallery : null,
                                     child: Container(
                                     margin: EdgeInsets.symmetric(horizontal:constraints.maxWidth*0.01,),
                                     padding:  EdgeInsets.symmetric(
                                     vertical:    constraints.maxHeight*0.015,
                                     horizontal:  constraints.maxWidth*0.06,
                                     ),
                                     height: constraints.maxHeight*0.07,
                                     width: constraints.maxWidth*0.6,
                                     decoration:const  BoxDecoration(
                                       color: Colors.blue,
                                     ),
                                        child:  const Text('Gallery',
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                           fontSize: 20,
                                           color: Colors.white),
                                          ), 
                                     ),
                                   ),
                               SizedBox(height: constraints.maxHeight*0.01),
                               Container(
                               margin: EdgeInsets.symmetric(horizontal:constraints.maxWidth*0.01,),
                                 padding:  EdgeInsets.symmetric(
                                  vertical:    constraints.maxHeight*0.015,
                                  horizontal:  constraints.maxWidth*0.01,
                                 ),
                                 height: constraints.maxHeight*0.07,
                                 width: constraints.maxWidth*0.6,
                                 decoration:const  BoxDecoration(
                                   color: Colors.blueGrey,
                                 ),
                                    child:  
                                       Text('Total Photos $count',
                                     style: const TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 17,
                                       color: Colors.white),
                                      ),  
                                 ),
                                  SizedBox(height: constraints.maxHeight*0.01),
                               InkWell(
                                 onTap: ()
                                 {
                                     getUrl();
                                 },
                                 child: Container(
                                 margin: EdgeInsets.symmetric(horizontal:constraints.maxWidth*0.01,),
                                   padding:  EdgeInsets.symmetric(
                                    vertical:    constraints.maxHeight*0.015,
                                    horizontal:  constraints.maxWidth*0.01,
                                   ),
                                   height: constraints.maxHeight*0.07,
                                   width: constraints.maxWidth*0.6,
                                   decoration:const  BoxDecoration(
                                     color: Colors.blueGrey,
                                   ),
                                      child:  
                                         const Text(' Done ',
                                       style:  TextStyle(
                                         fontWeight: FontWeight.bold,
                                         fontSize: 17,

                                         color: Colors.white),
                                        ),  
                                   ),
                               ),
                                 ],
                               ),
                               
                           ],
                         ),      
                       ),
                     )
                  ])
                 :
                       Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              productId!=null
                               ?
                                 Container(
                                 width:  constraints.maxWidth*0.4,
                                 height: constraints.maxHeight*0.4,
                                 decoration:  BoxDecoration(
                                 color: Colors.white,
                                 border: Border.all(), 
                                   ),
                                child:  Center( 
                                child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.grey,
                                backgroundImage: 
                                NetworkImage(_editedProduct.productImage)
                                       ),
                                     ),
                              )
                              :
                               _pickedImage == null
                                ?
                               Container(
                                 width:  constraints.maxWidth*0.4,
                                 height: constraints.maxHeight*0.35,
                                 decoration:  BoxDecoration(
                                 color: Colors.white,
                                 border: Border.all(), 
                                   ),
                                child:const Center( 
                                child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.grey,
                                backgroundImage: 
                                AssetImage('assets/images/product-placeholder.png'),
                                       ),
                                     ),
                              )
                              :
                              Container(
                                 width:  constraints.maxWidth*0.4,
                                 height: constraints.maxHeight*0.265,
                                 decoration:  BoxDecoration(
                                 color: Colors.white,
                                 border: Border.all(), 
                                   ),
                                child:  Center( 
                                child:  Image.file(_pickedImage!)
                                     ),
                   
                            ),
                  Card(
                       elevation: 4.0,
                       margin:  EdgeInsets.symmetric(
                         vertical:   constraints.maxHeight*0.01,
                         horizontal: constraints.maxWidth*0.01
                         ),
                       child: Container(
                        width:  constraints.maxWidth*0.4,
                        height: constraints.maxHeight*0.25,
                         decoration: const BoxDecoration(
                           color: Colors.white
                         ),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: <Widget>
                           [
                              SizedBox(height: constraints.maxHeight*0.01),
                             const  Text('Take Photo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black,
                               ),
                              ),
                              SizedBox(height: constraints.maxHeight*0.01), 
                               InkWell(
                               onTap: _pickNormalImage,
                               child: Container(
                                 margin: EdgeInsets.symmetric(horizontal:constraints.maxWidth*0.01,),
                                 height: constraints.maxHeight*0.07,
                                 width: constraints.maxWidth*0.4,
                                 padding:  EdgeInsets.symmetric(
                                  vertical:    constraints.maxHeight*0.015,
                                  horizontal:  constraints.maxWidth*0.08,
                                 ),
                                 decoration:const  BoxDecoration(
                                   color: Colors.lightBlueAccent,
                                 ),
                                 child:const Text('Camera', 
                                 style: TextStyle(
                                   fontSize: 20,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.white),
                                  ),
                                 ),
                               ),
                               SizedBox(height: constraints.maxHeight*0.01),
                                InkWell(
                                     onTap:  getImagefromGallery,
                                     child: Container(
                                     margin: EdgeInsets.symmetric(horizontal:constraints.maxWidth*0.01,),
                                     padding:  EdgeInsets.symmetric(
                                     vertical:    constraints.maxHeight*0.015,
                                     horizontal:  constraints.maxWidth*0.08,
                                     ),
                                     height: constraints.maxHeight*0.07,
                                     width: constraints.maxWidth*0.6,
                                     decoration:const  BoxDecoration(
                                       color: Colors.blue,
                                     ),
                                        child:  const Text('Gallery',
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                           fontSize: 20,
                                           color: Colors.white),
                                          ), 
                                     ),
                                   ),
                             ],
                            ),  
                         ),      
                       ),
                   ],
                 ),
               ],
              ),
            ),
          ),
        )
            ]
          )
        )
      
        );
             
      
             } 
        );
    
    }
   }

       