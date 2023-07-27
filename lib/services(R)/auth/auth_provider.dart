import '/services(R)/auth/auth_user.dart';

//  to choose for which database u will authenticate (firebase or other dattbase)

// interface (methods are called to be overrided)

abstract class AuthProvider {
  AuthUser? get currentuser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<void> sendEmailVerfication();
}
