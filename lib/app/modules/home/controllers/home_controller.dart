import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';  // Add this import
import '../../../../userdatamodel.dart';
import 'package:permission_handler/permission_handler.dart';


class HomeController extends GetxController {
  var tabindex = 0;

  // Observable list of all items (Datum objects)
  var users = <Datum>[].obs;
  var filteredItems = <Datum>[].obs;

  // Observable for storing the captured image
  var capturedImage = Rxn<File>();

  // Handle tab changes
  void changetabindex(int index) {
    tabindex = index;
    update();
  }

  // Search logic: Filter content based on query
  void filterContent(String query) {
    if (query.isEmpty) {
      filteredItems.value = users; // Show all items if query is empty
    } else {
      filteredItems.value = users
          .where((item) =>
              item.firstName.toLowerCase().contains(query.toLowerCase()) ||
              item.lastName.toLowerCase().contains(query.toLowerCase()) ||
              item.email.toLowerCase().contains(query.toLowerCase())) 
          .toList();
    }
  }

  // Clear search results
  void clearFilter() {
    filteredItems.value = users;
  }

  // Increment counter example
  final count = 0.obs;

  void increment() => count.value++;

  @override
  void onInit() {
    super.onInit();

    // Initialize data (replace with actual data)
    users.value = [
      Datum(
          id: 1,
          email: 'alice@example.com',
          firstName: 'Alice',
          lastName: 'Smith',
          avatar: ''),
      Datum(
          id: 2,
          email: 'bob@example.com',
          firstName: 'Bob',
          lastName: 'Brown',
          avatar: ''),
      Datum(
          id: 3,
          email: 'charlie@example.com',
          firstName: 'Charlie',
          lastName: 'Davis',
          avatar: ''),
      Datum(
          id: 4,
          email: 'david@example.com',
          firstName: 'David',
          lastName: 'Wilson',
          avatar: ''),
      Datum(
          id: 5,
          email: 'eve@example.com',
          firstName: 'Eve',
          lastName: 'Johnson',
          avatar: ''),
    ];

    // Initialize filteredItems to show all items initially
    filteredItems.value = users;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Open camera and capture image
  Future<void> openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      capturedImage.value = File(pickedFile.path); // Update the captured image
    } else {
      print('No image selected.');
    }
  }

  // Launch URL
Future<void> launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunch(uri.toString())) {
    await launch(uri.toString());
  } else {
    print("Could not launch $url");
  }
}


  // Dial a phone number
  // Method to dial phone number using url_launcher
  Future<void> dialPhoneNumber(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Could not dial $phoneNumber';
    }
  }

Future<void> makePhoneCall(String phoneNumber) async {
  if (await Permission.phone.request().isGranted) {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      print('Could not dial $phoneNumber');
    }
  } else {
    print('Phone permission not granted.');
  }
}

}
