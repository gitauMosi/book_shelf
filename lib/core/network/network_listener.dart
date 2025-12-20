import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/network_providers.dart';

class NetworkListener extends ConsumerStatefulWidget {
  final Widget child;

  const NetworkListener({super.key, required this.child});

  @override
  ConsumerState<NetworkListener> createState() => _NetworkListenerState();
}

class _NetworkListenerState extends ConsumerState<NetworkListener> {
  bool _showConnectionLostNotification = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupNetworkListener();
    });
  }

  void _setupNetworkListener() {
    final networkService = ref.read(networkServiceProvider);
    networkService.connectionStatus.listen((isConnected) {
      _handleNetworkChange(isConnected);
    });
  }

  void _handleNetworkChange(bool isConnected) {
    if (!isConnected && _showConnectionLostNotification) {
      _showOfflineNotification();
    } else if (isConnected) {
      _showOnlineNotification();
    }
  }

  void _showOfflineNotification() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.wifi_off, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Connection Lost - Please check your internet',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(days: 1),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Theme.of(context).colorScheme.onError,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            setState(() {
              _showConnectionLostNotification = false;
            });
          },
        ),
      ),
    );
  }

  void _showOnlineNotification() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.wifi, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Internet Connection Restored',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );

    setState(() {
      _showConnectionLostNotification = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
