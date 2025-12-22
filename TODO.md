# Splash Screen Troubleshooting Plan

## Problem Analysis
The app is stuck at splash screen without any error. The issue likely stems from:

1. **Database Initialization Race Condition**: `DbClient.init()` is called but not awaited, causing the splash screen to try reading from an uninitialized database
2. **Provider Dependency Chain**: The `settingsProvider` depends on `dbClientProvider` and `settingsRepositoryProvider`, but there's no guarantee the database is fully initialized
3. **Key Inconsistency**: Database key `isNewuser` vs expected `isNewUser` 
4. **Missing Error Handling**: Splash screen waits indefinitely if database operations fail

## Identified Issues

### 1. Database Initialization Problem
- **File**: `lib/core/providers/app_providers.dart`
- **Issue**: `dbClientProvider` calls `db.init()` without await
- **Impact**: Database operations may fail silently, keeping `isLoading = true`

### 2. Key Mismatch in Database Constants
- **File**: `lib/core/constants/db_constants.dart`
- **Issue**: `isNewUserKey = "isNewuser"` (lowercase 'u')
- **Impact**: Repository methods may return incorrect values

### 3. Splash Screen Logic Issue
- **File**: `lib/features/main/views/splash_screen.dart`
- **Issue**: No timeout or error handling for navigation
- **Impact**: Can get stuck indefinitely

## Solution Plan

### Step 1: Fix Database Initialization
- Modify `app_providers.dart` to properly await database initialization
- Ensure database is ready before providers that depend on it

### Step 2: Fix Database Key Consistency
- Update `db_constants.dart` to use consistent naming: `isNewUserKey`
- Verify all references use the same key

### Step 3: Add Error Handling and Timeout
- Add timeout mechanism to splash screen navigation
- Add error handling for database operations
- Show error messages if initialization fails

### Step 4: Test the Fixes
- Run the app and verify splash screen loads properly
- Test both new user and existing user flows

## Files to Modify
1. `lib/core/providers/app_providers.dart`
2. `lib/core/constants/db_constants.dart`
3. `lib/features/main/views/splash_screen.dart`
4. `lib/features/settings/providers/settings_notifier.dart` (if needed)

## Expected Outcome
- Splash screen should load within 3-5 seconds
- Navigation should work for both new and existing users
- Any errors should be visible to help with debugging
