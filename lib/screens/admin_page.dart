import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../responsive.dart';
import 'profile_page.dart';

/// Main admin dashboard page that displays user profiles(can add user also)
class AdminPage extends StatefulWidget {
  /// Creates an AdminPage with the given title
  const AdminPage({super.key, required this.title});

  /// Title displayed in the app bar
  final String title;

  @override
  State<AdminPage> createState() => _AdminPageState();
}

/// State class for AdminPage
class _AdminPageState extends State<AdminPage> {
  /// List of user names to display
  List<String> users = ['Naveed', 'Yasindu'];

  @override
  /// Initializes the state and loads saved users
  void initState() {
    super.initState();
    _loadUsers();
  }

  /// Loads saved users from shared preferences
  //Merges default users with any previously saved users
  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsers = prefs.getStringList('users') ?? [];
    final allUsers = {...users, ...savedUsers}.toList();
    setState(() {
      users = allUsers;
    });
  }

  /// Saves the current list of users to shared preferences
  Future<void> _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('users', users);
  }

  /// Adds a new user to the list and saves to storage
  Future<void> _addUser(String name) async {
    setState(() {
      users.add(name);
    });
    await _saveUsers();
  }

  /// Shows a dialog to add a new user(as new)
  void _showAddUserDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            "Add New User",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "User Name",
              labelStyle: const TextStyle(color: Colors.white70),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                final name = controller.text.trim();
                if (name.isNotEmpty) {
                  _addUser(name);
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  /// admin dashboard UI
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.grey[900],
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: Responsive.getGradientDecoration(),
        child: Padding(
          padding: EdgeInsets.all(Responsive.getPadding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Users',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: Text(
                      '${users.length} users',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.getCrossAxisCount(context),
                    crossAxisSpacing: Responsive.getSpacing(context),
                    mainAxisSpacing: Responsive.getSpacing(context),
                    childAspectRatio: Responsive.getChildAspectRatio(context),
                  ),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return UserProfile(name: users[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddUserDialog,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}

/// Widget(user profile card)
class UserProfile extends StatelessWidget {
  /// Creates a UserProfile with the given name
  const UserProfile({super.key, required this.name});

  final String name;

  @override
  /// user profile card ui(user avatar and name)
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(name: name)),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[800]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
