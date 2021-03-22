// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleTableAdapter extends TypeAdapter<VehicleTable> {
  @override
  final int typeId = 5;

  @override
  VehicleTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehicleTable(
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
      vehicleClass: fields[11] as String,
      pilots: (fields[12] as List).cast<String>(),
      films: (fields[13] as List).cast<String>(),
      created: fields[14] as String,
      edited: fields[15] as String,
      url: fields[16] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VehicleTable obj) {
    writer
      ..writeByte(17)
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
      ..write(obj.vehicleClass)
      ..writeByte(12)
      ..write(obj.pilots)
      ..writeByte(13)
      ..write(obj.films)
      ..writeByte(14)
      ..write(obj.created)
      ..writeByte(15)
      ..write(obj.edited)
      ..writeByte(16)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
