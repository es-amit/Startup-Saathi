import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/core/constants/constants.dart';
import 'package:startup_saathi/core/loading/loading_screen.dart';
import 'package:startup_saathi/core/constants/app_strings.dart';
import 'package:startup_saathi/core/theme/app_pallete.dart';
import 'package:startup_saathi/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:startup_saathi/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:startup_saathi/features/presentation/page/credential/log_in_page.dart';
import 'package:startup_saathi/features/presentation/widgets/selectable_button.dart';
import 'package:startup_saathi/features/presentation/widgets/show_snackbar.dart';

class WhoAreYouPage extends StatefulWidget {
  const WhoAreYouPage({super.key});

  @override
  State<WhoAreYouPage> createState() => _WhoAreYouPageState();
}

class _WhoAreYouPageState extends State<WhoAreYouPage> {
  String? selectedButton;

  selectButton(String buttonName) {
    setState(() {
      selectedButton = buttonName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialLoading) {
            LoadingScreen.instance()
                .show(context: context, text: AppStrings.storingDetails);
          } else if (credentialState is CredentialUserInfoStored) {
            LoadingScreen.instance().hide();

            context.read<AuthCubit>().loggedIn();
            showSnackbar(
              context,
              AppStrings.yourDetailsSaved,
            );
          } else if (credentialState is CredentialPersonalInfoFailure) {
            LoadingScreen.instance().hide();
            showAuthError(
              context: context,
              dialogTitle: credentialState.errorTitle,
              dialogText: credentialState.errorMessage,
            );
          } else {
            LoadingScreen.instance().hide();
          }
        },
        builder: (context, credentialState) {
          if (credentialState is CredentialUserInfoStored) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacementNamed(
                      PageConst.mainPage,
                      arguments: authState.uid,
                    );
                  });
                  return Container();
                } else if (authState is UnAuthenticated) {
                  return const LogInPage();
                }
                return _bodyWidget();
              },
            );
          }
          return _bodyWidget();
        },
      ),
    );
  }

  Widget _bodyWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              AppStrings.whoAreYou,
              style: TextStyle(
                fontSize: 25,
                color: AppPallete.fontColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SelectableButton(
              isSelected: selectedButton == AppStrings.cofounder,
              text: AppStrings.cofounder,
              onPressed: () {
                selectButton(AppStrings.cofounder);
              },
            ),
            const SizedBox(height: 20),
            SelectableButton(
              isSelected: selectedButton == AppStrings.startup,
              text: AppStrings.startup,
              onPressed: () {
                selectButton(AppStrings.startup);
              },
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton.icon(
                onPressed: selectedButton != null ? storeWhoAreYou : null,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: selectedButton != null
                      ? AppPallete.blackColor
                      : AppPallete.greyColor,
                  size: 20,
                ),
                label: Text(
                  AppStrings.next,
                  style: TextStyle(
                    fontSize: 18,
                    color: selectedButton != null
                        ? AppPallete.blackColor
                        : AppPallete.greyColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void storeWhoAreYou() {
    final credentialCubit = context.read<CredentialCubit>();
    setState(() {
      credentialCubit.userEntity = credentialCubit.userEntity?.copyWith(
        whoYouAre: selectedButton,
      );
    });

    if (selectedButton == AppStrings.startup) {
      Navigator.of(context).pushReplacementNamed(PageConst.startupInfoPage);
    } else {
      credentialCubit.storeUserDetails(
        user: credentialCubit.userEntity!,
      );
    }
  }
}
