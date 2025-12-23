import 'package:hive/hive.dart';

part 'author_entity.g.dart';

@HiveType(typeId: 1)
class Author {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  Author({
    required this.id,
    required this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
