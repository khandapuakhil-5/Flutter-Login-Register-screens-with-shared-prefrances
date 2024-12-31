import 'package:flutter/material.dart';
import 'package:task/Login%20screen.dart';
import 'package:task/main.dart';
class Homescreen extends StatefulWidget {

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  String loggedInEmail = "";

  @override
  void initState() {
    loggedInEmail = sharedPreferences.getString("email")??"";
    bool? data=sharedPreferences.getBool("isUserLogin");
    print("data${data}");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Hello,$loggedInEmail"),
        actions: [
          IconButton(onPressed: ()async{
            await sharedPreferences.clear();
             Navigator.pushAndRemoveUntil(context,
                 MaterialPageRoute(builder: (ctx)=>Loginscreen()), (route) => false);
            showDialog(context: context, builder: (ctx) {
              return AlertDialog(
                title: Text("log out"),
                content: Text("Do you really want to log out"),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("No")),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                    //Navigator.pushAndRemoveUntil(context,
                      //  MaterialPageRoute(builder: (ctx)=>Splashscreen()), (route) => false);

                  }, child: Text("Yes")),
                ],
              );
            });
          },
              icon: Icon(Icons.logout_outlined))


        ],
      ),
    );
  }
}
class UsersListPage extends StatefulWidget {
  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  // List of users
  List<Map<String, dynamic>> users = [];

  // Function to add a user
  void _addUser(String name, String email) {
    setState(() {
      users.add({'id': DateTime.now().toString(), 'name': name, 'email': email});
    });
  }

  // Function to edit a user
  void _editUser(String id, String name, String email) {
    setState(() {
      final index = users.indexWhere((user) => user['id'] == id);
      if (index != -1) {
        users[index]['name'] = name;
        users[index]['email'] = email;
      }
    });
  }

  // Function to delete a user
  void _deleteUser(String id) {
    setState(() {
      users.removeWhere((user) => user['id'] == id);
    });
  }

  // Dialog to add/edit a user
  void _showUserDialog({String? id, String? name, String? email}) {
    final _nameController = TextEditingController(text: name);
    final _emailController = TextEditingController(text: email);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(id == null ? 'Add User' : 'Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final enteredName = _nameController.text;
              final enteredEmail = _emailController.text;

              if (enteredName.isEmpty || enteredEmail.isEmpty) {
                return;
              }

              if (id == null) {
                _addUser(enteredName, enteredEmail);
              } else {
                _editUser(id, enteredName, enteredEmail);
              }

              Navigator.of(ctx).pop();
            },
            child: Text(id == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List CRUD'),
      ),
      body: users.isEmpty
          ? Center(child: Text('No users added yet.'))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, index) {
          final user = users[index];
          return ListTile(
            title: Text(user['name']),
            subtitle: Text(user['email']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _showUserDialog(
                    id: user['id'],
                    name: user['name'],
                    email: user['email'],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteUser(user['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUserDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
