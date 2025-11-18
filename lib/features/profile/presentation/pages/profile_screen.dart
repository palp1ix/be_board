import 'package:be_board/core/core.dart';
import 'package:be_board/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:be_board/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:be_board/features/profile/presentation/widgets/sign_out_button.dart';
import 'package:be_board/features/profile/presentation/widgets/user_info_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(ProfileDataLoaded()),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: AppColors.textBlack),
        ),
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoadSuccess) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  ProfileAvatar(avatarUrl: state.avatarUrl),
                  const SizedBox(height: 48),
                  UserInfoTile(
                    title: state.name,
                    subtitle: 'Name',
                    icon: Icons.person_outline,
                  ),
                  const Divider(),
                  UserInfoTile(
                    title: state.email,
                    subtitle: 'Email',
                    icon: Icons.email_outlined,
                  ),
                  const Spacer(),
                  SignOutButton(
                    onPressed: () {
                      context.read<ProfileBloc>().add(ProfileSignOutButtonPressed());
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          } else if (state is ProfileLoadFailure) {
            return Center(
              child: Text('Failed to load profile: ${state.message}'),
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
