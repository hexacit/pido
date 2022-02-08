import 'package:image_picker/image_picker.dart';

// ||... File For interfaces inside the app ...||

// interface for select image dialog.
abstract class OnImageSelectedListener {
  void selectedImage(PickedFile image);
}

// interface for filter my orders.
//abstract class OnFilterMyOrdersListener {
//  void onFiltered(int orderType, int orderStatus);
//}

// interface for select city dialog.
//abstract class OnCitySelectedListener {
//  void selectedCity(City city);
//}
