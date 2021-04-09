// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpecieAdapter extends TypeAdapter<Specie> {
  @override
  final int typeId = 3;

  @override
  Specie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Specie(
      id: fields[0] as int,
      name: fields[1] as String,
      classification: fields[2] as String,
      designation: fields[3] as String,
      averageHeight: fields[4] as String,
      skinColors: fields[5] as String,
      hairColors: fields[6] as String,
      eyeColors: fields[7] as String,
      averageLifespan: fields[8] as String,
      homeworld: fields[9] as String,
      language: fields[10] as String,
      people: (fields[11] as List).cast<String>(),
      films: (fields[12] as List).cast<String>(),
      created: fields[13] as String,
      edited: fields[14] as String,
      url: fields[15] as String,
      isFavorite: fields[16] as bool,
      image: fields[17] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Specie obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.classification)
      ..writeByte(3)
      ..write(obj.designation)
      ..writeByte(4)
      ..write(obj.averageHeight)
      ..writeByte(5)
      ..write(obj.skinColors)
      ..writeByte(6)
      ..write(obj.hairColors)
      ..writeByte(7)
      ..write(obj.eyeColors)
      ..writeByte(8)
      ..write(obj.averageLifespan)
      ..writeByte(9)
      ..write(obj.homeworld)
      ..writeByte(10)
      ..write(obj.language)
      ..writeByte(11)
      ..write(obj.people)
      ..writeByte(12)
      ..write(obj.films)
      ..writeByte(13)
      ..write(obj.created)
      ..writeByte(14)
      ..write(obj.edited)
      ..writeByte(15)
      ..write(obj.url)
      ..writeByte(16)
      ..write(obj.isFavorite)
      ..writeByte(17)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
