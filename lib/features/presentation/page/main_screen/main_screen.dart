import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/core/animation/data_not_found_animation_view.dart';
import 'package:startup_saathi/core/animation/loading_animation_view.dart';
import 'package:startup_saathi/core/constants.dart';
import 'package:startup_saathi/core/dialog/log_out_dialog.dart';
import 'package:startup_saathi/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:startup_saathi/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:startup_saathi/features/presentation/page/chat/chat_page.dart';
import 'package:startup_saathi/features/presentation/page/home/home_page.dart';
import 'package:startup_saathi/features/presentation/page/profile/profile_page.dart';

class MainScreen extends StatefulWidget {
  final String uid;
  const MainScreen({
    super.key,
    required this.uid,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // Navigator.of(context).popUntil((route) => route.isFirst);
    context.read<GetSingleUserCubit>().getSingleUser(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, getSingleUserState) {
          if (getSingleUserState is GetSingleUserLoading) {
            return const Scaffold(
              body: Center(
                child: LoadingAnimationView(),
              ),
            );
          } else if (getSingleUserState is GetSingleUserLoaded) {
            final currentUser = getSingleUserState.user;
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: logOut,
                    icon: const Icon(Icons.logout),
                  )
                ],
              ),
              body: TabBarView(
                children: [
                  HomePage(
                    uid: widget.uid,
                  ),
                  const ChatPage(),
                  ProfilePage(
                    userEntity: currentUser,
                  ),
                ],
              ),
              bottomNavigationBar: const TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Icon(Icons.chat),
                ),
                Tab(
                  icon: Icon(Icons.person),
                )
              ]),
            );
          }
          return const Center(
            child: DataNotFoundAnimationView(),
          );
        },
      ),
    );
  }

  void logOut() async {
    final shouldLogOut = await showLogOutDialog(context);
    if (shouldLogOut) {
      // ignore: use_build_context_synchronously
      context.read<AuthCubit>().loggedOut();
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushNamedAndRemoveUntil(PageConst.logInPage, (route) => false);
    }
  }
}
