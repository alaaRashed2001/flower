import 'package:flower/constant/colors.dart';
import 'package:flower/views/screens/admin_panels/add_products.dart';
import 'package:flower/views/screens/admin_panels/edit_product.dart';
import 'package:flower/views/screens/admin_panels/view_orders.dart';
import 'package:flower/views/widgets/my_button.dart';
import 'package:flutter/material.dart';

class AdminOptions extends StatelessWidget {
  const AdminOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
                title: 'Add Product',
                backgroundColor: Colors.white,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AddProducts()));
                }
            ),
SizedBox(height: 30,),
            MyButton(
                title: 'Edit Product',
                backgroundColor: Colors.white,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const EditProducts()));
                }
            ),
            SizedBox(height: 30,),
            MyButton(
                title: 'View Orders',
                backgroundColor: Colors.white,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ViewOrders()));
                }
            ),
          ],
        ),
      ),
    );
  }
}
