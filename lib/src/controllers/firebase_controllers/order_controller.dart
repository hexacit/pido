import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/firebase_models/order.dart';
import '../../utils/constants.dart';

class OrderController {
  static OrderController? _instance;
  late FirebaseFirestore _db;
  // ||.. private constructor ..||
  OrderController._() {
    _db = FirebaseFirestore.instance;
  }

  // ||.. singleton pattern ..||
  static OrderController? get instance {
    if (_instance != null) return _instance;
    return _instance = OrderController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  // create new order.
  Future<void> createOrder(Order order) async {
    await _db
        .collection(Constants.FIREBASE_COLLECTIONS_ORDERS)
        .doc(order.id!)
        .set(order.toJson());
  }

  // delete order.
  Future<void> deleteOrder(String orderId) async {
    await _db
        .collection(Constants.FIREBASE_COLLECTIONS_ORDERS)
        .doc(orderId)
        .delete();
  }

  // update order.
  Future<void> updateOrder(String orderId, Order order) async {
    await _db
        .collection(Constants.FIREBASE_COLLECTIONS_ORDERS)
        .doc(orderId)
        .update(order.toJson());
  }

  // get order by id.
  // Future<Order> getOrder(String orderId) async {
  //   DocumentSnapshot documentSnapshot = await _db
  //       .collection(Constants.FIREBASE_COLLECTIONS_ORDERS)
  //       .doc(orderId)
  //       .get();
  //   // return Order.fromJson(documentSnapshot.data())
  //   //   ..id = documentSnapshot.id;
  // }

  // listen to order.
  Stream<DocumentSnapshot> listenToOrder(String orderId) {
    return _db
        .collection(Constants.FIREBASE_COLLECTIONS_ORDERS)
        .doc(orderId)
        .snapshots();
  }
}
