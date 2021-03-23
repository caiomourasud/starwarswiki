import 'package:hive/hive.dart';
import 'package:starwarswiki/app/utils/id_generator.dart';

part 'starship.g.dart';

@HiveType(typeId: 4)
class Starship extends HiveObject {
  @HiveField(0)
  int id = 0;
  @HiveField(1)
  String name = '';
  @HiveField(2)
  String model = '';
  @HiveField(3)
  String manufacturer = '';
  @HiveField(4)
  String costInCredits = '';
  @HiveField(5)
  String length = '';
  @HiveField(6)
  String maxAtmospheringSpeed = '';
  @HiveField(7)
  String crew = '';
  @HiveField(8)
  String passengers = '';
  @HiveField(9)
  String cargoCapacity = '';
  @HiveField(10)
  String consumables = '';
  @HiveField(11)
  String hyperdriveRating = '';
  @HiveField(12)
  String mGLT = '';
  @HiveField(13)
  String starshipClass = '';
  @HiveField(14)
  List<String> pilots = [];
  @HiveField(15)
  List<String> films = [];
  @HiveField(16)
  String created = '';
  @HiveField(17)
  String edited = '';
  @HiveField(18)
  String url = '';

  Starship(
      {required this.id,
      required this.name,
      required this.model,
      required this.manufacturer,
      required this.costInCredits,
      required this.length,
      required this.maxAtmospheringSpeed,
      required this.crew,
      required this.passengers,
      required this.cargoCapacity,
      required this.consumables,
      required this.hyperdriveRating,
      required this.mGLT,
      required this.starshipClass,
      required this.pilots,
      required this.films,
      required this.created,
      required this.edited,
      required this.url});

  Starship.fromJson(Map<String, dynamic> json) {
    id = IdGenerator.generateId(url: json['url'], type: 'starships');
    name = json['name'];
    model = json['model'];
    manufacturer = json['manufacturer'];
    costInCredits = json['cost_in_credits'];
    length = json['length'];
    maxAtmospheringSpeed = json['max_atmosphering_speed'];
    crew = json['crew'];
    passengers = json['passengers'];
    cargoCapacity = json['cargo_capacity'];
    consumables = json['consumables'];
    hyperdriveRating = json['hyperdrive_rating'];
    mGLT = json['MGLT'];
    starshipClass = json['starship_class'];
    pilots = json['pilots'].cast<String>();
    films = json['films'].cast<String>();
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['model'] = this.model;
    data['manufacturer'] = this.manufacturer;
    data['cost_in_credits'] = this.costInCredits;
    data['length'] = this.length;
    data['max_atmosphering_speed'] = this.maxAtmospheringSpeed;
    data['crew'] = this.crew;
    data['passengers'] = this.passengers;
    data['cargo_capacity'] = this.cargoCapacity;
    data['consumables'] = this.consumables;
    data['hyperdrive_rating'] = this.hyperdriveRating;
    data['MGLT'] = this.mGLT;
    data['starship_class'] = this.starshipClass;
    data['pilots'] = this.pilots;
    data['films'] = this.films;
    data['created'] = this.created;
    data['edited'] = this.edited;
    data['url'] = this.url;
    return data;
  }
}
