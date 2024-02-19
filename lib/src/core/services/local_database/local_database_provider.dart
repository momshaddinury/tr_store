import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tr_store/src/core/services/local_database/local_database.dart';

part 'local_database_provider.g.dart';

@Riverpod(keepAlive: true)
LocalDatabase localDatabase(LocalDatabaseRef ref) {
  ref.onDispose(() {
    LocalDatabase().close();
  });

  return LocalDatabase();
}
