import 'package:basketprotocol/core/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class MatchSetupPage extends StatefulWidget {
  const MatchSetupPage({Key? key}) : super(key: key);

  @override
  _MatchSetupPageState createState() => _MatchSetupPageState();
}

class _MatchSetupPageState extends State<MatchSetupPage>
    with SingleTickerProviderStateMixin {
  var _isLoading = false;
  var _tabController;
  var _user;

  void signOut() async {
    setState(() => _isLoading = true);

    if (_user.isAnonymous) {
      await AuthService().deleteAccount(_user);
      setState(() => _isLoading = false);
      return;
    }

    await AuthService().signOut();
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {});
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User?>(context);
    print(_user);

    return DefaultTabController(
      length: 2,
      child: LoadingOverlay(
        color: Colors.transparent.withOpacity(.8),
        isLoading: _isLoading,
        child: Scaffold(
          appBar: _buildAppBar(),
          drawer: _buildDrawer(),
          body: Center(
            child: TextButton(
              child: Text('sign out'),
              onPressed: () async {
                await AuthService().signOut();
              },
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('match setup'),
      actions: <Widget>[
        IconButton(
          onPressed: () => {},
          icon: Icon(
            Icons.arrow_forward,
          ),
        )
      ],
      bottom: TabBar(
        controller: _tabController,
        tabs: <Widget>[
          Tab(
            text: 'team #1',
          ),
          Tab(
            text: 'team #2',
          )
        ],
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      elevation: 500,
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                _user.displayName,
              ),
              accountEmail: Text(
                _user.email,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  _user.photoURL,
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'lib/assets/images/basketballCourt.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.looks_3,
              ),
              title: Text(
                'play 3 points contest',
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.history,
              ),
              title: Text(
                'contest history',
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.history,
              ),
              title: Text(
                'matches history',
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.unarchive,
              ),
              title: Text(
                'unfinished activities',
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.settings,
              ),
              title: Text(
                'settings',
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.cancel,
              ),
              title: Text(
                'sign out',
              ),
              onTap: signOut,
            ),
          ],
        ),
      ),
    );
  }
}
