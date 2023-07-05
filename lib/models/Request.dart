class Request {
  var id;
  var createdBy;
  var rate;
  var performer;
  var video;
  var views;
  var title;
  var description;
  var updatedBy;
  var performed;
  var createdAt;
  var updatedAt;

  Request(
      this.id,
      this.createdBy,
      this.rate,
      this.performer,
      this.video,
      this.views,
      this.title,
      this.description,
      this.updatedBy,
      this.performed,
      this.createdAt,
      this.updatedAt);

  Request.fromJson(Map<dynamic, dynamic> json) {
    id = json['_id'];
    createdBy = json['createdBy'];
    rate = json['rate'];
    performer = json['performer'];
    video = json['video'];
    views = json['views'];
    title = json['title'];
    description = json['description'];
    updatedBy = json['updatedBy'];
    performed = json['performed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<dynamic, dynamic> toJson() => {
        'id': id,
        'createdBy': createdBy,
        'rate': rate,
        'performer': performer,
        'video': video,
        'views': views,
        'title': title,
        'description': description,
        'updatedBy': updatedBy,
        'performed': performed,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
