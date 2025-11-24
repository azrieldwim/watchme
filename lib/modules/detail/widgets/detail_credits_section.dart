import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchme/config/theme/app_colors.dart';
import 'package:watchme/modules/detail/widgets/profile_card.dart';
import '../controllers/detail_controller.dart';

class DetailCreditsSection extends GetView<DetailController> {
  const DetailCreditsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> tabs = ['Cast', 'Writer', 'Director'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Row(
                  children:
                      tabs
                          .map((tab) => _buildTabItem(context, tab, tabs))
                          .toList(),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => _buildCastContent(context, controller.activeTab.value)),
      ],
    );
  }

  Widget _buildTabItem(
    BuildContext context,
    String tabName,
    List<String> tabs,
  ) {
    final bool isActive = controller.activeTab.value == tabName;
    final bool isLastTab = tabName == tabs.last;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => controller.changeTab(tabName),
          child: Padding(
            padding: const EdgeInsets.only(right: 5, bottom: 5),
            child: Column(
              children: [
                Text(
                  tabName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isActive ? AppColors.white : AppColors.textSecondary,
                  ),
                ),
                if (isActive)
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    height: 2,
                    width: tabName == 'Cast' ? 35 : 50,
                    color: AppColors.primary,
                  ),
              ],
            ),
          ),
        ),
        if (!isLastTab)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              '•',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCastContent(BuildContext context, String activeTab) {
    List<dynamic> currentList;
    String detailType;

    if (activeTab == 'Cast') {
      currentList = controller.castList;
      detailType = 'character';
    } else if (activeTab == 'Writer') {
      currentList =
          controller.crewList
              .where((c) => c.job == 'Screenplay' || c.job == 'Writer')
              .toList();
      detailType = 'job';
    } else {
      currentList =
          controller.crewList.where((c) => c.job == 'Director').toList();
      detailType = 'job';
    }

    if (currentList.isEmpty) {
      return Text(
        'Tidak ada $activeTab yang terdaftar.',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: currentList.length,
        itemBuilder: (context, index) {
          final item = currentList[index];
          return CastProfileCard(item: item, detailType: detailType);
        },
      ),
    );
  }
}
