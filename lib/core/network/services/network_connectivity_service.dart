import 'dart:async';
import 'dart:io';

enum InternetStatus { connected, disconnected }

class InternetConnectionCheckerPlus {
  final StreamController<InternetStatus> _statusController =
      StreamController<InternetStatus>.broadcast();
  Timer? _periodicTimer;
  InternetStatus _currentStatus = InternetStatus.connected;

  InternetConnectionCheckerPlus() {
    _startMonitoring();
  }

  void _startMonitoring() {
    // Check immediately
    _checkConnection();

    // Check periodically every 10 seconds
    _periodicTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _checkConnection();
    });
  }

  Future<void> _checkConnection() async {
    final bool newStatus = await _performRealConnectionCheck();
    final InternetStatus newInternetStatus = newStatus
        ? InternetStatus.connected
        : InternetStatus.disconnected;

    if (newInternetStatus != _currentStatus) {
      _currentStatus = newInternetStatus;
      _statusController.add(newInternetStatus);
    }
  }

  Future<bool> _performRealConnectionCheck() async {
    try {
      // Method 1: Try to lookup a reliable host
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (_) {
      // Method 2: Try another reliable host if first fails
      try {
        final result = await InternetAddress.lookup(
          'cloudflare.com',
        ).timeout(const Duration(seconds: 5));
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } catch (_) {
        return false;
      }
    }
  }

  Stream<InternetStatus> get onStatusChange => _statusController.stream;

  Future<bool> get hasConnection async => await _performRealConnectionCheck();

  Future<InternetStatus> get connectionStatus async {
    final connected = await _performRealConnectionCheck();
    return connected ? InternetStatus.connected : InternetStatus.disconnected;
  }

  void dispose() {
    _periodicTimer?.cancel();
    _statusController.close();
  }
}

class NetworkConnectivityService {
  final InternetConnectionCheckerPlus _connectionChecker;
  final StreamController<bool> _connectionStatusController;

  bool _lastKnownStatus = true;
  StreamSubscription<InternetStatus>? _subscription;
  Timer? _periodicCheckTimer;

  NetworkConnectivityService()
    : _connectionChecker = InternetConnectionCheckerPlus(),
      _connectionStatusController = StreamController<bool>.broadcast() {
    _init();
  }

  void _init() {
    // Start monitoring connection changes
    _subscription = _connectionChecker.onStatusChange.listen(
      _handleStatusChange,
    );

    // Additional periodic check for reliability
    _periodicCheckTimer = Timer.periodic(const Duration(seconds: 15), (
      _,
    ) async {
      final currentStatus = await isConnectedToInternet();
      _updateStatus(currentStatus);
    });

    // Perform initial check
    _performInitialCheck();
  }

  Future<void> _performInitialCheck() async {
    try {
      final isConnected = await isConnectedToInternet();
      _updateStatus(isConnected);
    } catch (e) {
      _updateStatus(false);
    }
  }

  void _handleStatusChange(InternetStatus status) {
    final isConnected = status == InternetStatus.connected;
    _updateStatus(isConnected);
  }

  void _updateStatus(bool isConnected) {
    if (_lastKnownStatus != isConnected) {
      _lastKnownStatus = isConnected;
      _connectionStatusController.add(isConnected);
     // print('Network status changed: $isConnected');
    }
  }

  // Function that returns true/false if connected to internet
  Future<bool> isConnectedToInternet() async {
    try {
      return await _connectionChecker.hasConnection;
    } catch (e) {
      //print('Error checking connection: $e');
      return false;
    }
  }

  // Get detailed connection info
  Future<Map<String, dynamic>> getConnectionDetails() async {
    try {
      final hasConnection = await _connectionChecker.hasConnection;
      final status = await _connectionChecker.connectionStatus;

      return {
        'hasConnection': hasConnection,
        'status': status.toString(),
        'isConnected': status == InternetStatus.connected,
        'isDisconnected': status == InternetStatus.disconnected,
        'timestamp': DateTime.now(),
        'usingFallback': true,
      };
    } catch (e) {
      return {
        'hasConnection': false,
        'status': 'error',
        'error': e.toString(),
        'timestamp': DateTime.now(),
        'usingFallback': true,
      };
    }
  }

  // Stream for global notifications
  Stream<bool> get connectionStatus => _connectionStatusController.stream;

  // Get last known status
  bool get lastKnownStatus => _lastKnownStatus;

  void dispose() {
    _subscription?.cancel();
    _periodicCheckTimer?.cancel();
    _connectionStatusController.close();
    _connectionChecker.dispose();
  }
}
