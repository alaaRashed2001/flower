class UserModel{
  late String uId;
  late String username;
  late String email;
  late String password;

  UserModel();

  UserModel.fromMap(Map<String,dynamic> map){
    uId = map['uId'];
    username = map['username'];
    email = map['email'];
    password = map['password'];
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map ={};
    map['uId'] = uId;
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}