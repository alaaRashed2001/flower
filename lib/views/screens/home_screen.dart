import 'package:flower/data/dummy_data.dart';
import 'package:flower/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/colors.dart';
import '../widgets/custom_appbar.dart';
import 'checkout_screen.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          actions: [
            ProductsAndPrice(),
          ],
          backgroundColor: green,
          title: const Text("Home"),
          centerTitle: true,
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
                        color: Colors.white,
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
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          )
                      );
                    }),
                ListTile(
                    title: const Text("My products"),
                    leading: const Icon(Icons.add_shopping_cart),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CheckoutScreen(),
                          ),
                      );
                    }),
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
      body: Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 16,
         start: 4,
         end: 4,
       ),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 33),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(product: items[index]),
                    ),
                  );
                },
                child: GridTile(
                  footer: GridTileBar(
                    trailing:
                    Consumer<CartProvider>(builder: ((context, cart, child) {
                      return IconButton(
                          color:green,
                          onPressed: () {
                            cart.addProduct(items[index]);
                          },
                          icon: const Icon(
                              Icons.add,
                            size: 30,
                          ));
                    })),

                    leading: const Text("\$12.99"),

                    title: const Text(
                      "",
                    ),
                  ),
                  child: Stack(children: [
                    Positioned(
                      top: -3,
                      bottom: -9,
                      right: 0,
                      left: 0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                              items[index].imagePath,
                          )),
                    ),
                  ]),
                ),
              );
            }),
      ),

    );
  }
}
