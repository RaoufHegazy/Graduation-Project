import '/services/auth/firebase_auth_provider.dart';
import '/services/auth/auth_provider.dart';
import '/services/auth/auth_user.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FireBaseAuthProvider());

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
