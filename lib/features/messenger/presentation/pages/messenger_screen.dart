import 'package:be_board/core/core.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final threads = List.generate(
      5,
      (index) => _Thread(
        name: 'Seller ${index + 1}',
        preview: 'Thanks! I can ship it tomorrow.',
        time: '0${index + 1}:24',
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
            child: Row(
              children: [
                AppIconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  backgroundColor: AppColors.white,
                  onPressed: () => sl<AppNavigator>().pop(),
                ),
                const Spacer(),
                AppIconButton(
                  icon: Icon(Icons.file_upload_outlined),
                  backgroundColor: AppColors.white,
                  onPressed: () {},
                ),
                const SizedBox(width: 12),
                AppIconButton(
                  icon: Icon(Icons.favorite_border_rounded),
                  backgroundColor: AppColors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          final thread = threads[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(AppAssets.post1),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        thread.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        thread.preview,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      thread.time,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    const AppBadge(
                      label: '2',
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: threads.length,
      ),
    );
  }
}

class _Thread {
  const _Thread({
    required this.name,
    required this.preview,
    required this.time,
  });

  final String name;
  final String preview;
  final String time;
}
