import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  TextEditingController controller;
  VoidCallback function;
  SearchBox({required this.controller, required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: "Ingresa ciudad",
            hintStyle: TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Color(0xff393D42),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              onPressed: function,
              icon: Icon(
                Icons.search,
                color: Colors.white54,
              ),
            )),
        style: TextStyle(color: Colors.white),
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "El campo es obligatorio";
          }
          return null;
        },
      ),
    );
  }
}
