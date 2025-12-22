
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'setting_state.dart';
import 'settings_notifier.dart';

final settingsProvider =
    NotifierProvider<SettingsNotifier, SettingState>(
  SettingsNotifier.new,
);