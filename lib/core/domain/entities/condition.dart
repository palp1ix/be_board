import 'package:equatable/equatable.dart';

class Condition extends Equatable {
  final String id;
  final String name;
  final String slug;

  const Condition({required this.id, required this.name, required this.slug});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
    );
  }

  @override
  List<Object?> get props => [id, name, slug];
}
