import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<LogoutRequested>(_onLogoutRequested);
    //on<DeleteAccountRequested>(_onDeleteAccountRequested);
  }

  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(ProfileError('No user is currently signed in.'));
        return;
      }
      await user.reload();
      final refreshed = _auth.currentUser;
      emit(ProfileLoaded(
        uid: refreshed?.uid,
        displayName: refreshed?.displayName ?? 'No username',
        email: refreshed?.email ?? 'No email',
      ));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(ProfileError('No user is currently signed in.'));
        return;
      }
      await user.delete();
      emit(ProfileActionSuccess('Account deleted successfully.'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        emit(ProfileError(
            'This action requires recent authentication. Please sign in again and try.'));
      } else {
        emit(ProfileError('Failed to delete account: ${e.message}'));
      }
    } catch (e) {
      emit(ProfileError('Failed to delete account: ${e.toString()}'));
    }
  }

  /*Future<void> _onDeleteAccountRequested(
      DeleteAccountRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(ProfileError('No user to delete.'));
        return;
      }
      await user.delete();
      emit(ProfileActionSuccess('Account deleted successfully.'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        emit(ProfileError(
            'This action requires recent authentication. Please sign in again and try.'));
      } else {
        emit(ProfileError('Failed to delete account: ${e.message}'));
      }
    } catch (e) {
      emit(ProfileError('Failed to delete account: ${e.toString()}'));
    }
  }*/
}
