import 'package:flutter/material.dart';
import 'package:trpg/screens/main_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2.0),
            borderRadius: BorderRadius.circular(15),
            color: Colors.amberAccent,
          ),
          width: 500,
          height: 500,
          child: Column(
            children: [
              const Text("TRPG"),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  textStyle: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
                child: const Text("시작"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
