import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../domain/repositories/settings_repository.dart';
import 'setting_state.dart';

class SettingsNotifier extends Notifier<SettingState> {
  late final SettingsRepository _repository;

  @override
  SettingState build() {
    _repository = ref.read(settingsRepositoryProvider);

    _loadFromDb();

    return SettingState(
      isDarkMode: false,
      isNotificationAllowed: true,
      isNewUser: true,
      fontSize: false,
      isLoading: true,
    );
  }

  Future<void> _loadFromDb() async {
    try {
      
      final darkMode = await _repository.getIsDarkMode();
      final notifications = await _repository.getIsNotificationAllowed();
      final fontSize = await _repository.getFontSize();
      final isNewUser = await _repository.getisNewUser();

      state = state.copyWith(
        isDarkMode: darkMode,
        isNotificationAllowed: notifications,
        fontSize: fontSize,
        isNewUser: isNewUser,
        isLoading: false,
        hasError: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        error: e.toString(),
      );
    }
  }

  // ───────── Save to DB ─────────
  Future<void> toggleDarkMode(bool value) async {
    state = state.copyWith(isDarkMode: value);
    await _repository.setIsDarkMode(value);
  }

  Future<void> toggleNotifications(bool value) async {
    state = state.copyWith(isNotificationAllowed: value);
    await _repository.setIsNotificationAllowed(value);
  }

  Future<void> toggleFontSize(bool value) async {
    state = state.copyWith(fontSize: value);
    await _repository.setFontSize(value);
  }

  Future<void> registerUser() async {
    state = state.copyWith(isNewUser: false);
    await _repository.setisNewUser(false);
  }

  Future<bool> isNewUser() async {
    return await _repository.getisNewUser();
  }
}
