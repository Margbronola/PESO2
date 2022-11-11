import 'dart:ui';

import 'package:flutter/material.dart';

class MyWidget{
  TextFormField textFormField({
    String? label,
    TextEditingController? controller,
    TextInputType? inputType,
    bool? obscurity,
    }){
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2, color: Colors.grey
          ), 
        ),
        labelText: label,
      ),
      obscureText: obscurity!,
    );
  }

  TextFormField textFormField2({
    TextEditingController? controller,
    TextAlign align = TextAlign.start,
  }){
    return TextFormField(
      controller: controller,
      textAlign: align,
      maxLines: null,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 7),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), 
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), 
        ),
      ),
    );
  }

  Text text({
    String? label,
    double? size,
    FontWeight? weight,
    TextAlign? align,
    double? letterSpacing,
    Color? color,
  }){
    return Text(
      label!,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        letterSpacing: letterSpacing,
        color: color
      ),
      textAlign: align,
    );
  }

  loader() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
      child: Container(
        color: Colors.white.withOpacity(0.4),
        child: const Center(
            child: CircularProgressIndicator(
          color: Colors.black54,
        )),
      ),
    );
  }
}