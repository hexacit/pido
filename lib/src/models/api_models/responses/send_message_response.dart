import 'dart:convert';

import '../../../models/api_models/base_response.dart';
import '../../../models/sub_models/message.dart';

SendMessageResponse messagesResponseFromJson(String str) =>
    SendMessageResponse.fromJson(json.decode(str));

String messagesResponseToJson(SendMessageResponse data) =>
    json.encode(data.toJson());

class SendMessageResponse extends BaseResponse {
  SendMessageResponse({
    status,
    code,
    message,
    this.chatMessage,
  }) : super(status: status, code: code, message: message);

  ChatMessage? chatMessage;

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) =>
      SendMessageResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        chatMessage: ChatMessage.fromJson(json["chatMessage"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "messages": chatMessage!.toJson(),
      };
}
class ChatMessage {
  int? chatId;
  int? senderId;
  String? text;
  int? type;
  String? latitude;
  String? longitude;
  String? createdAt;
  int? id;

  ChatMessage(
      {this.chatId,
      this.senderId,
      this.text,
      this.type,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.id});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    senderId = json['sender_id'];
    text = json['text'];
    type = json['type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    data['sender_id'] = this.senderId;
    data['text'] = this.text;
    data['type'] = this.type;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
