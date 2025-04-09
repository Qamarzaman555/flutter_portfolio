import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:portfolio/core/constants/app_routes.dart';
import 'package:portfolio/core/services/firebase_service.dart';
import 'package:portfolio/core/theme/app_theme.dart';
import 'package:portfolio/core/theme/theme_controller.dart';
// import 'package:portfolio/features/about/data/upload_dummy_data.dart';
import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    print('🔄 Initializing GetStorage...');
    await GetStorage.init();

    print('🔄 Initializing Firebase...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized successfully');

    print('🔄 Starting dummy data upload...');
    // final uploader = DummyDataUploader();
    // await uploader.uploadDummyData();
    print('✅ Dummy data upload completed');

    runApp(const MyApp());
  } catch (e, stackTrace) {
    print('❌ Error during initialization:');
    print('Error: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Portfolio',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(() {
        Get.put(ThemeController());
        Get.put(FirebaseService());
      }),
      debugShowCheckedModeBanner: false,
    );
  }
}
