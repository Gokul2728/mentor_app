class LevelMarks {
  String level;
  String marks;

  LevelMarks({required this.level, required this.marks});

  factory LevelMarks.fromJson(Map<String, dynamic> json) {
    return LevelMarks(
      level: json['level'],
      marks: json['marks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'marks': marks,
    };
  }
}

//
class PlacementMarks {
  String level;
  String marks;

  PlacementMarks({required this.level, required this.marks});

  factory PlacementMarks.fromJson(Map<String, dynamic> json) {
    return PlacementMarks(
      level: json['level'],
      marks: json['marks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'marks': marks,
    };
  }
}
