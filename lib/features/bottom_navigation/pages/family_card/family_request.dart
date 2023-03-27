class FamilyCartRequest {
  String? cardId,civilId;
  FamilyCartRequest({this.cardId,this.civilId});
  FamilyCartRequest.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    civilId = json['civil_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_id'] = cardId;
    data['civil_id'] = civilId;
    return data;
  }
}

