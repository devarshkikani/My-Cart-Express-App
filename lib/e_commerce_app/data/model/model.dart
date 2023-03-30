class MyModel {
  MyModel({this.id, this.title, this.body});
  MyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    title = json['title'] as String;
    body = json['body'] as String;
  }
  int? id;
  String? title;
  String? body;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = title;
    data['body'] = body;
    return data;
  }
}
