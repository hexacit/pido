class Message {
  int? id;
  int? chatId;
  int? senderId;
  String? text;
  int? type;
  int? durationTime;
  String? filename;
  String? latitude;
  String? longitude;
  int? seen;
  String? createdAt;

  Message(
      {this.id,
      this.chatId,
      this.senderId,
      this.text,
      this.type,
      this.durationTime,
      this.filename,
      this.latitude,
      this.longitude,
      this.seen,
      this.createdAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chat_id'];
    senderId = json['sender_id'];
    text = json['text'];
    type = json['type'];
    durationTime = json['duration_time'];
    filename = json['filename'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    seen = json['seen'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat_id'] = this.chatId;
    data['sender_id'] = this.senderId;
    data['text'] = this.text;
    data['type'] = this.type;
    data['duration_time'] = this.durationTime;
    data['filename'] = this.filename;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['seen'] = this.seen;
    data['created_at'] = this.createdAt;
    return data;
  }
}