class ProfitsRequest {
  String? cardId,civilId;
  ProfitsRequest({this.cardId,this.civilId});
  ProfitsRequest.fromJson(Map<String, dynamic> json) {
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

