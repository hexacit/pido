import 'dart:convert';

import 'package:pido/src/models/sub_models/user.dart';

import '../../../models/api_models/base_response.dart';
import '../../../models/sub_models/message.dart';
ChatListResponse messagesResponseFromJson(String str) =>
    ChatListResponse.fromJson(json.decode(str));

String messagesResponseToJson(ChatListResponse data) =>
    json.encode(data.toJson());

class ChatListResponse extends BaseResponse {
  ChatListResponse({
    status,
    code,
    message,
    this.chats,
  }) : super(status: status, code: code, message: message);

  Chats? chats;

  factory ChatListResponse.fromJson(Map<String, dynamic> json) =>
      ChatListResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        chats: Chats.fromJson(json["chats"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "chats": chats!.toJson(),
      };
}
class Chats {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Chats(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Chats.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data:List<Data>.from( json['data'].map((v)=>Data.fromJson(v)));
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
   
    
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? type;
  String? lastUsed;
  String? createdAt;
  User? user;
  LastMessage? lastMessage;

  Data(
      {this.id,
      this.userId,
      this.type,
      this.lastUsed,
      this.createdAt,
      this.user,
      this.lastMessage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    lastUsed = json['last_used'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    lastMessage = json['last_message'] != null
        ? new LastMessage.fromJson(json['last_message'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['last_used'] = this.lastUsed;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage!.toJson();
    }
    return data;
  }
}
class LastMessage {
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

  LastMessage(
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

  LastMessage.fromJson(Map<String, dynamic> json) {
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
