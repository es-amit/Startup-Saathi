import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/core/constants/constants.dart';
import 'package:startup_saathi/core/constants/app_strings.dart';
import 'package:startup_saathi/core/loading/loading_screen.dart';
import 'package:startup_saathi/core/strings/choice_chip.dart';
import 'package:startup_saathi/core/strings/choice_chip_data.dart';
import 'package:startup_saathi/core/theme/app_pallete.dart';
import 'package:startup_saathi/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:startup_saathi/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:startup_saathi/features/presentation/page/credential/log_in_page.dart';
import 'package:startup_saathi/features/presentation/widgets/bio_text_field.dart';
import 'package:startup_saathi/features/presentation/widgets/show_snackbar.dart';

class StartupInfoPage extends StatefulWidget {
  const StartupInfoPage({super.key});

  @override
  State<StartupInfoPage> createState() => _StartupInfoPageState();
}

class _StartupInfoPageState extends State<StartupInfoPage> {
  List<ChoiceChipData> choiceChips = ChoiceChips.all;
  late TextEditingController _bioController;
  String? businessStage;
  String? selectedCompanyStage;

  static const double spacing = 8;

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<CredentialCubit, CredentialState>(
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
      ),
    );
  }

  Widget _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Center(
            child: Text(
              AppStrings.startupInfo,
              style: TextStyle(
                fontSize: 27,
                color: AppPallete.fontColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            AppStrings.bio,
            style: TextStyle(
              fontSize: 16,
              color: AppPallete.fontColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          BioTextField(
            controller: _bioController,
          ),
          const SizedBox(height: 20),
          const Text(
            AppStrings.companyCategories2,
            style: TextStyle(
              fontSize: 16,
              color: AppPallete.fontColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          CustomDropdown(
            hintText: AppStrings.companySector,
            items: sectors,
            onChanged: (value) {
              selectedCompanyStage = value;
            },
          ),
          const SizedBox(height: 25),
          const Text(
            AppStrings.businessStage,
            style: TextStyle(
              fontSize: 16,
              color: AppPallete.fontColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          buildChoiceChips(),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton.icon(
              onPressed: isValid ? storeStartupInfo : null,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: isValid ? AppPallete.blackColor : AppPallete.greyColor,
                size: 20,
              ),
              label: Text(
                AppStrings.next,
                style: TextStyle(
                  fontSize: 18,
                  color: isValid ? AppPallete.blackColor : AppPallete.greyColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool get isValid {
    return _bioController.text.isNotEmpty &&
        selectedCompanyStage != null &&
        businessStage != null;
  }

  Widget buildChoiceChips() => Wrap(
        runSpacing: spacing,
        spacing: spacing,
        children: choiceChips
            .map(
              (choiceChip) => ChoiceChip(
                label: Text(choiceChip.label),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                onSelected: (isSelected) => setState(() {
                  businessStage = choiceChip.label;
                  choiceChips = choiceChips.map((otherChip) {
                    final newChip = otherChip.copy(isSelected: false);

                    return choiceChip == otherChip
                        ? newChip.copy(isSelected: isSelected)
                        : newChip;
                  }).toList();
                }),
                selected: choiceChip.isSelected,
                selectedColor: Colors.black,
                backgroundColor: Colors.grey,
              ),
            )
            .toList(),
      );

  void storeStartupInfo() {
    final credentialCubit = context.read<CredentialCubit>();
    setState(() {
      credentialCubit.userEntity = credentialCubit.userEntity?.copyWith(
        bio: _bioController.text,
        businessStage: businessStage,
        companySector: selectedCompanyStage,
      );
    });
    credentialCubit.storeUserDetails(
      user: credentialCubit.userEntity!,
    );
  }
}
