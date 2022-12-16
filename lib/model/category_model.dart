import 'dart:convert';

class CategoryModel {
  String? id;
  String imagePath;
  String nameAr;
  String nameEn;
  CategoryModel(
      {required this.imagePath,
        required this.nameAr,
        required this.nameEn,
        this.id});

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'nameAr': nameAr,
      'nameEn': nameEn,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        imagePath: map['imagePath'] ?? '',
        nameAr: map['nameAr'] ?? '',
        nameEn: map['nameEn'] ?? '',
        id: map['id'] ?? ' ');
  }

}