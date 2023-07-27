import 'auth_provider.dart';
import '/services(R)/auth/auth_user.dart';
import 'firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  const AuthService(this.provider);

// to work with firebase (tie FireBaseAuthProvider with auth services )
  factory AuthService.firebase() => AuthService(FireBaseAuthProvider());


  // methods for firebase
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentuser => provider.currentuser;
  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );
  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerfication() => provider.sendEmailVerfication();
}
