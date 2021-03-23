import 'package:hive/hive.dart';
import 'package:starwarswiki/app/utils/id_generator.dart';

part 'film.g.dart';

@HiveType(typeId: 0)
class Film extends HiveObject {
  @HiveField(0)
  int id = 0;
  @HiveField(1)
  String title = '';
  @HiveField(2)
  int episodeId = 0;
  @HiveField(3)
  String openingCrawl = '';
  @HiveField(4)
  String director = '';
  @HiveField(5)
  String producer = '';
  @HiveField(6)
  String releaseDate = '';
  @HiveField(7)
  List<String> characters = [];
  @HiveField(8)
  List<String> planets = [];
  @HiveField(9)
  List<String> starships = [];
  @HiveField(10)
  List<String> vehicles = [];
  @HiveField(11)
  List<String> species = [];
  @HiveField(12)
  String created = '';
  @HiveField(13)
  String edited = '';
  @HiveField(14)
  String url = '';

  Film(
      {required this.id,
      required this.title,
      required this.episodeId,
      required this.openingCrawl,
      required this.director,
      required this.producer,
      required this.releaseDate,
      required this.characters,
      required this.planets,
      required this.starships,
      required this.vehicles,
      required this.species,
      required this.created,
      required this.edited,
      required this.url});

  Film.fromJson(Map<String, dynamic> json) {
    id = IdGenerator.generateId(url: json['url'], type: 'films');
    title = json['title'];
    episodeId = json['episode_id'];
    openingCrawl = json['opening_crawl'];
    director = json['director'];
    producer = json['producer'];
    releaseDate = json['release_date'];
    characters = json['characters'].cast<String>();
    planets = json['planets'].cast<String>();
    starships = json['starships'].cast<String>();
    vehicles = json['vehicles'].cast<String>();
    species = json['species'].cast<String>();
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['episode_id'] = this.episodeId;
    data['opening_crawl'] = this.openingCrawl;
    data['director'] = this.director;
    data['producer'] = this.producer;
    data['release_date'] = this.releaseDate;
    data['characters'] = this.characters;
    data['planets'] = this.planets;
    data['starships'] = this.starships;
    data['vehicles'] = this.vehicles;
    data['species'] = this.species;
    data['created'] = this.created;
    data['edited'] = this.edited;
    data['url'] = this.url;
    return data;
  }
}
