import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../services/network_connectivity_service.dart';

// Main network service provider
final networkServiceProvider = Provider<NetworkConnectivityService>((ref) {
  final service = NetworkConnectivityService();
  ref.onDispose(() => service.dispose());
  return service;
});

// Stream provider for real-time connection status
final networkStatusStreamProvider = StreamProvider<bool>((ref) {
  return ref.watch(networkServiceProvider).connectionStatus;
});

// Future provider for one-time connection check
final networkStatusProvider = FutureProvider<bool>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  return networkService.isConnectedToInternet();
});

// Provider for detailed connection information
final detailedNetworkInfoProvider = FutureProvider<Map<String, dynamic>>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  return networkService.getConnectionDetails();
});

// State provider for manual refresh trigger
final refreshNetworkStatusProvider = StateProvider<int>((ref) => 0);

// Combined provider that refreshes when triggered
final currentNetworkStatusProvider = FutureProvider<bool>((ref) {
  ref.watch(refreshNetworkStatusProvider);
  final networkService = ref.watch(networkServiceProvider);
  return networkService.isConnectedToInternet();
});

// State provider to track if we should show connection lost notification
final showConnectionLostNotificationProvider = StateProvider<bool>((ref) => true);