class StudentProfile {
  String rollNo;
  String name;
  String year;
  String sem;
  String dept;
  String role;
  String profileImg;

  StudentProfile({
    required this.rollNo,
    required this.name,
    required this.year,
    required this.sem,
    required this.dept,
    required this.role,
    required this.profileImg,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      rollNo: json['roll_no'] ?? '',
      name: json['name'] ?? '',
      year: json['year'] ?? '',
      sem: json['sem'] ?? '',
      dept: json['dept'] ?? '',
      role: json['role'] ?? '',
      profileImg: json['profile_img'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roll_no': rollNo,
      'name': name,
      'year': year,
      'sem': sem,
      'dept': dept,
      'role': role,
      'profile_img': profileImg,
    };
  }
}
