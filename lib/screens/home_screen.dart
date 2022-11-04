import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? isElevated = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: GestureDetector(
          onTap: (){
            setState(() {
              
            });
            isElevated = !isElevated!;
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 200,
            width: 200,
            // padding: EdgeInsets.all(8),
            // child: Text("data"),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(50),
              boxShadow: isElevated! ? [
                 BoxShadow(
                  color: Colors.grey[500]!,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ] : null
            ),
          ),
        ),
      ),
    );
  }
}