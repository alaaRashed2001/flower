import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower/model/user_model.dart';

class UserFbController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel userModel)async{
    await _firestore.collection('users').doc(userModel.uId).set(userModel.toMap());
  }

  Future<void> readUsers(UserModel userModel)async{
    /// ToDo
  }

  Future<void> updateUser(UserModel userModel)async{
    await _firestore.collection('users').doc(userModel.uId).update(userModel.toMap());
  }

 Future<void>  deleteUser(UserModel userModel)async{
    await _firestore.collection('users').doc(userModel.uId).delete();
 }
}