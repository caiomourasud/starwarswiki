import 'package:hive/hive.dart';
import 'package:starwarswiki/app/utils/id_generator.dart';

part 'people.g.dart';

@HiveType(typeId: 1)
class People extends HiveObject {
  @HiveField(0)
  int id = 0;
  @HiveField(1)
  String name = '';
  @HiveField(2)
  String height = '';
  @HiveField(3)
  String mass = '';
  @HiveField(4)
  String hairColor = '';
  @HiveField(5)
  String skinColor = '';
  @HiveField(6)
  String eyeColor = '';
  @HiveField(7)
  String birthYear = '';
  @HiveField(8)
  String gender = '';
  @HiveField(9)
  String homeworld = '';
  @HiveField(10)
  List<String> films = [];
  @HiveField(11)
  List<String> species = [];
  @HiveField(12)
  List<String> vehicles = [];
  @HiveField(13)
  List<String> starships = [];
  @HiveField(14)
  String created = '';
  @HiveField(15)
  String edited = '';
  @HiveField(16)
  String url = '';
  @HiveField(17)
  bool isFavorite = false;
  @HiveField(18)
  String? image = '';

  People(
      {required this.id,
      required this.name,
      required this.height,
      required this.mass,
      required this.hairColor,
      required this.skinColor,
      required this.eyeColor,
      required this.birthYear,
      required this.gender,
      required this.homeworld,
      required this.films,
      required this.species,
      required this.vehicles,
      required this.starships,
      required this.created,
      required this.edited,
      required this.url,
      this.isFavorite = false,
      this.image = ''});

  People.fromJson(Map<String, dynamic> json) {
    id = IdGenerator.generateId(url: json['url'], type: 'people');
    name = json['name'];
    height = json['height'];
    mass = json['mass'];
    hairColor = json['hair_color'];
    skinColor = json['skin_color'];
    eyeColor = json['eye_color'];
    birthYear = json['birth_year'];
    gender = json['gender'];
    homeworld = json['homeworld'] ?? '';
    films = json['films'].cast<String>();
    species = json['species'].cast<String>();
    vehicles = json['vehicles'].cast<String>();
    starships = json['starships'].cast<String>();
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
    data['height'] = this.height;
    data['mass'] = this.mass;
    data['hair_color'] = this.hairColor;
    data['skin_color'] = this.skinColor;
    data['eye_color'] = this.eyeColor;
    data['birth_year'] = this.birthYear;
    data['gender'] = this.gender;
    data['homeworld'] = this.homeworld;
    data['films'] = this.films;
    data['species'] = this.species;
    data['vehicles'] = this.vehicles;
    data['starships'] = this.starships;
    data['created'] = this.created;
    data['edited'] = this.edited;
    data['url'] = this.url;
    data['is_favorite'] = this.isFavorite;
    data['image'] = this.image;
    return data;
  }
}
