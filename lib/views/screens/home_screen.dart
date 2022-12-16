import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower/firebase/product_fb_controller.dart';
import 'package:flower/provider/cart_provider.dart';
import 'package:flower/shared_preferences/shared_preferences.dart';
import 'package:flower/views/screens/admin_panels/add_products.dart';
import 'package:flower/views/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/colors.dart';
import '../../model/product_model.dart';
import '../../model/user_model.dart';
import '../widgets/custom_appbar.dart';
import 'checkout_screen.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SharedPreferencesController().getUserType == UserTypes.buyer.name
              ? const ProductsAndPrice()
              : const SizedBox()
        ],
        backgroundColor: green,
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 16,
          start: 4,
          end: 4,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: ProductFbController().readProducts(
              SharedPreferencesController().getUserType ==
                  UserTypes.buyer.name),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.black));
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              var products = snapshot.data!.docs
                  .map((e) =>
                      ProductModel.fromMap(e.data()! as Map<String, dynamic>))
                  .toList();
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(product: products[index]),
                          ),
                        );
                      },
                      child: GridTile(
                        footer: GridTileBar(
                          trailing: Consumer<CartProvider>(
                              builder: ((context, cart, child) {
                            return SharedPreferencesController().getUserType ==
                                    UserTypes.buyer.name
                                ? IconButton(
                                    color: green,
                                    onPressed: () {
                                      cart.addProduct(products[index]);
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      size: 30,
                                    ),
                                  )
                                : SizedBox();
                          })),
                          leading: const Text("\$12.99"),
                          title: const Text(
                            "",
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -3,
                              bottom: -9,
                              right: 0,
                              left: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  products[index].imagePath,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 5,
                              child:
                                  SharedPreferencesController().getUserType ==
                                          UserTypes.seller.name
                                      ? Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddProducts(
                                                                product: products[
                                                                    index])));
                                              },
                                              child: const CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.green,
                                                child: Icon(Icons.edit),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            InkWell(
                                              onTap: () async {
                                                await ProductFbController()
                                                    .deleteProduct(
                                                        products[index].id!);
                                              },
                                              child: const CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.red,
                                                child: Icon(Icons.delete),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(child: Text('No Products'));
            }
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/1.jpg'),
                        fit: BoxFit.cover),
                  ),
                  accountName: const Text("Alaa Rashed",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  accountEmail: Text(SharedPreferencesController().getEmail),
                  currentAccountPictureSize: const Size.square(99),
                  currentAccountPicture: const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('assets/images/2.jpg'),
                  ),
                ),
                ListTile(
                    title: const Text("Home"),
                    leading: const Icon(Icons.home),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                SharedPreferencesController().getUserType ==
                        UserTypes.buyer.name
                    ? ListTile(
                        title: const Text("My Cart"),
                        leading: const Icon(Icons.add_shopping_cart),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CheckoutScreen(),
                            ),
                          );
                        })
                    : const SizedBox.shrink(),
                SharedPreferencesController().getUserType ==
                        UserTypes.seller.name
                    ? ListTile(
                        title: const Text("Add Product"),
                        leading: const Icon(Icons.add),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AddProducts(product: null),
                            ),
                          );
                        })
                    : const SizedBox.shrink(),
                ListTile(
                    title: const Text("About"),
                    leading: const Icon(Icons.help_center),
                    onTap: () {}),
                ListTile(
                    title: const Text("Logout"),
                    leading: const Icon(Icons.exit_to_app),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      await SharedPreferencesController().logout();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    }),
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
    );
  }
}
