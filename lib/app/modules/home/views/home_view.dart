import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/app/modules/home/calls/views/calls_view.dart';
import 'package:whatsapp_clone/app/modules/home/chat/views/chat_view.dart';
import 'package:whatsapp_clone/app/modules/home/group/views/group_view.dart';
import 'package:whatsapp_clone/app/modules/home/status/views/status_view.dart';
import '../controllers/home_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  final HomeController controller = Get.put(HomeController());
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Update the UI when the tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> dialPhoneNumber(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Could not dial $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 119, 83),
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  controller.filterContent(query); // Trigger the filtering
                },
              )
            : const Text(
                'Whatsapp',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white70),
              ),
        centerTitle: false,
        actions: [
          if (isSearching)
            IconButton(
              onPressed: () {
                setState(() {
                  isSearching = false;
                  searchController.clear();
                  controller.clearFilter();
                });
              },
              icon: const Icon(
                FontAwesomeIcons.times,
                color: Colors.white70,
                size: 18,
              ),
            )
          else
            IconButton(
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
              icon: const Icon(
                FontAwesomeIcons.search,
                color: Colors.white70,
                size: 18,
              ),
            ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () {
              controller.openCamera(); // Open camera functionality
            },
            icon: const Icon(
              FontAwesomeIcons.camera,
              color: Colors.white70,
              size: 18,
            ),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () {
              print("More vertical icon pressed");
            },
            icon: const Icon(
              FontAwesomeIcons.ellipsisVertical,
              color: Colors.white70,
              size: 18,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(FontAwesomeIcons.userGroup, size: 18),
              text: "Group",
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.solidMessage, size: 18),
              text: "Chats",
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.gear, size: 18),
              text: "Status",
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.phone, size: 18),
              text: "Calls",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const BouncingScrollPhysics(),
        children: [
          GroupView(),
          ChatView(),
          StatusView(),
          CallsView(),
        ],
      ),
      
      floatingActionButton: _tabController.index == 2 // Show FABs only for Status tab
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    print('Add Button Pressed');
                  },
                  child: const Icon(Icons.add, color: Colors.white70),
                  backgroundColor: const Color.fromARGB(255, 45, 119, 83),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () {
                    controller.openCamera(); // Open camera
                  },
                  child: const Icon(Icons.camera_alt, color: Colors.white70),
                  backgroundColor: const Color.fromARGB(255, 45, 119, 83),
                ),
              ],
            )
          : _tabController.index == 0 // Show FAB for groupadd tab
            ? FloatingActionButton(
                onPressed: () {
                  print('Group Add Button Pressed');
                },
                child: const Icon(Icons.group_add, color: Colors.white70),
                backgroundColor: const Color.fromARGB(255, 45, 119, 83),
              )
            : _tabController.index == 3 // Show FAB for Calls tab
            ? FloatingActionButton(
                onPressed: () {
                 dialPhoneNumber('7010465822');

                },
                child: const Icon(Icons.add_call, color: Colors.white70),
                backgroundColor: const Color.fromARGB(255, 45, 119, 83),
              )
            : null,
    );
  }
}
