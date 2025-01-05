import 'package:zobmat25_2/feature/navigation/domain/entity/navigation_entry.dart';

abstract interface class InMemoryNavigationDataSource {
  Future<NavigationEntry> get();
  Future<void> set(NavigationEntry entry);
}

class InMemoryNavigationDataSourceImpl implements InMemoryNavigationDataSource {
  InMemoryNavigationDataSourceImpl({required NavigationEntry initial}) : _entry = initial;

  NavigationEntry _entry;

  @override
  Future<NavigationEntry> get() async => _entry;

  @override
  Future<void> set(NavigationEntry entry) async => _entry = entry;
}
