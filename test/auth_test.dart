import 'package:flutter_test/flutter_test.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';

void main() {
  group(
    'Mock Authentication',
    () {
      final provider = MockAuthProvider();
      test(
        'should not be initialised to begin with',
        () {
          expect(provider.isInitialised, false);
        },
      );

      test(
        'Cannot log out if not initialised',
        () {
          expect(provider.logOut(),
              throwsA(const TypeMatcher<NotInitialisedException>()));
        },
      );

      test(
        'Should be able to be initialised',
        () async {
          await provider.initialise();
          expect(provider.isInitialised, true);
        },
      );

      test(
        'User should be null after initialised',
        () {
          expect(provider.currentUser, null);
        },
      );

      test(
        'Should be able to initialise in less than 2 secs',
        () async {
          await provider.initialise();
          expect(provider.isInitialised, true);
        },
        timeout: const Timeout(Duration(seconds: 2)),
      );

      test(
        'Create user should delegate to logIn function',
        () async {
          final badEmailUser = provider.createUser(
            email: 'foo@bar.com',
            password: 'anypassword',
          );

          expect(
            badEmailUser,
            throwsA(const TypeMatcher<UserNotFoundAuthException>()),
          );

          final badPaswordUser = provider.createUser(
            email: 'someone@bar.com',
            password: 'foobar',
          );

          expect(
            badPaswordUser,
            throwsA(const TypeMatcher<WrongPasswordAuthException>()),
          );

          final user = await provider.createUser(
            email: 'foo',
            password: 'bar',
          );

          expect(provider.currentUser, user);
          expect(user.isEmailVerified, false);
        },
      );

      test(
        'Logged user should be able to get verified',
        () async {
          provider.sendEmailVerification();
          final user = provider.currentUser;
          expect(user, isNotNull);
          expect(user!.isEmailVerified, true);
        },
      );

      test(
        'Should be able to logout and login again',
        () async {
          await provider.logOut();
          await provider.logIn(
            email: 'email',
            password: 'password',
          );

          final user = provider.currentUser;
          expect(user, isNotNull);
        },
      );
    },
  );
}

class NotInitialisedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialised = false;
  bool get isInitialised => _isInitialised;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialised) throw NotInitialisedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  Future<void> initialise() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialised = true;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    if (!isInitialised) throw NotInitialisedException();
    if (email == 'foo@bar.com') throw UserNotFoundAuthException();
    if (password == 'foobar') throw WrongPasswordAuthException();

    const user = AuthUser(isEmailVerified: false, email: 'someone@bar.com');
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialised) throw NotInitialisedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialised) throw NotInitialisedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true, email: 'someone@bar.com');
    _user = newUser;
  }
  
  @override
  Future<void> initialize() {
    
    throw UnimplementedError();
  }
}
