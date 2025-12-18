# Flutter Riverpod Provider Modification Fix Plan

## Issue Analysis
The error occurs because `loadMoreBooks()` is called directly inside the `ListView.builder`'s `itemBuilder` method, which executes during the widget tree building process. This violates Flutter Riverpod's rules for modifying providers.

## Root Cause
In `lib/features/home/views/home_screen.dart`, line in `_buildBody` method:
```dart
ref.read(homeProvider.notifier).loadMoreBooks();
```
This is called inside `itemBuilder` of `ListView.builder`, causing the provider modification during build.

## Solution Plan

### Option 1: Use ScrollController (Preferred)
- Add a ScrollController to the ListView
- Add a scroll listener that detects when user is near the end
- Trigger `loadMoreBooks()` from the scroll listener
- This is the standard approach for pagination

### Option 2: Use Future.microtask
- Keep the current ListView structure
- Wrap the `loadMoreBooks()` call in `Future.microtask()`
- This defers the provider modification until after build completes

## Implementation Steps
1. **Modify HomeScreen**: Add ScrollController and scroll listener
2. **Update ListView**: Replace manual "load more" detection with scroll-based detection
3. **Clean up**: Remove the manual loading indicator logic from itemBuilder
4. **Test**: Ensure pagination works correctly

## Files to be Modified
- `lib/features/home/views/home_screen.dart` - Main fix implementation

## Expected Result
- No more provider modification during build errors
- Smooth pagination experience for users
- Proper loading states for pagination

## Validation
- Test scrolling to trigger pagination
- Verify no errors in console
- Ensure proper loading states during pagination
