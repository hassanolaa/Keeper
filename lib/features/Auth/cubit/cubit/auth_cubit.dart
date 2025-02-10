import 'package:bloc/bloc.dart';
import 'package:bookmarker/features/Auth/data/auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    try {
      emit(AuthLoading());
      // Add your sign-in logic here
     String response = await Auth.signIn(email, password);
      if (response == "SignIn success") {
        emit(AuthAuthenticated());
      } else {
        emit(AuthError(response));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      // Add your sign-out logic here
      String response = await Auth.signOut();
      if (response == "SignOut success") {
        emit(AuthUnauthenticated());
      } else {
        emit(AuthError(response));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(String username, String email, String password) async {
    try {
      emit(AuthLoading());
      // Add your sign-up logic here
       String response = await Auth.signUp(username,email, password);
     
       if (response == "SignUp success") {
        emit(AuthAuthenticated());
         
       }
        else {
          emit(AuthError(response));
        }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Add your Google sign-in logic here
      String response = await Auth.signInWithGoogle();
      if (response == "SignIn success") {
        emit(AuthAuthenticated());
      } else {
        emit(AuthError(response));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
