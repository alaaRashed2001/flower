import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(211, 164, 255, 193),
                          shape: BoxShape.circle),
                      child: const Text(
                        "8",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      )),

                  IconButton(
                      onPressed: () { },
                      icon: Icon(Icons.add_shopping_cart)),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Text("\$ 128"),
              )
            ],
          )
        ],
      ),
      drawer: Drawer(),
    );
  }
}
