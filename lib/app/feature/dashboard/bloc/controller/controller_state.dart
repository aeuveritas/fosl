part of 'controller_bloc.dart';

enum ActivateStatus { inactive, active }

class ControllerState extends Equatable {
  const ControllerState._({
    this.status = ActivateStatus.inactive,
    this.mode = ModeStatus.server,
    this.isError = false,
    this.errorMessage = "",
    this.serverPort = "",
    this.hostAddress = "",
    this.clientPort = "",
    this.syncInterval = "",
    this.inputValid = false,
  });

  final ActivateStatus status;
  final ModeStatus mode;
  final bool isError;
  final String errorMessage;

  final String serverPort;
  final String hostAddress;
  final String clientPort;
  final String syncInterval;

  final bool inputValid;

  const ControllerState.server() : this._();
  const ControllerState.client() : this._(mode: ModeStatus.client);

  @override
  List<Object?> get props => [
        status,
        mode,
        isError,
        errorMessage,
        serverPort,
        hostAddress,
        clientPort,
        syncInterval,
        inputValid
      ];

  ControllerState copyWith({
    ActivateStatus? status,
    ModeStatus? mode,
    bool? isError,
    String? errorMessage,
    String? serverPort,
    String? hostAddress,
    String? clientPort,
    String? syncInterval,
    bool? inputValid,
  }) {
    return ControllerState._(
      status: status ?? this.status,
      mode: mode ?? this.mode,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      serverPort: serverPort ?? this.serverPort,
      hostAddress: hostAddress ?? this.hostAddress,
      clientPort: clientPort ?? this.clientPort,
      syncInterval: syncInterval ?? this.syncInterval,
      inputValid: inputValid ?? this.inputValid,
    );
  }

  ControllerState activate() {
    return copyWith(
      status: ActivateStatus.active,
      isError: false,
      errorMessage: "",
    );
  }

  ControllerState deactivate(String? errorMessage) {
    bool _isError = false;
    String _errorMessage = "";
    if (errorMessage != null) {
      _isError = true;
      _errorMessage = errorMessage;
    }
    return copyWith(
      status: ActivateStatus.inactive,
      isError: _isError,
      errorMessage: _errorMessage,
    );
  }

  List<bool> get modeList {
    if (mode == ModeStatus.server) {
      return [true, false];
    } else {
      return [false, true];
    }
  }
}
