import 'package:be_board/core/core.dart';
import 'package:be_board/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:be_board/features/profile/presentation/widgets/profile_menu_tile.dart';
import 'package:be_board/features/profile/presentation/widgets/profile_overview_card.dart';
import 'package:be_board/features/profile/presentation/widgets/sign_out_button.dart';

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
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoadFailure) {
              return Center(
                child: Text('Failed to load profile: ${state.message}'),
              );
            } else if (state is ProfileLoadSuccess) {
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    'Profile',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textBlack,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ProfileOverviewCard(
                    name: state.name,
                    email: state.email,
                    avatarUrl: state.avatarUrl ?? AppAssets.placeholder,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      children: [
                        ProfileMenuTile(
                          icon: Icons.settings_outlined,
                          title: 'Account settings',
                          subtitle: 'Password, phone, notifications',
                          onTap: () {},
                        ),
                        ProfileMenuTile(
                          icon: Icons.location_on_outlined,
                          title: 'Shipping address',
                          subtitle: 'Manage delivery locations',
                          onTap: () {},
                        ),
                        ProfileMenuTile(
                          icon: Icons.credit_card,
                          title: 'Payment methods',
                          subtitle: 'Cards, payouts, invoices',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SignOutButton(
                    onPressed: () => context.read<ProfileBloc>().add(
                      ProfileSignOutButtonPressed(),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
