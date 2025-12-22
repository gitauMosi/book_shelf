import '../../core/constants/db_constants.dart';
import '../../core/services/db_client.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._db);

  final DbClient _db;


  

  @override
  Future<bool> getIsDarkMode() async {
    return _db.get(
      key: DbConstantsKeys.darkModeKey,
      defaultValue: false,
    ) as bool;
  }

  @override
  Future<void> setIsDarkMode(bool value) async {
    await _db.add(
      key: DbConstantsKeys.darkModeKey,
      value: value,
    );
  }

  @override
  Future<bool> getIsNotificationAllowed() async {
    return _db.get(
      key: DbConstantsKeys.notificationsKey,
      defaultValue: true,
    ) as bool;
  }

  @override
  Future<void> setIsNotificationAllowed(bool value) async {
    await _db.add(
      key: DbConstantsKeys.notificationsKey,
      value: value,
    );
  }

  @override
  Future<bool> getFontSize() async {
    return _db.get(
      key: DbConstantsKeys.fontSizeKey,
      defaultValue: false,
    ) as bool;
  }

  @override
  Future<void> setFontSize(bool value) async {
    await _db.add(
      key: DbConstantsKeys.fontSizeKey,
      value: value,
    );
  }
  
  @override
  Future<bool> getisNewUser() async {
    return _db.get(
      key: DbConstantsKeys.isNewUserKey,
      defaultValue: true,
    ) as bool;
  }
  
  @override
  Future<void> setisNewUser(bool value) async {
    await _db.add(
      key: DbConstantsKeys.isNewUserKey,
      value: value,
    );
  }
}
