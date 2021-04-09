// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilmAdapter extends TypeAdapter<Film> {
  @override
  final int typeId = 0;

  @override
  Film read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Film(
      id: fields[0] as int,
      title: fields[1] as String,
      episodeId: fields[2] as int,
      openingCrawl: fields[3] as String,
      director: fields[4] as String,
      producer: fields[5] as String,
      releaseDate: fields[6] as String,
      characters: (fields[7] as List).cast<String>(),
      planets: (fields[8] as List).cast<String>(),
      starships: (fields[9] as List).cast<String>(),
      vehicles: (fields[10] as List).cast<String>(),
      species: (fields[11] as List).cast<String>(),
      created: fields[12] as String,
      edited: fields[13] as String,
      url: fields[14] as String,
      isFavorite: fields[15] as bool,
      image: fields[16] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Film obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.episodeId)
      ..writeByte(3)
      ..write(obj.openingCrawl)
      ..writeByte(4)
      ..write(obj.director)
      ..writeByte(5)
      ..write(obj.producer)
      ..writeByte(6)
      ..write(obj.releaseDate)
      ..writeByte(7)
      ..write(obj.characters)
      ..writeByte(8)
      ..write(obj.planets)
      ..writeByte(9)
      ..write(obj.starships)
      ..writeByte(10)
      ..write(obj.vehicles)
      ..writeByte(11)
      ..write(obj.species)
      ..writeByte(12)
      ..write(obj.created)
      ..writeByte(13)
      ..write(obj.edited)
      ..writeByte(14)
      ..write(obj.url)
      ..writeByte(15)
      ..write(obj.isFavorite)
      ..writeByte(16)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilmAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
