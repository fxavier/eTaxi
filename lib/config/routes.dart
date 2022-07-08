import 'package:etaxi/blocs/app/app_bloc.dart';
import 'package:etaxi/screens/screens.dart';
import 'package:flutter/material.dart';

List<Page> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];
    case AppStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
