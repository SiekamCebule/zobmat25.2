import 'package:zobmat25_2/feature/navigation/domain/entity/navigation_entry.dart';
import 'package:zobmat25_2/feature/navigation/domain/repository/navigation_repository.dart';

class GetNavigationEntryUseCase {
  const GetNavigationEntryUseCase({required this.navigationRepository});

  final NavigationRepository navigationRepository;

  Future<NavigationEntry> call() async {
    return await navigationRepository.getCurrentEntry();
  }
}
