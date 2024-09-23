class TipModel {
  final String id;
  final String tip;

  TipModel({required this.id, required this.tip});

  factory TipModel.fromJson(Map<String, dynamic> json, String id) {
    return TipModel(
      id: id,
      tip: json['tip'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tip': tip,
    };
  }
}
