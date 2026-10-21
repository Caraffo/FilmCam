import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/fade_scale_route.dart';
import '../../../../core/widgets/motion_switcher.dart';
import '../../../camera/presentation/capture_providers.dart';
import '../../data/gallery_item.dart';
import '../../data/gallery_photo.dart';
import '../gallery_providers.dart';
import '../widgets/delete_photos.dart';
import '../widgets/empty_gallery_message.dart';
import '../widgets/gallery_access_message.dart';
import '../widgets/gallery_grid_tile.dart';
import 'photo_viewer_screen.dart';

const int _columns = 3;
const double _gridSpacing = 2;

/// Grilla con todas las fotos del álbum de FilmCam, de la más nueva a la
/// más vieja. Tocar abre una foto; mantener apretado entra en modo
/// selección para borrar varias.
class GalleryScreen extends ConsumerStatefulWidget {
  const GalleryScreen({super.key});

  static Route<void> route() => fadeScaleRoute((_) => const GalleryScreen());

  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {
  /// Ids de las fotos elegidas; null fuera del modo selección.
  Set<String>? _selected;

  bool get _selecting => _selected != null;

  void _startSelection(GalleryPhoto photo) {
    HapticFeedback.mediumImpact();
    setState(() => _selected = {photo.asset.id});
  }

  void _toggle(GalleryPhoto photo) {
    HapticFeedback.selectionClick();
    final selected = {...?_selected};
    if (!selected.remove(photo.asset.id)) selected.add(photo.asset.id);
    setState(() => _selected = selected);
  }

  void _exitSelection() => setState(() => _selected = null);

  Future<void> _deleteSelected(List<GalleryPhoto> photos) async {
    final selected = _selected ?? const {};
    final chosen = photos.where((p) => selected.contains(p.asset.id)).toList();
    final deleted = await confirmAndDeletePhotos(context, ref, chosen);
    if (deleted > 0 && mounted) _exitSelection();
  }

  void _onItemTap(GalleryItem item, int index) {
    switch (item) {
      case AlbumPhotoItem(:final photo) when _selecting:
        _toggle(photo);
      case PendingCaptureItem() when _selecting:
        break;
      default:
        Navigator.of(
          context,
        ).push(PhotoViewerScreen.route(initialIndex: index));
    }
  }

  @override
  Widget build(BuildContext context) {
    final photosAsync = ref.watch(galleryPhotosProvider);
    final photos = photosAsync.value ?? const <GalleryPhoto>[];
    final items = buildGalleryItems(ref.watch(captureProvider), photos);
    final selected = _selected ?? const <String>{};
    final allSelected = photos.isNotEmpty && selected.length == photos.length;

    final Widget body;
    if (items.isEmpty) {
      body = photosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => GalleryAccessMessage(error: error),
        data: (_) => const EmptyGalleryMessage(),
      );
    } else {
      body = GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _columns,
          mainAxisSpacing: _gridSpacing,
          crossAxisSpacing: _gridSpacing,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GalleryGridTile(
            key: switch (item) {
              PendingCaptureItem(:final capture) => ValueKey(
                'pending-${capture.id}',
              ),
              AlbumPhotoItem(:final photo) => ValueKey(photo.asset.id),
            },
            item: item,
            index: index,
            selecting: _selecting,
            selected: switch (item) {
              AlbumPhotoItem(:final photo) => selected.contains(photo.asset.id),
              PendingCaptureItem() => false,
            },
            onTap: () => _onItemTap(item, index),
            onLongPress: switch (item) {
              AlbumPhotoItem(:final photo) when !_selecting =>
                () => _startSelection(photo),
              _ => null,
            },
          );
        },
      );
    }

    return PopScope(
      canPop: !_selecting,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _exitSelection();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: _selecting
              ? IconButton(
                  tooltip: 'Cancelar selección',
                  onPressed: _exitSelection,
                  icon: const Icon(CupertinoIcons.xmark),
                )
              : IconButton(
                  tooltip: 'Volver a la cámara',
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(CupertinoIcons.chevron_down),
                ),
          title: MotionSwitcher(
            offset: 0.5,
            child: Text(
              _selecting
                  ? selected.isEmpty
                        ? 'Elegí fotos'
                        : '${selected.length} seleccionadas'
                  : 'Galería',
              key: ValueKey((_selecting, selected.length)),
            ),
          ),
          actions: [
            if (_selecting) ...[
              TextButton(
                onPressed: () => setState(
                  () => _selected = allSelected
                      ? {}
                      : {for (final p in photos) p.asset.id},
                ),
                child: Text(allSelected ? 'Ninguna' : 'Todas'),
              ),
              IconButton(
                tooltip: 'Borrar',
                onPressed: selected.isEmpty
                    ? null
                    : () => _deleteSelected(photos),
                icon: const Icon(CupertinoIcons.trash),
              ),
            ] else if (photos.isNotEmpty)
              TextButton(
                onPressed: () => setState(() => _selected = {}),
                child: const Text('Elegir'),
              ),
          ],
        ),
        body: body,
      ),
    );
  }
}
