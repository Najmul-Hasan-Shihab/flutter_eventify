import 'dart:convert';
import 'package:flutter_final_project_title_eventify/widgets/category_item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_final_project_title_eventify/screens/home_page.dart';
import 'package:flutter_final_project_title_eventify/screens/notification_page.dart';
import 'package:flutter_final_project_title_eventify/screens/profile_page.dart';
import 'package:flutter_final_project_title_eventify/widgets/event_item.dart';
import 'package:google_fonts/google_fonts.dart';

// Separate widget for ExplorePage content
class ExploreContent extends StatefulWidget {
  const ExploreContent({super.key});

  @override
  State<ExploreContent> createState() => _ExploreContentState();
}

class _ExploreContentState extends State<ExploreContent> {
  List<dynamic> events = [];
  bool isLoading = true;
  bool showMore = false;

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse('https://najmul-hasan-shihab.github.io/event_json_api/event.json'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          events = data['events'];
          isLoading = false;
          print('Number of events: ${events.length}'); // Check the length of events
        });
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Column(
        children: [
          Text(
            "Popular",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xFF232323),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var event in events.take(4)) // Display 4 event items
                  EventItem(event: event),
                // EventItem(),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
      Column(
        children: [
          Text(
            "Hackathons",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xFF232323),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var event in events.skip(4).take(4)) // Display 4 event items
                  EventItem(event: event),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
      Column(
        children: [
          Text(
            "Idea Generation",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xFF232323),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var event in events.skip(8).take(4)) // Display 4 event items
                  EventItem(event: event),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
      Column(
        children: [
          Text(
            "Robotics",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xFF232323),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var event in events.skip(12).take(4)) // Display 4 event items
                  EventItem(event: event),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    ];
    // Your ExplorePage content goes here
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ...children.sublist(0, 3),
            if (showMore) ...children.sublist(3),
            TextButton(
              onPressed: () {
                setState(() {
                  showMore = !showMore;
                });
              },
              child: Text(showMore ? "See Less" : "See More"),
            ),

            SizedBox(height: 30,),

            Text(
              "Search by categories",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color(0xFF232323),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                childAspectRatio: 1.2,// 2 items in each row
              ),
              itemCount: 10, // 10 event items
              itemBuilder: (context, index) {
                final List<String> categoryNames = [
                  "Hackathons",
                  "Idea Generation",
                  "Quiz",
                  "Programming Contests",
                  "Robotics",
                  "Poster Presentation",
                  "Esports",
                  "Project Presentation",
                  "Olympiad",
                  "Development",
                ];
                return CategoryItem(
                  categoryName: categoryNames[index],
                  // imageUrl: "https://example.com/category_image_$index.jpg", // Optional image URL
                ); // Your EventItem widget
              },
              padding: EdgeInsets.all(35),
            ),
            SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int myCurrentIndex = 1; // Set initial index to 0
  List<Widget> pages =  [
    HomePage(),
    ExploreContent(),
    NotificationPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("EVENTIFY!"),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 25,
              offset: const Offset(8, 20))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            // backgroundColor: Colors.transparent,
            selectedItemColor: Colors.redAccent,
            unselectedItemColor: Colors.black,
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Explore"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_outlined),
                  label: "Notification"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "Profile"),
            ],
          ),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
