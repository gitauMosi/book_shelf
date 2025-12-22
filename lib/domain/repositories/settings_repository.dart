abstract class SettingsRepository {
  Future<bool> getIsDarkMode();
  Future<void> setIsDarkMode(bool value);

  Future<bool> getIsNotificationAllowed();
  Future<void> setIsNotificationAllowed(bool value);

  Future<bool> getFontSize();
  Future<void> setFontSize(bool value);

  Future<bool> getisNewUser();
  Future<void> setisNewUser(bool value);


}
