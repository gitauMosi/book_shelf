import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _subHeaderText('Personalization'),
              _groubCard(
                children: [
                  _CustomTile(
                    title: "Account",
                    leadingIcon: Icons.person_outline,
                    ontap: () {
                      // Navigate to account settings
                    },
                  ),
                  _CustomTile(
                    title: "Notifications",
                    leadingIcon: Icons.notifications_outlined,
                    ontap: () {
                      // Navigate to notification settings
                    },
                  ),
                ],
              ),

              _subHeaderText('APPEARANCE'),
              _groubCard(
                children: [
                  _CustomTile(
                    title: "Theme",
                    leadingIcon: Icons.brightness_6_outlined,
                    ontap: () {
                      // Navigate to theme settings
                    },
                  ),
                  _CustomTile(
                    title: "Font Size",
                    leadingIcon: Icons.font_download_outlined,
                    ontap: () {
                      // Navigate to font size settings
                    },
                  ),
                ],
              ),

              _subHeaderText('ABOUT'),
              _groubCard(
                children: [
                  _CustomTile(
                    leadingIcon: Icons.info_outline,
                    title: 'About App',
                    ontap: () {
                      _showAboutDialog(context);
                    },
                  ),

                  _CustomTile(
                    leadingIcon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    ontap: () {
                      // Navigate to privacy policy
                    },
                  ),

                  _CustomTile(
                    leadingIcon: Icons.description_outlined,
                    title: 'Terms of Service',
                    ontap: () {
                      // Navigate to terms of service
                    },
                  ),
                ],
              ),

              Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                elevation: 0,
                child: _CustomTile(
                  leadingIcon: Icons.system_update_outlined,
                  title: "Check Updates",
                  ontap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _groubCard({required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 0,
      child: Column(children: children),
    );
  }

  Padding _subHeaderText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 12),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About App'),
        content: const Text('${AppStrings.appName}\nVersion 1.0.0'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _CustomTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Function()? ontap;
  const _CustomTile({
    required this.title,
    required this.leadingIcon,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(leadingIcon, size: 16,),),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: ontap,
    );
  }
}
