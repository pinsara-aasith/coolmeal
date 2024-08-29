class UserProfile {
  final String? name;
  final double? height;
  final double? weight;
  final double? age;
  final String? gender;
  final String? healthConcerns;
  final String? allergies;
  final String? fitnessGoals;
  final String? exerciseLevel;

  UserProfile({
    required this.name,
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.healthConcerns,
    required this.allergies,
    required this.fitnessGoals,
    required this.exerciseLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'height': height,
      'weight': weight,
      'age': age,
      'gender': gender,
      'healthConcerns': healthConcerns,
      'allergies': allergies,
      'fitnessGoals': fitnessGoals,
      'exerciseLevel': exerciseLevel,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'],
      height: double.parse(map['height'].toString()),
      weight: double.parse(map['weight'].toString()),
      age: double.parse(map['age'].toString()),
      gender: map['gender'],
      healthConcerns: map['healthConcerns'],
      allergies: map['allergies'],
      fitnessGoals: map['fitnessGoals'],
      exerciseLevel: map['exerciseLevel'],
    );
  }
}
