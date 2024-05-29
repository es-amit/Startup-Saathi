import 'package:flutter/material.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';
import 'package:startup_saathi/features/presentation/widgets/user_image.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;
  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.27,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 178, 177, 177),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          UserImage.large(
            height: MediaQuery.of(context).size.height * 0.24,
            width: MediaQuery.of(context).size.width * 0.33,
            url: user.profileUrl,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '${user.whoYouAre} | ${user.email}',
                ),

                Text(
                  '${user.college} | ${user.lookingFor}',
                ),
                Text(
                  '${user.email}',
                ),
                const Spacer(),
                SizedBox(
                  height: 40, // Adjust height as necessary
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: user.skills!.length,
                    itemBuilder: (context, index) {
                      final skills = user.skills!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Chip(
                          label: Text(
                            skills[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          backgroundColor: Colors.black,
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(), // To push the buttons to the bottom
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Interested'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Chat'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
