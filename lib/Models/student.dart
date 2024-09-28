class Student {
  String rollNo;
  String name;

  Student({required this.rollNo, required this.name});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      rollNo: json['roll_no'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roll_no': rollNo,
      'name': name,
    };
  }
}
