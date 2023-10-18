import 'package:empty_feature_folder/features/settings/bloc/settings_bloc.dart';
import 'package:empty_feature_folder/routes/app_routes.dart';
import 'package:empty_feature_folder/routes/name_routes.dart';
import 'package:empty_feature_folder/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/chats/bloc/chats_bloc.dart';
import 'features/main/presentation/bloc/main_bloc.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(create: (BuildContext context) => MainBloc()),
        BlocProvider<SplashBloc>(create: (BuildContext context) => SplashBloc()),
        BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
        BlocProvider<ChatsBloc>(create: (BuildContext context) => ChatsBloc()),
        BlocProvider<SettingsBloc>(create: (BuildContext context) => SettingsBloc()),
      ],
      child: const KeyboardDismisser(
        child: MaterialApp(
          initialRoute: RouteName.splash,
          onGenerateRoute: AppRoutes.generateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
