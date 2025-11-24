import 'package:flutter/material.dart';
import 'package:watchme/config/theme/app_colors.dart';
import 'package:watchme/data/models/cast_model.dart';

class CastProfileCard extends StatelessWidget {
  final dynamic item;
  final String detailType;
  const CastProfileCard({
    super.key,
    required this.item,
    required this.detailType,
  });

  @override
  Widget build(BuildContext context) {
    final String name = item.name;
    final String detail =
        detailType == 'character'
            ? item.character
            : (item is CrewModel ? item.job : 'Job N/A');
    final String imageUrl =
        'https://image.tmdb.org/t/p/w500${item.profilePath}';

    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            detail,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
