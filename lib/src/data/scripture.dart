import 'joy.dart';

class Scripture {
  final int id;
  final String name;
  final String verse;
  final joys = <Joy>[];

  Scripture(this.id, this.name, this.verse);
}
