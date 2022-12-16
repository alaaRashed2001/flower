import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower/model/product_model.dart';
import 'package:flower/shared_preferences/shared_preferences.dart';

class ProductFbController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// CRUD

  Future<void> createProduct(ProductModel product) async {
    await _firestore
        .collection('products')
        .doc(product.id)
        .set(product.toMap());
  }

  Stream<QuerySnapshot> readProducts(bool all) async* {
    yield* all
        ? _firestore.collection('products').snapshots()
        : _firestore
            .collection('products')
            .where('sellerId', isEqualTo: SharedPreferencesController().getUId)
            .snapshots();
  }

  Future<void> updateProduct(ProductModel product) async {
    await _firestore
        .collection('products')
        .doc(product.id)
        .update(product.toMap());
  }

  Future<void> deleteProduct(String id) async {
    await _firestore.collection('products').doc(id).delete();
  }
}
