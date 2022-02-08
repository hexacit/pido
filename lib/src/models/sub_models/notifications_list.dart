import 'package:pido/src/models/sub_models/notification.dart';

class NotificationsList {
  NotificationsList({

    this.results,
    this.isMore,
  });


  List<NotificationItem>? results;
  bool? isMore;

  factory NotificationsList.fromJson(Map<String, dynamic> json) => NotificationsList(

    results: List<NotificationItem>.from(json["items"].map((x) => NotificationItem.fromJson(x))),
    isMore: json["is_more"],
  );


}
