part of 'ip_bloc.dart';

abstract class IPEvent extends Equatable {
  const IPEvent();
}

class GetIP extends IPEvent {
  const GetIP();

  @override
  List<Object?> get props => [];
}
