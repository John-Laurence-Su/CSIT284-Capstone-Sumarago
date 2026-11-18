import 'package:flutter/widgets.dart';

import 'library_service.dart';

/// Makes [LibraryService] available to the whole widget tree.
/// Widgets that call [LibraryScope.of] rebuild when the service changes.
class LibraryScope extends InheritedNotifier<LibraryService> {
  const LibraryScope({
    super.key,
    required LibraryService service,
    required super.child,
  }) : super(notifier: service);

  static LibraryService of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LibraryScope>();
    assert(scope != null, 'LibraryScope not found in widget tree');
    return scope!.notifier!;
  }
}
