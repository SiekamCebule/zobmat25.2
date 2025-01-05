import 'package:zobmat25_2/feature/navigation/data/data_source/in_memory_navigation_data_source.dart';
import 'package:zobmat25_2/feature/navigation/domain/entity/navigation_entry.dart';
import 'package:zobmat25_2/feature/navigation/domain/repository/navigation_repository.dart';

class InMemoryNavigationRepository implements NavigationRepository {
  InMemoryNavigationRepository({required this.dataSource});

  InMemoryNavigationDataSource dataSource;

  @override
  Future<void> goTo(NavigationEntry entry) async {
    await dataSource.set(entry);
  }

  @override
  Future<NavigationEntry> getCurrentEntry() async => await dataSource.get();
}
