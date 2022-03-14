import 'package:flutter/material.dart';
import 'package:form_example/model/user.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({Key? key, required this.userInfo}) : super(key: key);

  User userInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(
                userInfo.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(userInfo.story),
              leading: const Icon(Icons.person, color: Colors.black),
              trailing: Text(userInfo.country),
            ),
            ListTile(
              title: Text(
                userInfo.phone,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(Icons.phone, color: Colors.black),
            ),
            // Проверка на наличие данных
            if (userInfo.email.isNotEmpty)
              ListTile(
                title: Text(
                  userInfo.email,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                leading:
                    Icon(Icons.alternate_email_outlined, color: Colors.black),
              ),
          ],
        ),
      ),
    );
  }
}
