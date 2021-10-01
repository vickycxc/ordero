import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/routes.dart';
import 'package:fiksii/theme.dart';
import 'package:fiksii/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_map_location_picker/generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => FirebaseState(),),
      //ChangeNotifierProvider(create: (context) => [DataPesenan(),)
    ],
    builder: (context, child) {
      return MyAwesomeApp();
    },
  )));
}

class MyAwesomeApp extends StatelessWidget {
  const MyAwesomeApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ordero',
      theme: theme(),
      home: Consumer<FirebaseState> (
        builder: (context, value, child) => Wrapper(
          loginState: value.loginState,
          completeProfile: value.completeProfile,
        ),
      ),
      routes: routes,
      localizationsDelegates: const [ //from picker
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[ //iki sisan
        Locale('en', ''),
        Locale('ar', ''),
        Locale('pt', ''),
        Locale('tr', ''),
        Locale('es', ''),
        Locale('it', ''),
        Locale('ru', ''),
      ],
    );
  }
}
