import 'package:flutter/material.dart';
// import 'package:badges/badges.dart';

class BBadge extends StatelessWidget {
  const BBadge({
    Key? key,
    required this.child,
    required this.value,
    this.color,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color ?? Theme.of(context).accentColor,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style:const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}

//  Widget _shoppingCartBadge() {
//     return Badge(
//       position: BadgePosition.topEnd(top: 0, end: 3),
//       animationDuration: Duration(milliseconds: 300),
//       animationType: BadgeAnimationType.slide,
//       badgeContent: Text(
//         _counter.toString(),
//         style: TextStyle(color: Colors.white),
//       ),
//       child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
//     );
//   }