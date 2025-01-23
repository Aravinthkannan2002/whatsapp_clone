import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/home/userchatview/views/userchatview_view.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/chat_controller.dart';

class ChatView extends StatelessWidget {
  // Retrieve the ChatController instance
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ChatController>(
        builder: (controller) {
          return Obx(() {
            if (controller.isLoading.value) {
              // Show Shimmer Effect While Loading
              return ListView.builder(
                itemCount: 8, // Number of shimmer placeholders
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                      ),
                      title: Container(
                        height: 15,
                        color: Colors.grey[300],
                      ),
                      subtitle: Container(
                        height: 10,
                        margin: const EdgeInsets.only(top: 8),
                        color: Colors.grey[300],
                      ),
                    ),
                  );
                },
              );
            }
                    
            // Show Actual Data Once Loaded
            if (controller.users.isEmpty) {
              return Center(child: Text('No users found.'));
            }
                    
            return ListView.builder(
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                var user = controller.users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar), // User avatar
                  ),
                  title: Text('${user.firstName} ${user.lastName}',style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(user.email),
                  onTap: () {
                    Get.to(UserchatviewView(user: user)); // Pass the user object
                  },
                );
              },
            );
          });
        },
      ),
    );
  }
}