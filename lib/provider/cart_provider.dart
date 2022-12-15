import 'package:flower/model/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier{
 List selectedProducts = [];
 int price = 0;

 /// Add product And sum total price
 addProduct(ProductModel productModel){
   selectedProducts.add(productModel);
   price += productModel.price.round();
   notifyListeners();
 }

 deleteProduct(ProductModel productModel){
   selectedProducts.remove(productModel);
   price -= productModel.price.round();
   notifyListeners();
 }
}