import 'package:flutter/material.dart';

class ToWatchList extends StatelessWidget {
  const ToWatchList({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'To Watch List',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
    );
  }
}
