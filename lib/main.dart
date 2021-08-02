import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabf/model/user.dart';
import 'package:tabf/screen/home_screen.dart';
import 'package:tabf/screen/login_screen.dart';
import 'package:tabf/screen/note_editor.dart';
import 'package:tabf/screen/settings_screen.dart';
import 'package:tabf/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) => StreamProvider.value(
        value: FirebaseAuth.instance
            .authStateChanges()
            .map((user) => CurrentUser.create(user)),
        initialData: CurrentUser.initial,
        child: Consumer<CurrentUser>(
          builder: (context, user, _) => MaterialApp(
            title: 'TABF',
            theme: Theme.of(context).copyWith(
              brightness: Brightness.light,
              primaryColor: Colors.white,
              accentColor: kAccentColorLight,
              appBarTheme: AppBarTheme.of(context).copyWith(
                elevation: 0,
                brightness: Brightness.light,
                iconTheme: IconThemeData(
                  color: kIconTintLight,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              bottomAppBarColor: kBottomAppBarColorLight,
              primaryTextTheme: Theme.of(context).primaryTextTheme.copyWith(
                    // title
                    headline6: const TextStyle(
                      color: kIconTintLight,
                    ),
                  ),
            ),
            home: user.isInitialValue
                ? Scaffold(body: const SizedBox())
                : user.data != null
                    ? HomeScreen()
                    : LoginScreen(),
            routes: {
              '/settings': (_) => SettingsScreen(),
            },
            onGenerateRoute: _generateRoute,
          ),
        ),
      );
}

/// Handle named route
Route? _generateRoute(RouteSettings settings) {
  try {
    return _doGenerateRoute(settings);
  } catch (e, s) {
    debugPrint("failed to generate route for $settings: $e $s");
    return null;
  }
}

Route? _doGenerateRoute(RouteSettings settings) {
  // If there's an empty name or it's null, return null
  if (settings.name?.isEmpty ?? true) return null;

  // Assert that name can't be null at this point
  final uri = Uri.parse(settings.name!);
  final path = uri.path;
  // final q = uri.queryParameters ?? <String, String>{};
  switch (path) {
    case '/note':
      {
        // final note = (settings.arguments as Map? ?? {})['note'];
        return _buildRoute(settings, (_) => NoteEditor());
      }
    default:
      return null;
  }
}

/// Create a [Route].
Route _buildRoute(RouteSettings settings, WidgetBuilder builder) =>
    MaterialPageRoute<void>(
      settings: settings,
      builder: builder,
    );
