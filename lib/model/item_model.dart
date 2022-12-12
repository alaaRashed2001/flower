class ProductModel{
late  String imagePath;
 late num price;
 late String location;
 late String title;
ProductModel({required this.imagePath , required this.price , this.location = 'Main branch', required this.title});
}