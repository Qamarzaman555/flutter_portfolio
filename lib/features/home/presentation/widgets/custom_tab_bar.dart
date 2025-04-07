import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final Function(int) onTap;
  final TabController? controller;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabs,
      onTap: onTap,
      labelColor: Theme.of(context).colorScheme.primary,
      unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
      indicatorColor: Theme.of(context).colorScheme.primary,
      indicatorWeight: 3,
    );
  }
} 