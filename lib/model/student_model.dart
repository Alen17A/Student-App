class StudentModel {
  int? rollno;
  final String name;
  final int age;
  final String std;
  final String division;
  final String? imagePath;

  StudentModel({
    this.rollno,
    required this.name,
    required this.age,
    required this.std,
    required this.division,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    final map = {
      "name": name,
      "age": age,
      "std": std,
      "division": division,
      "imagePath": imagePath,
    };

    if (rollno != null) {
      map['rollno'] = rollno;
    }

    return map;
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      rollno: map['rollno'],
      name: map['name'],
      age: map['age'],
      std: map['std'],
      division: map['division'],
      imagePath: map['imagePath'],
    );
  }
}
