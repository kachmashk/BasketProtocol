import 'package:basketprotocol/core/services/auth_service.dart';
import 'package:flutter/material.dart';

class MatchSetupPage extends StatefulWidget {
  const MatchSetupPage({Key? key}) : super(key: key);

  @override
  _MatchSetupPageState createState() => _MatchSetupPageState();
}

class _MatchSetupPageState extends State<MatchSetupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('match setup page'),
      ),
      body: Center(
        child: TextButton(
          child: Text('sign out'),
          onPressed: () async {
            await AuthService().signOut();
          },
        ),
      ),
    );
  }
}
