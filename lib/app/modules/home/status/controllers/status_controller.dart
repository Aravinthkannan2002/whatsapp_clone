import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StatusController extends GetxController {
  var capturedImage = Rxn<File>(); // Holds the captured image
  final count = 0.obs; // Sample reactive counter (could be used for other purposes)

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method to increment the counter (if required)
  void increment() => count.value++;

  // Method to open the camera and capture an image
  Future<void> openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      capturedImage.value = File(pickedFile.path); // Update captured image
    } else {
      print('No image selected.');
    }
    update();
  }
}
