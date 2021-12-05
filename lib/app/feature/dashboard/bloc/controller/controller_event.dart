part of 'controller_bloc.dart';

abstract class ControllerEvent extends Equatable {
  const ControllerEvent();

  @override
  List<Object?> get props => [];
}

class Init extends ControllerEvent {
  const Init();
}

class Activate extends ControllerEvent {
  const Activate();
}

class Deactivate extends ControllerEvent {
  final String? errorMessage;

  const Deactivate({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class ModeChangeRequested extends ControllerEvent {
  const ModeChangeRequested({required this.nextMode});

  final ModeStatus nextMode;

  @override
  List<Object?> get props => [nextMode];
}

class ValidateInput extends ControllerEvent {
  const ValidateInput(
      {this.serverPort,
      this.hostAddress,
      this.clientPort,
      this.syncInterval,
      this.isValid = false,});

  final String? serverPort;
  final String? hostAddress;
  final String? clientPort;
  final String? syncInterval;
  final bool isValid;

  @override
  List<Object?> get props => [
        serverPort,
        hostAddress,
        clientPort,
        syncInterval,
        isValid,
      ];
}
