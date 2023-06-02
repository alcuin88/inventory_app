import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primaryContainer,
                  colorScheme.primaryContainer.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: darkMode ? const AssetImage("assets/logos/logo_dark_mode.png") : const AssetImage("assets/logos/logo_light_mode.png"),
                  height: 200,
                  width: 200,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.inventory_2_outlined,
              size: 26,
              color: colorScheme.onBackground,
            ),
            title: Text(
              "Inventory",
              style: textTheme.titleSmall!.copyWith(
                color: colorScheme.onBackground,
                fontSize: 24,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
              color: colorScheme.onBackground,
            ),
            title: Text(
              "Filters",
              style: textTheme.titleSmall!.copyWith(
                color: colorScheme.onBackground,
                fontSize: 24,
              ),
            ),
            onTap: () {},
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    size: 26,
                    color: colorScheme.error,
                  ),
                  title: Text(
                    "Logout",
                    style: textTheme.titleSmall!.copyWith(
                      color: colorScheme.error,
                      fontSize: 24,
                    ),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
