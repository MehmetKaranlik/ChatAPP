import 'package:get/get.dart';

class IsSearchedController extends GetxController {
  final _searched = true.obs;
  bool get isSearched => _searched.value;
  set isSearched(bool isSearched) => _searched.value = isSearched;
  void changeIsSearched() {
    if (isSearched == true) {
      isSearched = !isSearched;
    } else {
      isSearched = isSearched;
    }
  }
}
