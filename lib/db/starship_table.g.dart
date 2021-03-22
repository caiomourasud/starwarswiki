// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starship_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StarshipTableAdapter extends TypeAdapter<StarshipTable> {
  @override
  final int typeId = 4;

  @override
  StarshipTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StarshipTable(
      id: fields[0] as int,
      name: fields[1] as String,
      model: fields[2] as String,
      manufacturer: fields[3] as String,
      costInCredits: fields[4] as String,
      length: fields[5] as String,
      maxAtmospheringSpeed: fields[6] as String,
      crew: fields[7] as String,
      passengers: fields[8] as String,
      cargoCapacity: fields[9] as String,
      consumables: fields[10] as String,
      hyperdriveRating: fields[11] as String,
      mGLT: fields[12] as String,
      starshipClass: fields[13] as String,
      pilots: (fields[14] as List).cast<String>(),
      films: (fields[15] as List).cast<String>(),
      created: fields[16] as String,
      edited: fields[17] as String,
      url: fields[18] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StarshipTable obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.model)
      ..writeByte(3)
      ..write(obj.manufacturer)
      ..writeByte(4)
      ..write(obj.costInCredits)
      ..writeByte(5)
      ..write(obj.length)
      ..writeByte(6)
      ..write(obj.maxAtmospheringSpeed)
      ..writeByte(7)
      ..write(obj.crew)
      ..writeByte(8)
      ..write(obj.passengers)
      ..writeByte(9)
      ..write(obj.cargoCapacity)
      ..writeByte(10)
      ..write(obj.consumables)
      ..writeByte(11)
      ..write(obj.hyperdriveRating)
      ..writeByte(12)
      ..write(obj.mGLT)
      ..writeByte(13)
      ..write(obj.starshipClass)
      ..writeByte(14)
      ..write(obj.pilots)
      ..writeByte(15)
      ..write(obj.films)
      ..writeByte(16)
      ..write(obj.created)
      ..writeByte(17)
      ..write(obj.edited)
      ..writeByte(18)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StarshipTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
