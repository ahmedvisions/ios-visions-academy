import 'package:shared_preferences/shared_preferences.dart';

storeOnboardInfo() async {
  print("Shared pref called");
  int isViewed = 0;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('onBoard', isViewed);
  print(prefs.getInt('onBoard'));
}