import 'package:dio/dio.dart';

/// Interceptor that simulates API responses for testing
/// In a real scenario, you would remove this and use actual API calls
class MockInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Check if this is a search request
    if (options.path.contains('/search')) {
      final query = options.queryParameters['q'] ?? '';
      handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: _getMockSearchResponse(query),
        ),
      );
      return;
    }

    // Check if this is a podcast detail request
    if (options.path.contains('/podcasts/')) {
      final id = options.path.split('/').last;
      handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: _getMockPodcastDetailResponse(id),
        ),
      );
      return;
    }

    // Pass through if no mock is found
    handler.next(options);
  }

  Map<String, dynamic> _getMockSearchResponse(String query) {
    final allPodcasts = [
      {
        'id': 'podcast-1',
        'title': 'Tech Talk Daily',
        'publisher': 'Tech Media Inc',
        'thumbnail': 'https://picsum.photos/seed/podcast1/200',
        'description_original':
            'Your daily dose of technology news and insights. We cover everything from startups to AI.',
      },
      {
        'id': 'podcast-2',
        'title': 'The Science Show',
        'publisher': 'Science Network',
        'thumbnail': 'https://picsum.photos/seed/podcast2/200',
        'description_original':
            'Exploring the wonders of science, from quantum physics to biology.',
      },
      {
        'id': 'podcast-3',
        'title': 'Business Builders',
        'publisher': 'Entrepreneur Media',
        'thumbnail': 'https://picsum.photos/seed/podcast3/200',
        'description_original':
            'Stories and strategies from successful entrepreneurs around the world.',
      },
      {
        'id': 'podcast-4',
        'title': 'Tech Innovations',
        'publisher': 'Innovation Weekly',
        'thumbnail': 'https://picsum.photos/seed/podcast4/200',
        'description_original':
            'Discover the latest technological innovations and breakthrough products.',
      },
      {
        'id': 'podcast-5',
        'title': 'Science Fiction Stories',
        'publisher': 'SciFi Network',
        'thumbnail': 'https://picsum.photos/seed/podcast5/200',
        'description_original':
            'Explore amazing science fiction stories from renowned authors.',
      },
      {
        'id': 'podcast-6',
        'title': 'Business Daily',
        'publisher': 'Business News Co',
        'thumbnail': 'https://picsum.photos/seed/podcast6/200',
        'description_original': 'Your daily business news and market analysis.',
      },
    ];

    return {'count': allPodcasts.length, 'results': allPodcasts};
  }

  Map<String, dynamic> _getMockPodcastDetailResponse(String id) {
    // return {
    //   'id': id,
    //   'title': 'Tech Talk Daily',
    //   'publisher': 'Tech Media Inc',
    //   'image': 'https://picsum.photos/seed/$id/400',
    //   'description': 'Your daily dose of technology news and insights. We cover everything from startups to AI, blockchain to cloud computing. Join us every day for in-depth discussions with industry leaders.',
    //   'genre_ids': [127, 93],
    //   'episodes': [
    //     {
    //       'id': 'episode-1',
    //       'title': 'The Future of AI Development',
    //       'description': 'We discuss the latest trends in AI with leading researchers.',
    //       'pub_date_ms': 1702857600000, // Dec 18, 2023
    //       'audio_length_sec': 3600,
    //     },
    //     {
    //       'id': 'episode-2',
    //       'title': 'Cloud Computing in 2024',
    //       'description': 'What to expect from cloud providers this year.',
    //       'pub_date_ms': 1702771200000, // Dec 17, 2023
    //       'audio_length_sec': 2700,
    //     },
    //     {
    //       'id': 'episode-3',
    //       'title': 'Startup Funding Strategies',
    //       'description': 'How to approach investors and secure funding.',
    //       'pub_date_ms': 1702684800000, // Dec 16, 2023
    //       'audio_length_sec': 3300,
    //     },

    // Return different data based on the podcast ID
    switch (id) {
      case 'podcast-1':
      case 'hardcoded-1':
        return {
          'id': id,
          'title': 'Tech Talk Daily',
          'publisher': 'Tech Media Inc',
          'image': 'https://picsum.photos/seed/podcast1/400',
          'description':
              'Your daily dose of technology news and insights. We cover everything from startups to AI, blockchain to cloud computing. Join us every day for in-depth discussions with industry leaders.',
          'genre_ids': [127, 93],
          'episodes': [
            {
              'id': 'episode-1-1',
              'title': 'The Future of AI Development',
              'description':
                  'We discuss the latest trends in AI with leading researchers.',
              'pub_date_ms': 1702857600000, // Dec 18, 2023
              'audio_length_sec': 3600,
            },
            {
              'id': 'episode-1-2',
              'title': 'Cloud Computing in 2024',
              'description': 'What to expect from cloud providers this year.',
              'pub_date_ms': 1702771200000, // Dec 17, 2023
              'audio_length_sec': 2700,
            },
            {
              'id': 'episode-1-3',
              'title': 'Startup Funding Strategies',
              'description': 'How to approach investors and secure funding.',
              'pub_date_ms': 1702684800000, // Dec 16, 2023
              'audio_length_sec': 3300,
            },
            {
              'id': 'episode-1-4',
              'title': 'Mobile Development Trends',
              'description':
                  'Exploring Flutter, React Native, and native development.',
              'pub_date_ms': 1702598400000, // Dec 15, 2023
              'audio_length_sec': 2400,
            },
            {
              'id': 'episode-1-5',
              'title': 'Cybersecurity Best Practices',
              'description': 'Keeping your applications and data secure.',
              'pub_date_ms': 1702512000000, // Dec 14, 2023
              'audio_length_sec': 3000,
            },
          ],
        };

      case 'podcast-2':
      case 'hardcoded-2':
        return {
          'id': id,
          'title': 'The Science Show',
          'publisher': 'Science Network',
          'image': 'https://picsum.photos/seed/podcast2/400',
          'description':
              'Exploring the wonders of science, from quantum physics to biology. Each week, we dive deep into groundbreaking research and interview leading scientists about their discoveries.',
          'genre_ids': [107, 111],
          'episodes': [
            {
              'id': 'episode-2-1',
              'title': 'Quantum Computing Breakthrough',
              'description':
                  'Scientists achieve quantum supremacy in new experiments.',
              'pub_date_ms': 1702857600000, // Dec 18, 2023
              'audio_length_sec': 2800,
            },
            {
              'id': 'episode-2-2',
              'title': 'Climate Change Solutions',
              'description':
                  'Innovative approaches to reducing carbon emissions.',
              'pub_date_ms': 1702771200000, // Dec 17, 2023
              'audio_length_sec': 3200,
            },
            {
              'id': 'episode-2-3',
              'title': 'The Human Genome Project',
              'description':
                  'How genetic research is revolutionizing medicine.',
              'pub_date_ms': 1702684800000, // Dec 16, 2023
              'audio_length_sec': 2900,
            },
            {
              'id': 'episode-2-4',
              'title': 'Space Exploration Updates',
              'description': 'Latest missions to Mars and beyond.',
              'pub_date_ms': 1702598400000, // Dec 15, 2023
              'audio_length_sec': 3400,
            },
            {
              'id': 'episode-2-5',
              'title': 'Neuroscience and Consciousness',
              'description': 'Understanding how our brains create awareness.',
              'pub_date_ms': 1702512000000, // Dec 14, 2023
              'audio_length_sec': 3100,
            },
          ],
        };

      case 'podcast-3':
      case 'hardcoded-3':
        return {
          'id': id,
          'title': 'Business Builders',
          'publisher': 'Entrepreneur Media',
          'image': 'https://picsum.photos/seed/podcast3/400',
          'description':
              'Stories and strategies from successful entrepreneurs around the world. Learn how they built their businesses, overcame challenges, and achieved success.',
          'genre_ids': [93, 144],
          'episodes': [
            {
              'id': 'episode-3-1',
              'title': 'From Startup to Unicorn',
              'description':
                  'The journey of scaling a tech company to \$1B valuation.',
              'pub_date_ms': 1702857600000, // Dec 18, 2023
              'audio_length_sec': 4200,
            },
            {
              'id': 'episode-3-2',
              'title': 'Marketing on a Budget',
              'description':
                  'Cost-effective strategies for growing your brand.',
              'pub_date_ms': 1702771200000, // Dec 17, 2023
              'audio_length_sec': 2500,
            },
            {
              'id': 'episode-3-3',
              'title': 'Building a Remote Team',
              'description':
                  'Best practices for managing distributed workforces.',
              'pub_date_ms': 1702684800000, // Dec 16, 2023
              'audio_length_sec': 3600,
            },
            {
              'id': 'episode-3-4',
              'title': 'Product-Market Fit',
              'description': 'How to know when you have found it.',
              'pub_date_ms': 1702598400000, // Dec 15, 2023
              'audio_length_sec': 2800,
            },
            {
              'id': 'episode-3-5',
              'title': 'Exit Strategies',
              'description': 'Planning for acquisition or IPO.',
              'pub_date_ms': 1702512000000, // Dec 14, 2023
              'audio_length_sec': 3300,
            },
          ],
        };

      case 'podcast-4':
        return {
          'id': id,
          'title': 'Tech Innovations',
          'publisher': 'Innovation Weekly',
          'image': 'https://picsum.photos/seed/podcast4/400',
          'description':
              'Discover the latest technological innovations and breakthrough products. From AI to robotics, we cover it all.',
          'genre_ids': [127, 93],
          'episodes': [
            {
              'id': 'episode-4-1',
              'title': 'The Rise of Quantum Computing',
              'description': 'How quantum computers will change everything.',
              'pub_date_ms': 1702857600000,
              'audio_length_sec': 3000,
            },
            {
              'id': 'episode-4-2',
              'title': 'Robotics Revolution',
              'description': 'The future of automation and robotics.',
              'pub_date_ms': 1702771200000,
              'audio_length_sec': 2800,
            },
          ],
        };

      case 'podcast-5':
        return {
          'id': id,
          'title': 'Science Fiction Stories',
          'publisher': 'SciFi Network',
          'image': 'https://picsum.photos/seed/podcast5/400',
          'description':
              'Explore amazing science fiction stories from renowned authors. Journey to distant galaxies and alternate realities.',
          'genre_ids': [107, 133],
          'episodes': [
            {
              'id': 'episode-5-1',
              'title': 'The Time Traveler',
              'description': 'A journey through space and time.',
              'pub_date_ms': 1702857600000,
              'audio_length_sec': 4500,
            },
            {
              'id': 'episode-5-2',
              'title': 'Mars Colony Alpha',
              'description': 'Life on the first Mars settlement.',
              'pub_date_ms': 1702771200000,
              'audio_length_sec': 4000,
            },
          ],
        };

      case 'podcast-6':
        return {
          'id': id,
          'title': 'Business Daily',
          'publisher': 'Business News Co',
          'image': 'https://picsum.photos/seed/podcast6/400',
          'description':
              'Your daily business news and market analysis. Stay informed about the latest trends in finance and commerce.',
          'genre_ids': [93, 144],
          'episodes': [
            {
              'id': 'episode-6-1',
              'title': 'Stock Market Trends',
              'description': 'Analyzing this week\'s market movements.',
              'pub_date_ms': 1702857600000,
              'audio_length_sec': 1800,
            },
            {
              'id': 'episode-6-2',
              'title': 'Cryptocurrency Update',
              'description': 'Latest developments in digital currencies.',
              'pub_date_ms': 1702771200000,
              'audio_length_sec': 2100,
            },
          ],
        };

      default:
        // Fallback for any unknown ID
        return {
          'id': id,
          'title': 'Unknown Podcast',
          'publisher': 'Unknown Publisher',
          'image': 'https://picsum.photos/seed/$id/400',
          'description': 'Podcast details not available.',
          'genre_ids': [100],
          'episodes': [],
        };
    }
  }
}
