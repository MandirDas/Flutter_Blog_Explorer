import 'package:hive/hive.dart';

part 'hive_data.g.dart';

@HiveType(typeId: 0)
class Item {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String image_url;

  @HiveField(3)
  bool isliked;

  Item({required this.title, required this.image_url, required this.id,this.isliked=false});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      image_url: json['image_url'],
      isliked: json['isLiked'] ?? false,
    );
  }
}
