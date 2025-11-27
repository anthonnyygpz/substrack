import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:substrack/feactures/settings/presentation/pages/settings_page.dart';
import 'package:substrack/feactures/subscriptions/presentation/pages/add_page.dart';
import 'package:substrack/feactures/subscriptions/presentation/pages/subscription_list_page.dart';

class TabNavigation extends StatefulWidget {
  const TabNavigation({super.key});

  @override
  State<TabNavigation> createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  late PersistentTabController controller;
  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: PersistentTabView(
        controller: controller,
        gestureNavigationEnabled: true,
        tabs: [
          PersistentTabConfig(
            screen: const SubcriptionListPage(),
            item: ItemConfig(
              iconSize: 28,
              icon: const Icon(Icons.subscriptions),
              title: "Suscripciones",
              activeForegroundColor: colorscheme.primary,
              inactiveForegroundColor: colorscheme.onSurface,
            ),
          ),

          PersistentTabConfig(
            screen: AddOrEditPage(tabController: controller),
            item: ItemConfig(
              iconSize: 28,
              icon: const Icon(Icons.add_circle_outline_rounded),
              title: "Agregar",
              activeForegroundColor: colorscheme.primary,
              inactiveForegroundColor: colorscheme.onSurface,
            ),
          ),

          PersistentTabConfig(
            screen: const SettingsPage(),
            item: ItemConfig(
              iconSize: 28,
              title: "Configuraciones",
              icon: const Icon(Icons.settings),
              activeForegroundColor: colorscheme.primary,
              inactiveForegroundColor: colorscheme.onSurface,
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style4BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            color: colorscheme.surface,
            border: Border(
              top: BorderSide(color: colorscheme.surfaceContainer),
            ),
          ),
        ),
      ),
    );
  }
}
