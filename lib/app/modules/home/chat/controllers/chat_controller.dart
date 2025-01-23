import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone/userdatamodel.dart';
import 'dart:async';

class ChatController extends GetxController {
  var users = <Datum>[].obs;
  var filteredUsers = <Datum>[].obs; // To store filtered users
  var isLoading = false.obs;
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    print("===========Chat Controller calling==================");
    fetchUserData();
  }

  // Fetch user data from the API
  Future<void> fetchUserData() async {
    try {
      isLoading(true); // Set loading state to true
      final response = await http.get(Uri.parse('https://reqres.in/api/users?page=1'));
      print(response.body.toString());

      if (response.statusCode == 200) {
        // Parse response using model
        final fetchedData = fetchUserDataFromJson(response.body);
        users.assignAll(fetchedData.data); // Assign user data to the users list
        filteredUsers.assignAll(fetchedData.data); // Initialize filtered list with all users
      } else {
        Get.snackbar('Error', 'Failed to load user data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading(false);
    }
  }

  // Filter content based on search query
  void filterContent(String query) {
  // Cancel previous debounce if any
  if (_debounce?.isActive ?? false) _debounce?.cancel();

  // Start a new debounce timer
  _debounce = Timer(const Duration(milliseconds: 500), () {
    // If query is empty, show all users
    if (query.isEmpty) {
      filteredUsers.assignAll(users); // Show all users when the search query is empty
    } else {
      // Filter users based on the search query
      filteredUsers.assignAll(
        users.where((user) =>
            user.firstName.toLowerCase().contains(query.toLowerCase()) ||
            user.lastName.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  });
}

}
