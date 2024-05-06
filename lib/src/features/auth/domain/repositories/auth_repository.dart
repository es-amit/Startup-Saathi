abstract interface class AuthRepository {
  Future<void> logInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<void> logOut();

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
    String phoneNumber,
  );

  Future<bool> isUserLoggedIn();

  Future<String> getCurrentUId();

  Future<void> saveUserDetails(
    String firstName,
    String lastName,
    String city,
    String college,
  );

  Future<void> forgotPassword(String email);
}
