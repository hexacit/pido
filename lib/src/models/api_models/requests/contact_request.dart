import 'dart:convert';

ContactRequest contactRequestFromJson(String str) =>
    ContactRequest.fromJson(json.decode(str));

String contactRequestToJson(ContactRequest data) => json.encode(data.toJson());

class ContactRequest {
  ContactRequest({
   this.title,
    this.message,
  });

  String? title;
 
  String? message;

  factory ContactRequest.fromJson(Map<String, dynamic> json) => ContactRequest(
      
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        
        "title": title,
        "message": message,
      };
}
