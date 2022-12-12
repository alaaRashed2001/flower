class ProductModel{
late  String imagePath;
 late num price;
 late String location;

ProductModel({required this.imagePath , required this.price , this.location = 'Main branch'});
}