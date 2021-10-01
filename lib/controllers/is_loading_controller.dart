import 'package:get/get.dart';

class IsLoadingController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool isLoading) => _isLoading.value = isLoading;
  void changeIsLoading() {
    isLoading = !isLoading;
  }
}
