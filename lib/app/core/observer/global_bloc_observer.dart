import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(
        "[${bloc.runtimeType}](${transition.event.runtimeType}) ${transition.currentState} -> ${transition.nextState}");
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print("[${bloc.runtimeType}] created");
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print("[${bloc.runtimeType}] closed");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print("[${bloc.runtimeType}] $error\n$stackTrace");
  }
}
