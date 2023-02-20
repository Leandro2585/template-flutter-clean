import 'package:meta/meta.dart';

import 'package:flutter_clean/domain/entities/entities.dart';

enum MediaType {
  image,
  video,
}

class Story {
  final String url;
  final MediaType media;
  final Duration duration;
  final User user;

  Story({
    @required this.url,
    @required this.media,
    @required this.duration,
    @required this.user,
  });
}
