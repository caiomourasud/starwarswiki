import 'package:hive/hive.dart';
import 'package:starwarswiki/app/utils/id_generator.dart';

part 'specie.g.dart';

@HiveType(typeId: 3)
class Specie extends HiveObject {
  @HiveField(0)
  int id = 0;
  @HiveField(1)
  String name = '';
  @HiveField(2)
  String classification = '';
  @HiveField(3)
  String designation = '';
  @HiveField(4)
  String averageHeight = '';
  @HiveField(5)
  String skinColors = '';
  @HiveField(6)
  String hairColors = '';
  @HiveField(7)
  String eyeColors = '';
  @HiveField(8)
  String averageLifespan = '';
  @HiveField(9)
  String homeworld = '';
  @HiveField(10)
  String language = '';
  @HiveField(11)
  List<String> people = [];
  @HiveField(12)
  List<String> films = [];
  @HiveField(13)
  String created = '';
  @HiveField(14)
  String edited = '';
  @HiveField(15)
  String url = '';
  @HiveField(16)
  bool isFavorite = false;
  @HiveField(17)
  String image = '';

  Specie(
      {required this.id,
      required this.name,
      required this.classification,
      required this.designation,
      required this.averageHeight,
      required this.skinColors,
      required this.hairColors,
      required this.eyeColors,
      required this.averageLifespan,
      required this.homeworld,
      required this.language,
      required this.people,
      required this.films,
      required this.created,
      required this.edited,
      required this.url,
      this.isFavorite = false,
      required this.image});

  Specie.fromJson(Map<String, dynamic> json) {
    id = IdGenerator.generateId(url: json['url'], type: 'species');
    name = json['name'];
    classification = json['classification'];
    designation = json['designation'];
    averageHeight = json['average_height'];
    skinColors = json['skin_colors'];
    hairColors = json['hair_colors'];
    eyeColors = json['eye_colors'];
    averageLifespan = json['average_lifespan'];
    homeworld = json['homeworld'] ?? '';
    language = json['language'];
    people = json['people'].cast<String>();
    films = json['films'].cast<String>();
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
    isFavorite = false;
    image = '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['classification'] = this.classification;
    data['designation'] = this.designation;
    data['average_height'] = this.averageHeight;
    data['skin_colors'] = this.skinColors;
    data['hair_colors'] = this.hairColors;
    data['eye_colors'] = this.eyeColors;
    data['average_lifespan'] = this.averageLifespan;
    data['homeworld'] = this.homeworld;
    data['language'] = this.language;
    data['people'] = this.people;
    data['films'] = this.films;
    data['created'] = this.created;
    data['edited'] = this.edited;
    data['url'] = this.url;
    data['is_favorite'] = this.isFavorite;
    data['image'] = this.image;
    return data;
  }
}
