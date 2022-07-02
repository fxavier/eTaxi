import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etaxi/models/models.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.unauthenticated()) {
    on<AppEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
