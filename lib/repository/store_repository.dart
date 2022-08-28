import 'package:objectbox/objectbox.dart' as objectbox;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:flutter_objectbox_example/objectbox.g.dart';

/// Repository to initilialize the ObjectBox Store object
class StoreRepository {
  late final objectbox.Store _store;

  /// Initializes the ObjectBox Store object.
  Future<void> initStore() async {
    final appDocumentsDirextory =
        await path_provider.getApplicationDocumentsDirectory();

    _store = Store(
      getObjectBoxModel(),
      directory: path.join(appDocumentsDirextory.path, 'expense-db'),
    );

    return;
  }

  /// Getter for the store object.
  objectbox.Store get store => _store;
}
