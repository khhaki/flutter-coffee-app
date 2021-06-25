class Mosta {
  final String uid;
  Mosta({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;
  UserData(
      {required this.name,
      required this.strength,
      required this.sugars,
      required this.uid});
}
