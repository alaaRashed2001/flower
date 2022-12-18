import 'package:flower/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constant/colors.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: const [
       //   ProductsAndPrice(),
        ],
        backgroundColor: green,
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 580.h,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: cart.selectedProducts.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(cart.selectedProducts[index].title),
                    subtitle: Text('${cart.selectedProducts[index].price}    ${cart.selectedProducts[index].location}'),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(cart.selectedProducts[index].imagePath),
                    ),
                    trailing: IconButton(onPressed: () {
                      cart.deleteProduct(cart.selectedProducts[index]);
                    }, icon: const Icon(Icons.remove)),
                  ),
                ),
              ),
            ),
          ),
           SizedBox(height: 30.h,),
          ElevatedButton(
            onPressed: (){
              /// ToDo
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xFFFFA4D3)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
            ),
            child:  Text("Pay \$${cart.price}", style:  TextStyle(fontSize: 19.sp),),
          ),
        ],
      ),
    );
  }
}
