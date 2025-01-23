import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import '../../../../../userdatamodel.dart';
import '../controllers/userchatview_controller.dart';

class UserchatviewView extends GetView<UserchatviewController> {
  final Datum user;
  const UserchatviewView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserchatviewController controller = Get.put(UserchatviewController());
    ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: const Color.fromARGB(255, 45, 119, 83),
        leadingWidth: 25,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(user.avatar),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Last Seen Today 12:00 PM",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Icon(Icons.phone, color: Colors.white),
          SizedBox(width: 14),
          Icon(Icons.attach_file_sharp, color: Colors.white),
          SizedBox(width: 14),
          Icon(Icons.more_vert, color: Colors.white),
          SizedBox(width: 14),
        ],
      ),
      body: GetBuilder<UserchatviewController>(
        builder: (Controller) {
          // Scroll to the bottom on new message
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (controller.messages.isNotEmpty) {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });

          return DashChat(
            currentUser: ChatUser(id: "1"),
            messages: controller.messages,
            onSend: (ChatMessage message) {
              controller.addMessage(message);
            },
            inputOptions: InputOptions(
              sendOnEnter: true,
              inputDecoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              ),
              sendButtonBuilder: (onSend) => IconButton(
                icon: Icon(Icons.send, color:  const Color.fromARGB(255, 45, 119, 83),),
                onPressed: onSend,
              ),
              // Add custom emoji or attachment button separately
            ),
            messageOptions: MessageOptions(
            //  containerColor: Colors.grey[300],
              currentUserContainerColor:  const Color.fromARGB(255, 45, 119, 83),
             // currentUserTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          //  controller: scrollController,
          );
        },
      ),
    );
  }
}
