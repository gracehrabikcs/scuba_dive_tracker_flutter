import 'package:hive/hive.dart';

part 'dive.g.dart';

@HiveType(typeId: 0)
class Dive {
  @HiveField(0)
  String location;

  @HiveField(1)
  int depth;

  @HiveField(2)
  String date;

  Dive({
    required this.location,
    required this.depth,
    required this.date,
  });
}
