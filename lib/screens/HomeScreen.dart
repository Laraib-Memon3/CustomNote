import 'package:custom_note/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGridView = false; // 👈 track current view

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E7EB),
      appBar: customAppBar(
        "Notes",
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.light_mode, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔍 Search Bar
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search your notes...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Toggle Row (List / Grid icons)
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() => isGridView = false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: !isGridView
                          ? const Color(0xFFEEF2FF) // highlighted background
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ImageIcon(
                      const AssetImage('assets/images/listpurple.png'),
                      color: !isGridView
                          ? const Color(0xFF4F46E5) // purple when active
                          : const Color(0xFF6B7280), // gray when inactive
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                GestureDetector(
                  onTap: () {
                    setState(() => isGridView = true);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isGridView
                          ? const Color(0xFFEEF2FF) // highlighted background
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ImageIcon(
                      const AssetImage('assets/images/gridgray.png'),
                      color: isGridView
                          ? const Color(0xFF4F46E5) // purple when active
                          : const Color(0xFF6B7280), // gray when inactive
                      size: 16,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'Sort',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Color.fromARGB(255, 85, 85, 85),
                  size: 20,
                ),
                const SizedBox(width: 7),
                const Icon(
                  Icons.filter_alt_outlined,
                  color: Color.fromARGB(255, 85, 85, 85),
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Notes Section (List or Grid)
            Expanded(child: isGridView ? _buildGridView() : _buildListView()),
          ],
        ),
      ),
    );
  }

  // List View
  Widget _buildListView() {
    return ListView(
      children: [
        _noteCard(
          title: 'Meeting notes',
          description: 'Discussion around upcoming presentation and deadlines.',
          date: 'Today, 3:45 PM',
          tag: 'Work',
        ),
        _noteCard(
          title: 'Shopping list',
          description: 'Milk, eggs, bread, coffee, vegetables for dinner.',
          date: 'Yesterday',
          tag: 'Personal',
        ),
        _noteCard(
          title: 'Project ideas',
          description: 'New concept: productivity tracker with AI insights.',
          date: 'Nov 24',
          tag: 'Work',
        ),
        _noteCard(
          title: 'Book notes',
          description: 'Key takeaways from Atomic Habits chapter 4.',
          date: 'Nov 22',
          tag: 'Study',
        ),
      ],
    );
  }

  // Grid View
  Widget _buildGridView() {
    final notes = [
      {
        "title": "Meeting notes",
        "description": "Discussion around upcoming presentation...",
        "date": "Today",
        "tag": "Work",
      },
      {
        "title": "Shopping list",
        "description": "Milk, eggs, coffee, vegetables...",
        "date": "Yesterday",
        "tag": "Personal",
      },
      {
        "title": "Project ideas",
        "description": "New app concept productivity tracker...",
        "date": "Nov 24",
        "tag": "Ideas",
      },
      {
        "title": "Book notes",
        "description": "Notes from Atomic Habits...",
        "date": "Nov 23",
        "tag": "Study",
      },
      {
        "title": "Travel plans",
        "description": "Hotel booking, itinerary...",
        "date": "Nov 20",
        "tag": "Travel",
      },
      {
        "title": "Recipe collection",
        "description": "Favorite recipes cooking notes...",
        "date": "Nov 18",
        "tag": "Food",
      },
    ];

    return GridView.builder(
      itemCount: notes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        return _noteCard(
          title: notes[index]["title"]!,
          description: notes[index]["description"]!,
          date: notes[index]["date"]!,
          tag: notes[index]["tag"]!,
        );
      },
    );
  }

  // Note Card Widget
  Widget _noteCard({
    required String title,
    required String description,
    required String date,
    required String tag,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4F46E5).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    color: Color(0xFF4F46E5),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
