import 'package:flutter/material.dart';
import 'package:watchme/config/theme/app_colors.dart';
import 'package:watchme/data/models/cast_model.dart';
import 'package:watchme/data/services/api_config.dart';
import 'package:watchme/utils/app_utils.dart';

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
    final String profilePath = item.profilePath ?? '';
    final String imageSource = getImageUrl(
      profilePath,
      baseUrl: ApiConfig.imageBaseUrl,
    );
    final bool isNetworkImage =
        !imageSource.startsWith('assets/images/placeholder.png');

    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 100,
              width: 100,
              child:
                  isNetworkImage
                      ? FadeInImage.assetNetwork(
                        placeholder: localPlaceholderPath,
                        image: imageSource,
                        fit: BoxFit.cover,
                        imageErrorBuilder:
                            (context, error, stackTrace) => Container(
                              color: Colors.grey.shade800,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white70,
                              ),
                            ),
                      )
                      : Image.asset(localPlaceholderPath, fit: BoxFit.cover),
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
