import 'package:flutter/foundation.dart';
class CartItem
{
   String id;
   String title;
   int quantity;
   double price;
   String? productId;

  CartItem({
  required this.id,
  required this.title,
  required this.quantity,
  required this.price,
  this.productId
    });
}
class Cart with ChangeNotifier{
  Map<String,CartItem> _items = {};
  Map<String,CartItem> get items {
    return {..._items};
  }
  int _counter = 0;

  int get itemCount {
 
    return _counter;
  }
  double get totalAmount {
    var total=0.0;
    _items.forEach((key, cartItem)
     { 
       total += cartItem.price * cartItem.quantity;
     });
     return total;
  }

  void addItem(String productId,double price,String title)
  {  
    if(_items.containsKey(productId))
     {
       _items.update(
         productId,
        (existingCartItem) => CartItem(
                id: existingCartItem.id,
             title: existingCartItem.title,
             price: existingCartItem.price,
          quantity: existingCartItem.quantity+1, 
        )
      );
     }
     else
     {
       _items.putIfAbsent(
         productId,
          () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1
        ));
     }
     _counter++;
     notifyListeners();
  }
  void removesingleitem(String productId)
  {
    if(!_items.containsKey(productId))
       {
          return;
       }
        
    if(_items[productId]!.quantity > 1)
    {
      _items.update(productId, 
         (existingcartitem) => CartItem(
           id: existingcartitem.id,
           title: existingcartitem.title,
           price: existingcartitem.price,
           quantity: existingcartitem.quantity-1,
           )
          );
    }
    else
    {
      _items.remove(productId);
    }
    notifyListeners();
  }
  
  void removeItem(String productId)
  {
    _items.remove(productId);
    notifyListeners();
  }
  void clear() {
    _items = {};
    notifyListeners();
  }
}