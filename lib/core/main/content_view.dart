import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

import '../../providers/auth.dart';
import '../authentication/views/login_view.dart';
import 'main_tab_view.dart';

class ContentView extends StatelessWidget {
  static const routeName = '/';

  const ContentView({super.key});

  Future<FirebaseApp> _initialization(
      Future<void> Function() onComplete) async {
    /// Deactivate landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    await onComplete();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization(() async {
        await Provider.of<Auth>(context, listen: false).fetchUser();
      }),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('An unexpected error has occurred: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return Consumer<Auth>(
            builder: (context, auth, _) {
              if (snapshot.data != null) {
                if (auth.currentUser != null) return const MainTabView();
              }
              return const LoginView();
            },
          );
        } else {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Center(
                child:
                    SvgPicture.asset('assets/images/app_icon.svg', width: 120)),
          );
        }
      },
    );
  }
}
