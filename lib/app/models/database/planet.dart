import 'package:hive/hive.dart';
import 'package:starwarswiki/app/utils/id_generator.dart';

part 'planet.g.dart';

@HiveType(typeId: 2)
class Planet extends HiveObject {
  @HiveField(0)
  int id = 0;
  @HiveField(1)
  String name = '';
  @HiveField(2)
  String rotationPeriod = '';
  @HiveField(3)
  String orbitalPeriod = '';
  @HiveField(4)
  String diameter = '';
  @HiveField(5)
  String climate = '';
  @HiveField(6)
  String gravity = '';
  @HiveField(7)
  String terrain = '';
  @HiveField(8)
  String surfaceWater = '';
  @HiveField(9)
  String population = '';
  @HiveField(10)
  List<String> residents = [];
  @HiveField(11)
  List<String> films = [];
  @HiveField(12)
  String created = '';
  @HiveField(13)
  String edited = '';
  @HiveField(14)
  String url = '';
  @HiveField(15)
  bool isFavorite = false;
  @HiveField(16)
  String? image = '';

  Planet(
      {required this.id,
      required this.name,
      required this.rotationPeriod,
      required this.orbitalPeriod,
      required this.diameter,
      required this.climate,
      required this.gravity,
      required this.terrain,
      required this.surfaceWater,
      required this.population,
      required this.residents,
      required this.films,
      required this.created,
      required this.edited,
      required this.url,
      this.isFavorite = false,
      this.image});

  Planet.fromJson(Map<String, dynamic> json) {
    id = IdGenerator.generateId(url: json['url'], type: 'planets');
    name = json['name'];
    rotationPeriod = json['rotation_period'];
    orbitalPeriod = json['orbital_period'];
    diameter = json['diameter'];
    climate = json['climate'];
    gravity = json['gravity'];
    terrain = json['terrain'];
    surfaceWater = json['surface_water'];
    population = json['population'];
    residents = json['residents'].cast<String>();
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
    data['rotation_period'] = this.rotationPeriod;
    data['orbital_period'] = this.orbitalPeriod;
    data['diameter'] = this.diameter;
    data['climate'] = this.climate;
    data['gravity'] = this.gravity;
    data['terrain'] = this.terrain;
    data['surface_water'] = this.surfaceWater;
    data['population'] = this.population;
    data['residents'] = this.residents;
    data['films'] = this.films;
    data['created'] = this.created;
    data['edited'] = this.edited;
    data['url'] = this.url;
    data['is_favorite'] = this.isFavorite;
    data['image'] = this.image;
    return data;
  }
}
