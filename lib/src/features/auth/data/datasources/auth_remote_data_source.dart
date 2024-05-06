abstract interface class AuthRemoteDataSource {
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
  });

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<bool> isUserLoggedIn();

  Future<void> forgotPassword({
    required String email,
  });

  Future<String> getCurrentUId();

  Future<void> saveUserDetails({
    required String firstName,
    required String lastName,
    required String city,
    required String college,
  });
}
