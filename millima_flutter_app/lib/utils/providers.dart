import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/authentication/bloc/authentication_bloc.dart';
import 'package:millima/features/user/bloc/user_bloc.dart';

import 'locator.dart';

final providers = [
  BlocProvider<UserBloc>.value(value: getIt.get<UserBloc>()),
  BlocProvider<AuthenticationBloc>.value(
      value: getIt.get<AuthenticationBloc>()),
];
