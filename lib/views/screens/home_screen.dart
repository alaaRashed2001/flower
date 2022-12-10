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
                      child: const Text("8",
                          style: TextStyle(
                            color: Colors.black,
                          ))),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_shopping_cart)),
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
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/1.jpg'),
                        fit: BoxFit.cover),
                  ),
                  accountName: Text("Alaa Rashed",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                  accountEmail: Text("alaa.noman.rashed@gmail.com"),
                  currentAccountPictureSize: Size.square(99),
                  currentAccountPicture: CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('assets/images/2.jpg'),
                  ),
                ),
                ListTile(
                    title: const Text("Home"),
                    leading: const Icon(Icons.home),
                    onTap: () {}),
                ListTile(
                    title: const Text("My products"),
                    leading: const Icon(Icons.add_shopping_cart),
                    onTap: () {}),
                ListTile(
                    title: const Text("About"),
                    leading: const Icon(Icons.help_center),
                    onTap: () {}),
                ListTile(
                    title: const Text("Logout"),
                    leading: const Icon(Icons.exit_to_app),
                    onTap: () {}),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: const Text(
                "Roses symbol to apologize and regret.",
                style: TextStyle(
                  fontSize: 16,
                  color: green,
                ),
              ),
            )
          ],
        ),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 33),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return GridTile(
              footer: GridTileBar(
 //backgroundColor: Color(0xFF497F6E),
                trailing: IconButton(
                    color: const Color(0xFF3E5E46),
                    onPressed: () {},
                    icon: Icon(Icons.add)),

                leading: Text("\$12.99"),

                title: Text(
                  "",
                ),
              ),
              child: GestureDetector(
                  onTap: () {},
// use ClipRRect & Positioned
                  child: Image.asset("assets/images/green-flowers.jpg")),
            );
          }),
    );
  }
}
