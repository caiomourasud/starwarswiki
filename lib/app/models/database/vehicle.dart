import 'package:hive/hive.dart';
import 'package:starwarswiki/app/utils/id_generator.dart';

part 'vehicle.g.dart';

@HiveType(typeId: 5)
class Vehicle extends HiveObject {
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
  String vehicleClass = '';
  @HiveField(12)
  List<String> pilots = [];
  @HiveField(13)
  List<String> films = [];
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

  Vehicle(
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
      required this.vehicleClass,
      required this.pilots,
      required this.films,
      required this.created,
      required this.edited,
      required this.url,
      this.isFavorite = false,
      this.image = ''});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = IdGenerator.generateId(url: json['url'], type: 'vehicles');
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
    vehicleClass = json['vehicle_class'];
    pilots = json['pilots'].cast<String>();
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
    data['model'] = this.model;
    data['manufacturer'] = this.manufacturer;
    data['cost_in_credits'] = this.costInCredits;
    data['length'] = this.length;
    data['max_atmosphering_speed'] = this.maxAtmospheringSpeed;
    data['crew'] = this.crew;
    data['passengers'] = this.passengers;
    data['cargo_capacity'] = this.cargoCapacity;
    data['consumables'] = this.consumables;
    data['vehicle_class'] = this.vehicleClass;
    data['pilots'] = this.pilots;
    data['films'] = this.films;
    data['created'] = this.created;
    data['edited'] = this.edited;
    data['url'] = this.url;
    data['is_favorite'] = this.isFavorite;
    data['image'] = this.image;
    return data;
  }
}
