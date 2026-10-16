import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/fade_scale_route.dart';
import '../../../camera/data/captured_photo.dart';
import '../../../camera/presentation/capture_providers.dart';
import '../../data/gallery_photo.dart';
import '../gallery_providers.dart';
import '../widgets/gallery_access_message.dart';
import '../widgets/gallery_photo_page.dart';
import '../widgets/pending_capture_page.dart';

const double _dismissVelocity = 700;

/// Todas las fotos del álbum de FilmCam, empezando por la más nueva. Si hay
/// una foto recién sacada que todavía se está revelando, va primero.
class GalleryScreen extends ConsumerStatefulWidget {
  const GalleryScreen({super.key});

  static Route<void> route() => fadeScaleRoute((_) => const GalleryScreen());

  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {
  final _pageController = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Después de guardar una edición, la foto nueva queda primera.
  void _showNewest() {
    if (_pageController.hasClients) _pageController.jumpToPage(0);
  }

  static bool _isPending(CapturedPhoto? capture, List<GalleryPhoto> photos) {
    if (capture == null) return false;
    final key = capture.galleryKey;
    return key == null || !photos.any((p) => p.key == key);
  }

  @override
  Widget build(BuildContext context) {
    final photosAsync = ref.watch(galleryPhotosProvider);
    final photos = photosAsync.value ?? const <GalleryPhoto>[];
    final capture = ref.watch(captureProvider);
    final pending = _isPending(capture, photos) ? capture : null;
    final total = photos.length + (pending == null ? 0 : 1);

    final Widget body;
    if (total == 0) {
      body = photosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => GalleryAccessMessage(error: error),
        data: (_) => const Center(child: Text('Todavía no hay fotos')),
      );
    } else {
      body = PageView.builder(
        controller: _pageController,
        itemCount: total,
        onPageChanged: (page) => setState(() => _page = page),
        itemBuilder: (context, index) {
          if (pending != null && index == 0) {
            return PendingCapturePage(photo: pending);
          }
          final photo = photos[index - (pending == null ? 0 : 1)];
          return GalleryPhotoPage(
            key: ValueKey(photo.asset.id),
            photo: photo,
            onEdited: _showNewest,
          );
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragEnd: (d) {
            if ((d.primaryVelocity ?? 0) > _dismissVelocity) {
              Navigator.of(context).pop();
            }
          },
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    tooltip: 'Volver a la cámara',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(CupertinoIcons.chevron_down),
                  ),
                  const Spacer(),
                  if (total > 0)
                    Text(
                      '${(_page + 1).clamp(1, total)} de $total',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  const SizedBox(width: Spacing.m),
                ],
              ),
              Expanded(child: body),
            ],
          ),
        ),
      ),
    );
  }
}
