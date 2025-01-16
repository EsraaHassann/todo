import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/ThemeProvider.dart';
import '../widgets/drawer_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isNotificationsEnabled = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color.fromARGB(255, 136, 185, 189),
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Dark Mode Toggle
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),

            // Notifications Toggle
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: _isNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _isNotificationsEnabled = value;
                });
              },
            ),

            // Reset Settings Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isNotificationsEnabled = true;
                  _selectedLanguage = 'English';
                });
                themeProvider.toggleTheme(false); // Reset to light mode
              },
              child: const Text('Reset Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
