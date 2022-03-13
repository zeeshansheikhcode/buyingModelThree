import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle myStyle(double size,[Color? color,FontWeight fw = FontWeight.w700])
{
  return GoogleFonts.montserrat(
    fontSize: size,
    fontWeight:  fw,
    color: color,
  );
}
CollectionReference usercollection = 
    FirebaseFirestore.instance.collection('users');