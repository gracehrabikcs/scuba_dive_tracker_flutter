// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiveAdapter extends TypeAdapter<Dive> {
  @override
  final int typeId = 0;

  @override
  Dive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dive(
      location: fields[0] as String,
      depth: fields[1] as int,
      date: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Dive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.location)
      ..writeByte(1)
      ..write(obj.depth)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
