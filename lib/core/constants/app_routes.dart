import 'package:get/get.dart';
import 'package:portfolio/features/home/presentation/bindings/home_binding.dart';
import 'package:portfolio/features/work/presentation/bindings/work_binding.dart';
import 'package:portfolio/features/about/presentation/bindings/about_binding.dart';
import 'package:portfolio/features/contact/presentation/bindings/contact_binding.dart';
import 'package:portfolio/features/home/presentation/pages/home_page.dart';
import 'package:portfolio/features/work/presentation/pages/work_page.dart';
import 'package:portfolio/features/about/presentation/pages/about_page.dart';
import 'package:portfolio/features/contact/presentation/pages/contact_page.dart';
import 'package:portfolio/features/splash/presentation/pages/splash_page.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.work,
      page: () => const WorkPage(),
      binding: WorkBinding(),
    ),
    GetPage(
      name: Routes.about,
      page: () => const AboutPage(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: Routes.contact,
      page: () => const ContactPage(),
      binding: ContactBinding(),
    ),
  ];
}

abstract class Routes {
  Routes._();
  static const splash = '/splash';
  static const home = '/home';
  static const work = '/work';
  static const about = '/about';
  static const contact = '/contact';
} 