import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final List<String> interests = ["Music", "Art", "Tech", "Sports"];
  final List<String> achievements = [
    "Top Participant in Hackathon 2024",
    "Attended 50+ Events",
    "Community Helper Badge"
  ];
  final List<String> recentActivities = [
    "Registered for 'Tech Talk 2024'",
    "Liked 'Art Festival 2023'",
    "Attended 'Music Fest 2023'"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Your Profile"),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/background.jpg',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Info Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/profile_picture.jpg'),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "John Doe",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text("johndoe@example.com"),
                        ],
                      ),
                    ],
                  ),
                ),
                // Counter Section
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCounter("Interests", interests.length),
                      Container(width: 1, height: 50, color: Colors.grey),
                      _buildCounter("Registered", 15),
                      Container(width: 1, height: 50, color: Colors.grey),
                      _buildCounter("Interested", 25),
                    ],
                  ),
                ),
                // About Me Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About Me",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "A passionate individual who loves attending events and exploring new interests.",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                // Interests Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Interests",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: interests
                            .map((interest) => Chip(
                          label: Text(interest),
                        ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                // Achievements Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Achievements",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      ...achievements.map((achievement) => ListTile(
                        leading: const Icon(Icons.star, color: Colors.amber),
                        title: Text(achievement),
                      )),
                    ],
                  ),
                ),
                // Recent Activities Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recent Activities",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      ...recentActivities.map((activity) => ListTile(
                        leading: const Icon(Icons.history, color: Colors.blue),
                        title: Text(activity),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounter(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$count",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
