import 'package:flutter/material.dart';
import 'package:flutter_final_project_title_eventify/screens/notification_page.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = ['Going', 'Saved', 'Suggested'];
  final List<String> interests = ['Music', 'Tech', 'Sports', 'Art', 'Education', 'Health'];
  List<String> selectedInterests = []; // Tracks selected interest tags

  // Calendar setup
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Placeholder event dates
  final Map<DateTime, List<String>> _events = {
    DateTime.utc(2024, 6, 20): ['Tech Conference'],
    DateTime.utc(2024, 6, 21): ['Music Festival', 'Health Webinar'],
    DateTime.utc(2024, 6, 22): ['Sports Event'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventify'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upcoming Events Section
            _buildSectionTitle('Upcoming Events'),
            _buildCategoryTabs(),

            const SizedBox(height: 20),

            // Your Interests Section
            _buildSectionTitle('Your Interests'),
            _buildInterestTags(),

            const SizedBox(height: 20),

            // Calendar Section
            _buildSectionTitle('Event Calendar'),
            _buildEventCalendar(),
          ],
        ),
      ),
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Category Tabs for Upcoming Events
  Widget _buildCategoryTabs() {
    return DefaultTabController(
      length: categories.length,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: categories.map((category) => Tab(text: category)).toList(),
          ),
          SizedBox(
            height: 200,
            child: TabBarView(
              children: categories.map((category) {
                return Center(
                  child: Text(
                    '$category Events (Coming soon)',
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Interest Tags Widget
  Widget _buildInterestTags() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: interests.map((interest) {
        final isSelected = selectedInterests.contains(interest);
        return FilterChip(
          label: Text(interest),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                selectedInterests.add(interest);
              } else {
                selectedInterests.remove(interest);
              }
            });
          },
          selectedColor: Colors.blue.shade100,
          checkmarkColor: Colors.blue,
        );
      }).toList(),
    );
  }

  // Event Calendar Widget
  Widget _buildEventCalendar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TableCalendar(
        focusedDay: _focusedDay,
        firstDay: DateTime.utc(2023, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        eventLoader: (day) => _events[day] ?? [],
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          selectedDecoration: BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
        ),
      ),
    );
  }
}


