import 'package:get/get.dart';
import 'package:komikku/modules/details_module/binding.dart';
import 'package:komikku/modules/home_module/binding.dart';
import 'package:komikku/modules/login_module/binding.dart';
import 'package:komikku/modules/reading_module/binding.dart';
import 'package:komikku/modules/search_module/binding.dart';
import 'package:komikku/modules/shell_module/binding.dart';
import 'package:komikku/modules/subscribes_module/binding.dart';
import 'package:komikku/modules/details_module/page.dart';
import 'package:komikku/modules/login_module/page.dart';
import 'package:komikku/modules/reading_module/page.dart';
import 'package:komikku/modules/search_module/page.dart';
import 'package:komikku/modules/shell_module/page.dart';

part 'routes.dart';

class AppPages {
  static const initial = AppRoutes.shell;

  static final pages = [
    /// Shell
    GetPage(
      name: AppRoutes.shell,
      page: () => const Shell(),
      bindings: [
        ShellBindings(),
        HomeBindings(),
        SubscribesBindings(),
        LoginBindings(),
      ],
    ),

    /// Login
    GetPage(
      name: AppRoutes.login,
      page: () => const Login(),
      bindings: [
        LoginBindings(),
      ],
    ),

    /// Search
    GetPage(
      name: AppRoutes.search,
      page: () => const Search(),
      binding: SearchBindings(),
    ),

    /// Details
    GetPage(
      name: AppRoutes.details,
      page: () => const Details(),
      binding: DetailsBindings(),
      children: [
        /// Reading
        GetPage(
          name: AppRoutes.reading,
          page: () => const Reading(),
          binding: ReadingBindings(),
        ),
      ],
    ),
  ];
}
