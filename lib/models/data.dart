class Data {
  int? age;
  int? height;
  double? weight;
  int? gender;
  int? cholesterol;
  int? gluc;
  int? bp_cat;
  bool? smoke;
  bool? alco;
  bool? active;

  Data({
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.cholesterol,
    required this.gluc,
    required this.bp_cat,
    required this.smoke,
    required this.alco,
    required this.active,
  });

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
      'cholesterol': cholesterol,
      'gluc': gluc,
      'bp_cat': bp_cat,
      'smoke': smoke == true ? 1 : 0,
      'alco': alco == true ? 1 : 0,
      'active': active == true ? 1 : 0,
    };
  }


}
