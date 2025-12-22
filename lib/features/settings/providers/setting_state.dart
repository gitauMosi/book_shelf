class SettingState {
  final bool isDarkMode;
  final bool isNotificationAllowed;
  final bool fontSize;
  final bool isNewUser;
  final bool isLoading;
  final bool hasError;
  final String? error;

  SettingState({
    required this.isDarkMode,
    required this.isNotificationAllowed,
    required this.fontSize,
    required this.isNewUser,
    this.isLoading = false,
    this.hasError = false,
    this.error,
  });

  SettingState copyWith({
    bool? isDarkMode,
    bool? isNotificationAllowed,
    bool? fontSize,
    bool? isNewUser,
    bool? isLoading,
    bool? hasError,
    String? error,
  }) {
    return SettingState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isNotificationAllowed:
          isNotificationAllowed ?? this.isNotificationAllowed,
      fontSize: fontSize ?? this.fontSize,
      isNewUser: isNewUser ?? this.isNewUser,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      error: error ?? this.error,
    );
  }
}
