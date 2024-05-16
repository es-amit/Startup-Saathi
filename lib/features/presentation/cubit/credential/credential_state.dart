part of 'credential_cubit.dart';

abstract class CredentialState extends Equatable {
  const CredentialState();
}

class CredentialInitial extends CredentialState {
  @override
  List<Object> get props => [];
}

class CredentialLoading extends CredentialState {
  @override
  List<Object> get props => [];
}

class CredentialSuccess extends CredentialState {
  @override
  List<Object> get props => [];
}

class CredentialFailure extends CredentialState {
  final String errorTitle;
  final String errorMessage;

  const CredentialFailure({
    this.errorTitle = 'Error',
    this.errorMessage = 'Something went wrong',
  });

  @override
  List<Object> get props => [
        errorTitle,
        errorMessage,
      ];
}

class CredentialEmailSent extends CredentialState {
  @override
  List<Object> get props => [];
}

class CredentialPersonalInfo extends CredentialState {
  @override
  List<Object?> get props => [];
}
