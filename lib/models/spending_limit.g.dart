// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spending_limit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpendingLimitAdapter extends TypeAdapter<SpendingLimit> {
  @override
  final int typeId = 3;

  @override
  SpendingLimit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpendingLimit(
      dailyLimit: fields[0] == null ? 0 : (fields[0] as num).toDouble(),
      monthlyLimit: fields[1] == null ? 0 : (fields[1] as num).toDouble(),
      notifyOnExceed: fields[2] == null ? true : fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SpendingLimit obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dailyLimit)
      ..writeByte(1)
      ..write(obj.monthlyLimit)
      ..writeByte(2)
      ..write(obj.notifyOnExceed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpendingLimitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
