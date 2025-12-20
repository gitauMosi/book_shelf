
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bookmark_notifier.dart';
import 'bookmark_state.dart';

final bookmarkProvider =
    NotifierProvider<BookmarkNotifier, BookmarkState>(BookmarkNotifier.new);