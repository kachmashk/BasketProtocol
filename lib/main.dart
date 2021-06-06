import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:basketprotocol/utils/themes/themes.dart';
import 'package:basketprotocol/utils/themes/theme_changer.dart';

import 'package:basketprotocol/ui/pages/sign_in_page.dart';
import 'package:basketprotocol/ui/pages/match_setup_page.dart';

Future<void> main() async {
  LicenseRegistry.addLicense(
    () async* {
      final license =
          await rootBundle.loadString('lib/assets/fonts/Oxygen/OFL.txt');
      yield LicenseEntryWithLineBreaks(['lib/assets/fonts/Oxygen'], license);
    },
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (context) => ThemeChanger(
        Themes.getDarkTheme(),
      ),
      child: Providers(),
    );
  }
}

class Providers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <StreamProvider>[
        StreamProvider<User?>(
          initialData: null,
          create: (context) => FirebaseAuth.instance.authStateChanges(),
        ),
      ],
      child: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      home: user == null ? SignInPage() : MatchSetupPage(),
    );
  }
}
