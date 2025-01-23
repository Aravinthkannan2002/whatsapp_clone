import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/status_controller.dart';
import 'package:image_picker/image_picker.dart';

class StatusView extends GetView<StatusController> {
  const StatusView({super.key});

  @override
  Widget build(BuildContext context) {
      Get.put(StatusController()); 
    return Scaffold(
      body: GetBuilder<StatusController>(
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: Stack(
                  children: [
                    CircleAvatar(
                      radius: 24, // Outer CircleAvatar size
                      // You can add the captured image here if desired
                      backgroundImage: controller.capturedImage.value != null
                          ? FileImage(controller.capturedImage.value!)
                          : null,
                      child: controller.capturedImage.value == null
                          ? Icon(Icons.person,color: Colors.black,) // Placeholder icon if no image
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 10, // Smaller CircleAvatar for the icon
                        backgroundColor: Colors.green, // Background color for the icon
                        child: Icon(
                          Icons.add, // Add icon
                          size: 12, // Adjust icon size
                          color: Colors.white, // Icon color
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  "My Status",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Tap to add status update"),
                onTap: () {
                  controller.openCamera(); // Open camera functionality
                },
              ),
              // You can add other widgets here as needed
            ],
          );
        }
      ),
    );
  }
}
