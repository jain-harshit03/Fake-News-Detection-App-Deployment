class ModelResult {
  String? auth;
  String? sentiment;

  ModelResult({this.auth, this.sentiment});

  ModelResult.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
    sentiment = json['sentiment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth'] = this.auth;
    data['sentiment'] = this.sentiment;
    return data;
  }
}