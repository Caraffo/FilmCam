import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/fade_scale_route.dart';
import '../../../camera/presentation/capture_providers.dart';
import '../../data/gallery_item.dart';
import '../../data/gallery_photo.dart';
import '../gallery_providers.dart';
import '../widgets/gallery_access_message.dart';
import '../widgets/gallery_photo_page.dart';
import '../widgets/pending_capture_page.dart';

const double _dismissVelocity = 700;

/// Las fotos de la galería en grande, de a una, deslizando entre ellas.
/// Arranca en [initialIndex] (0 es la más nueva o la recién sacada).
class PhotoViewerScreen extends ConsumerStatefulWidget {
  const PhotoViewerScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  static Route<void> route({int initialIndex = 0}) =>
      fadeScaleRoute((_) => PhotoViewerScreen(initialIndex: initialIndex));

  @override
  ConsumerState<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends ConsumerState<PhotoViewerScreen> {
  late final _pageController = PageController(initialPage: widget.initialIndex);
  late int _page = widget.initialIndex;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Después de guardar una edición, la foto nueva queda primera.
  void _showNewest() {
    if (_pageController.hasClients) _pageController.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    final photosAsync = ref.watch(galleryPhotosProvider);
    final photos = photosAsync.value ?? const <GalleryPhoto>[];
    final items = buildGalleryItems(ref.watch(captureProvider), photos);
    final total = items.length;

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
        itemBuilder: (context, index) => switch (items[index]) {
          PendingCaptureItem(:final capture) => PendingCapturePage(
            key: ValueKey('pending-${capture.id}'),
            photo: capture,
          ),
          AlbumPhotoItem(:final photo) => GalleryPhotoPage(
            key: ValueKey(photo.asset.id),
            photo: photo,
            onEdited: _showNewest,
          ),
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
                    tooltip: 'Volver',
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
