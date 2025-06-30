import 'dart:io';
import 'package:chamada/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../service/user_session.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = UserSession.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Meu Perfil')),
        body: Center(child: Text('Usuário não encontrado.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Meu Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: user.imagemPath != null
                    ? FileImage(File(user.imagemPath!))
                    : AssetImage('assets/images/placeholder.png')
                as ImageProvider,
              ),
            ),
            SizedBox(height: 20),
            Text(
              user.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Email: ${user.email}'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                UserSession.currentUser = null;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
              child: Text('Sair'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
