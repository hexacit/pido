import '../notifiers/app_notifiers.dart';

class NavigationService {
  AppNotifiers? _appNotifiers;
  static NavigationService? _instance;

  NavigationService._();
  // ||.. singleton pattern ..||
  static NavigationService? get instance {
    if (_instance != null) return _instance;
    return _instance = NavigationService._();
  }

  // init navigation service.
  void init(AppNotifiers? appNotifiers) {
    this._appNotifiers = appNotifiers;
  }

  Future<dynamic> pushNamed(String routeName, {Object? arguments}) async {
    return _appNotifiers!.navigationKey!.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments}) async {
    return _appNotifiers!.navigationKey!.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }
}
