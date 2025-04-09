import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:portfolio/features/about/domain/entities/about.dart';
import 'package:portfolio/features/work/domain/entities/project.dart';

class FirebaseService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final DefaultCacheManager _cacheManager = DefaultCacheManager();

  // About data
  Future<About> getAboutData() async {
    try {
      print('Fetching about data from Firestore...');
      final docRef = _firestore.collection('about').doc('profile');
      final doc = await docRef.get();

      if (!doc.exists) {
        print('About document does not exist');
        throw 'About data not found';
      }

      print('About document data: ${doc.data()}');
      final about = About.fromFirestore(doc);
      print('Parsed About object: name=${about.name}, title=${about.title}');
      return about;
    } catch (e, stackTrace) {
      print('Error fetching about data: $e');
      print('Stack trace: $stackTrace');
      throw 'Failed to fetch about data: $e';
    }
  }

  // Projects data
  Future<List<Project>> getProjects() async {
    try {
      final snapshot =
          await _firestore.collection('projects').orderBy('order').get();
      return snapshot.docs.map((doc) => Project.fromFirestore(doc)).toList();
    } catch (e) {
      throw 'Failed to fetch projects: $e';
    }
  }

  // Image caching
  Future<String> getCachedImageUrl(String imagePath) async {
    try {
      final ref = _storage.ref().child(imagePath);
      final url = await ref.getDownloadURL();

      // Cache the image
      await _cacheManager.downloadFile(url);

      return url;
    } catch (e) {
      throw 'Failed to get image URL: $e';
    }
  }

  // Preload images for a project
  Future<void> preloadProjectImages(Project project) async {
    try {
      if (project.imageUrl.isNotEmpty) {
        await _cacheManager.downloadFile(project.imageUrl);
      }
      // Add more image preloading if needed (e.g., project gallery images)
    } catch (e) {
      print('Failed to preload project images: $e');
    }
  }

  // Clear cache
  Future<void> clearCache() async {
    await _cacheManager.emptyCache();
  }
}
