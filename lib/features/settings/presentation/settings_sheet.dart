import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/spacing.dart';
import '../data/app_setting.dart';
import 'settings_providers.dart';

Future<void> showSettingsSheet(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => const _SettingsSheet(),
    );

class _SettingsSheet extends StatelessWidget {
  const _SettingsSheet();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: Spacing.m),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SettingTile(
              setting: AppSetting.shutterSound,
              icon: CupertinoIcons.speaker_2,
              title: 'Sonido del obturador',
            ),
            _SettingTile(
              setting: AppSetting.openPhotoAfterCapture,
              icon: CupertinoIcons.photo,
              title: 'Abrir la foto al sacarla',
              subtitle: 'Apagado, podés sacar varias seguidas',
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingTile extends ConsumerWidget {
  const _SettingTile({
    required this.setting,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final AppSetting setting;
  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = settingProvider(setting);
    final value = ref.watch(provider);
    final subtitle = this.subtitle;
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
      trailing: CupertinoSwitch(
        value: value,
        activeTrackColor: Theme.of(context).colorScheme.primary,
        onChanged: ref.read(provider.notifier).set,
      ),
      onTap: () => ref.read(provider.notifier).set(!value),
    );
  }
}
