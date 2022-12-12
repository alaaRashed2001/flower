import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import '../screens/checkout_screen.dart';

class ProductsAndPrice extends StatelessWidget {
  const ProductsAndPrice({Key? key}) : super(key: key);
  // Consumer<ClassName>(
  // builder: ((context, classInstancee, child) {
  // return Text("${classInstancee.myname}");
  // })),
  @override
  Widget build(BuildContext context) {
    return  Consumer<CartProvider>(builder: ((context, cart, child) {
      return Row(
        children: [
          Stack(
            children: [
              Positioned(
                bottom: 24,
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFA4D3),
                        shape: BoxShape.circle),
                    child: Text(
                      "${cart.selectedProducts.length}",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black),
                    )),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const CheckoutScreen(),
                    )
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              "\$ ${cart.price}",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      );
    }));
  }
}
