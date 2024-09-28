class BreakPoints {
  String bpTitle;
  String points;
  String date;

  BreakPoints(
      {required this.bpTitle, required this.points, required this.date});

  factory BreakPoints.fromJson(Map<String, dynamic> json) {
    return BreakPoints(
      bpTitle: json['bp_title'],
      points: json['points'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bp_title': bpTitle,
      'points': points,
      'date': date,
    };
  }
}
