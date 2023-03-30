import 'package:get_it/get_it.dart';

final get = GetIt.instance;

class IoCContainer {
  IoCContainer._();

  static void initialize() {
    // get.registerSingleton(SomeService());
  }
}
