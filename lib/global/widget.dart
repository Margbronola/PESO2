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
}