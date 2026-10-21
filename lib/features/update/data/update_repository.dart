import 'dart:convert';
import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Release que publica GitHub Actions (ver .github/workflows/build-apk.yml).
const String _releaseBase =
    'https://github.com/Caraffo/FilmCam/releases/download/apk-latest';
const String _updateJsonUrl = '$_releaseBase/update.json';
const String _apkUrl = '$_releaseBase/filmcam-latest.apk';
const String _apkFileName = 'filmcam-latest.apk';
const String _apkMimeType = 'application/vnd.android.package-archive';
const Duration _connectTimeout = Duration(seconds: 15);
const Duration _downloadTimeout = Duration(minutes: 5);

/// Una APK de menos de esto es una descarga cortada o una página de error.
const int _minApkBytes = 1024 * 1024;

/// Versión publicada en el release.
class RemoteBuild {
  const RemoteBuild({required this.buildNumber, required this.versionName});

  factory RemoteBuild.fromJson(Map<String, dynamic> json) => RemoteBuild(
    buildNumber: json['buildNumber'] as int,
    versionName: json['versionName'] as String,
  );

  final int buildNumber;
  final String versionName;
}

/// Busca la última APK publicada, la baja y abre el instalador de Android.
class UpdateRepository {
  Future<int> installedBuildNumber() async =>
      int.parse((await PackageInfo.fromPlatform()).buildNumber);

  Future<RemoteBuild> fetchLatest() async {
    // El parámetro evita que una caché intermedia devuelva un JSON viejo.
    final uri = Uri.parse(
      '$_updateJsonUrl?t=${DateTime.now().millisecondsSinceEpoch}',
    );
    final body = await _get(uri, (response) async {
      return response.transform(utf8.decoder).join();
    });
    return RemoteBuild.fromJson(jsonDecode(body) as Map<String, dynamic>);
  }

  /// Baja la APK a la caché de la app (siempre el mismo archivo, así no se
  /// acumulan) e informa el avance de 0 a 1 en [onProgress].
  Future<File> download({void Function(double progress)? onProgress}) async {
    final file = File('${(await getTemporaryDirectory()).path}/$_apkFileName');
    await _get(Uri.parse(_apkUrl), (response) async {
      final total = response.contentLength;
      var received = 0;
      final sink = file.openWrite();
      try {
        await for (final chunk in response) {
          sink.add(chunk);
          received += chunk.length;
          if (total > 0) onProgress?.call(received / total);
        }
      } finally {
        await sink.close();
      }
    });
    if (await file.length() < _minApkBytes) {
      throw const HttpException('La descarga de la actualización se cortó.');
    }
    return file;
  }

  /// Abre el instalador. La primera vez Android pide permitir instalar apps
  /// desde FilmCam.
  Future<void> install(File apk) async {
    final permission = await Permission.requestInstallPackages.request();
    if (!permission.isGranted) {
      await openAppSettings();
      throw StateError(
        'Para actualizar, permití que FilmCam instale apps y volvé a probar.',
      );
    }
    final result = await OpenFilex.open(apk.path, type: _apkMimeType);
    if (result.type != ResultType.done) {
      throw StateError('No se pudo abrir el instalador: ${result.message}');
    }
  }

  Future<T> _get<T>(
    Uri uri,
    Future<T> Function(HttpClientResponse response) read,
  ) async {
    final client = HttpClient()..connectionTimeout = _connectTimeout;
    try {
      final request = await client.getUrl(uri);
      final response = await request.close().timeout(_downloadTimeout);
      if (response.statusCode != HttpStatus.ok) {
        throw HttpException(
          'GitHub respondió ${response.statusCode} al buscar la actualización.',
          uri: uri,
        );
      }
      return await read(response).timeout(_downloadTimeout);
    } finally {
      client.close(force: true);
    }
  }
}
