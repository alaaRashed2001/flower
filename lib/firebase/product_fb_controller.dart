import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower/model/product_model.dart';

class ProductFbController{
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createProduct(ProductModel productModel)async{
    await _firestore.collection('products').doc(productModel.id).set(productModel.toMap());
  }

  Future<List<ProductModel>> getAllProducts()async{
    QuerySnapshot<Map<String, dynamic>> productSnapshot =   await _firestore.collection('products').get();
  List<ProductModel> products = productSnapshot.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
    return products;
  }

  Future<void> updateProduct(ProductModel productModel)async{
    await _firestore.collection('products').doc(productModel.id).update(productModel.toMap());
  }

  Future<void> deleteProduct( ProductModel productModel)async{
    await _firestore.collection('products').doc(productModel.id).delete();
  }

}