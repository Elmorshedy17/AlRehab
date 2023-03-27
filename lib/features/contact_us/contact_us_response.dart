

class GetContactUsInfoResponse {
  int? status;
  String? message;
  Data? data;
  dynamic error;
  String? errorMsg;

  GetContactUsInfoResponse.makeError({this.error, this.errorMsg});
  GetContactUsInfoResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  GetContactUsInfoResponse({this.status, this.message, this.data});

  GetContactUsInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Info? info;
  List<SocialMedia>? socialMedia;


  Data({this.info,this.socialMedia});

  Data.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['social_media'] != null) {
      socialMedia = <SocialMedia>[];
      json['social_media'].forEach((v) {
        socialMedia!.add(new SocialMedia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.socialMedia != null) {
      data['social_media'] = this.socialMedia!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  String? email;
  String? phone;
  String? whatsapp;
  String? address;
  String? lat;
  String? lng;

  Info(
      {this.email,
        this.phone,
        this.whatsapp,
        this.address,
        this.lat,
        this.lng});

  Info.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['whatsapp'] = this.whatsapp;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class SocialMedia {
  int? id;
  String? icon;
  String? link;

  SocialMedia({this.id, this.icon, this.link});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['link'] = this.link;
    return data;
  }
}