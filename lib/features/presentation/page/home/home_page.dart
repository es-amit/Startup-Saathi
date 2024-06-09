import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/core/animation/data_not_found_animation_view.dart';
import 'package:startup_saathi/features/presentation/cubit/user/get_all_users/get_all_users_cubit.dart';
import 'package:startup_saathi/features/presentation/page/home/widget/shimmer_user_card.dart';
import 'package:startup_saathi/features/presentation/page/home/widget/user_card.dart';

class HomePage extends StatefulWidget {
  final String? uid;
  const HomePage({super.key, this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<GetAllUsersCubit>().getAllUsers(widget.uid!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetAllUsersCubit, GetAllUsersState>(
        builder: (context, allUserState) {
          if (allUserState is GetAllUserLoadingState) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: ((context, index) {
                return const ShimmerUserCard();
              }),
            );
          } else if (allUserState is GetAllUserSuccessState) {
            final users = allUserState.users;
            if (users.isEmpty) {
              return const Center(
                child: DataNotFoundAnimationView(),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: ((context, index) {
                      final user = users[index];
                      return UserCard(
                        user: user,
                      );
                    }),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: DataNotFoundAnimationView(),
          );
        },
      ),
    );
  }
}
