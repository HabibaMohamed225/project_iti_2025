import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String? uid;
  final String? displayName;
  final String? email;

  ProfileLoaded({
    required this.uid,
    required this.displayName,
    required this.email,
  });

  @override
  List<Object?> get props => [uid, displayName, email];
}

class ProfileActionSuccess extends ProfileState {
  final String message;
  ProfileActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileError extends ProfileState {
  final String error;
  ProfileError(this.error);

  @override
  List<Object?> get props => [error];
}
