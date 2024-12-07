import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Ingresa ciudad",
          hintStyle: TextStyle(color: Colors.white54),
          filled: true,
          fillColor: Color(0xff393D42),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.white54,
          ),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
