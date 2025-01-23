import 'package:get/get.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class UserchatviewController extends GetxController {
  // Observable list for chat messages
  var messages = <ChatMessage>[].obs;
  

  // Current user of the chat (replace with appropriate user details)
  final ChatUser currentUser = ChatUser(id: '1', firstName: 'Aravinth');

  @override
  void onInit() {
    super.onInit();
    // Initialize any necessary data here
       update();
  }

  @override
  void onReady() {
    super.onReady();
    // Add any actions to be taken when the controller is ready
  }

  @override
  void onClose() {
    super.onClose();
    // Clean up resources when the controller is closed
  }

  // Method to add a message to the chat
  void addMessage(ChatMessage message) {
    messages.add(message);
 update();
  }
  
}
