import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/fade_scale_route.dart';
import '../../../camera/presentation/capture_providers.dart';
import '../../data/gallery_item.dart';
import '../../data/gallery_photo.dart';
import '../gallery_providers.dart';
import '../widgets/gallery_access_message.dart';
import '../widgets/gallery_grid_tile.dart';
import 'photo_viewer_screen.dart';

const int _columns = 3;
const double _gridSpacing = 2;

/// Grilla con todas las fotos del álbum de FilmCam, de la más nueva a la
/// más vieja. Al tocar una se abre en grande.
class GalleryScreen extends ConsumerWidget {
  const GalleryScreen({super.key});

  static Route<void> route() => fadeScaleRoute((_) => const GalleryScreen());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(galleryPhotosProvider);
    final items = buildGalleryItems(
      ref.watch(captureProvider),
      photosAsync.value ?? const <GalleryPhoto>[],
    );

    final Widget body;
    if (items.isEmpty) {
      body = photosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => GalleryAccessMessage(error: error),
        data: (_) => const Center(child: Text('Todavía no hay fotos')),
      );
    } else {
      body = GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _columns,
          mainAxisSpacing: _gridSpacing,
          crossAxisSpacing: _gridSpacing,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => GalleryGridTile(
          key: switch (items[index]) {
            PendingCaptureItem() => const ValueKey('pending'),
            AlbumPhotoItem(:final photo) => ValueKey(photo.asset.id),
          },
          item: items[index],
          index: index,
          onTap: () => Navigator.of(
            context,
          ).push(PhotoViewerScreen.route(initialIndex: index)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Volver a la cámara',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(CupertinoIcons.chevron_down),
        ),
        title: const Text('Galería'),
      ),
      body: body,
    );
  }
}
