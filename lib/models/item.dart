/// Itemモデルクラス
class Item {
  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.count,
    required this.createdAt,
  });

  // serverから受け取った時にDartに変える
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      count: json['count'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  // 型を指定している
  final String id;
  final String name;
  final String description;
  final String location;
  final int count;
  final DateTime createdAt;

  // serverに送る時jsonに変える
  Map<String, dynamic> toJson() {
    return {
      'item': {
        'name': name,
        'description': description,
        'location': location,
        'count': count,
      },
    };
  }
}
