import 'package:flutter/material.dart';
import 'package:podcast_finder/components/glass_widgets.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/entities.dart';

class EpisodeListTile extends StatelessWidget {
  final EpisodeEntity episode;

  const EpisodeListTile({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFDEE2E6), width: 1),
        opacity: 0.32,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                episode.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF212529),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                '${formatDate(episode.pubDateMs)} • ${formatDuration(episode.audioLengthSec)}',
                style: const TextStyle(fontSize: 14, color: Color(0xFF6C757D)),
              ),
              if (episode.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  episode.description!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6C757D),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
