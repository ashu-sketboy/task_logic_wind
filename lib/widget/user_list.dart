import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//screens
import 'package:task_login_wing/screen/profile_screen.dart';

// models
import 'package:task_login_wing/model/user.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<User>>(context);

    return users.isEmpty
        ? const Center(
            child: Text('NO Data'),
          )
        : ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      otherUser: users[index],
                    ),
                  ),
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image(
                    image: NetworkImage(users[index].image),
                  ),
                ),
                title: Text(users[index].name),
              ),
            ),
            itemCount: users.length,
          );
  }
}
