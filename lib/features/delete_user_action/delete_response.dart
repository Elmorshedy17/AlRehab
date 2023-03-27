class DeleteResponse {
  int? status;
  String? message;

  dynamic error;
  String? errorMsg;

  DeleteResponse.makeError({this.error, this.errorMsg});
  DeleteResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  DeleteResponse({this.status, this.message});

  DeleteResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
