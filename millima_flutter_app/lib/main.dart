import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/authentication/bloc/authentication_bloc.dart';
import 'package:millima/features/authentication/views/login_screen.dart';
import 'package:millima/features/home/views/home_screen.dart';
import 'package:millima/features/user/bloc/user_bloc.dart';
import 'package:millima/utils/locator.dart';
import 'package:millima/utils/providers.dart';

import 'utils/helpers/dialogs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencySetUp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.isLoading) {
              AppDialogs.showLoading(context);
            } else {
              AppDialogs.hideLoading(context);

              if (state.error != null) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text(state.error.toString())),
                  );
              }
            }

            if (state.status == AuthenticationStatus.authenticated) {
              context.read<UserBloc>().add(GetCurrentUserEvent());
            }
          },
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return const HomeScreen();
            }

            return LoginScreen();
          },
        ),
      ),
    );
  }
}
