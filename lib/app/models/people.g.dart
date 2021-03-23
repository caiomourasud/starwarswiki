// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeopleAdapter extends TypeAdapter<People> {
  @override
  final int typeId = 1;

  @override
  People read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return People(
      id: fields[0] as int,
      name: fields[1] as String,
      height: fields[2] as String,
      mass: fields[3] as String,
      hairColor: fields[4] as String,
      skinColor: fields[5] as String,
      eyeColor: fields[6] as String,
      birthYear: fields[7] as String,
      gender: fields[8] as String,
      homeworld: fields[9] as String,
      films: (fields[10] as List).cast<String>(),
      species: (fields[11] as List).cast<String>(),
      vehicles: (fields[12] as List).cast<String>(),
      starships: (fields[13] as List).cast<String>(),
      created: fields[14] as String,
      edited: fields[15] as String,
      url: fields[16] as String,
      isFavorite: fields[17] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, People obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.mass)
      ..writeByte(4)
      ..write(obj.hairColor)
      ..writeByte(5)
      ..write(obj.skinColor)
      ..writeByte(6)
      ..write(obj.eyeColor)
      ..writeByte(7)
      ..write(obj.birthYear)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.homeworld)
      ..writeByte(10)
      ..write(obj.films)
      ..writeByte(11)
      ..write(obj.species)
      ..writeByte(12)
      ..write(obj.vehicles)
      ..writeByte(13)
      ..write(obj.starships)
      ..writeByte(14)
      ..write(obj.created)
      ..writeByte(15)
      ..write(obj.edited)
      ..writeByte(16)
      ..write(obj.url)
      ..writeByte(17)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeopleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
