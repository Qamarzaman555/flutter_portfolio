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
      print('🔄 Fetching about data from Firestore...');
      final docRef = _firestore.collection('about').doc('profile');
      final doc = await docRef.get();

      if (!doc.exists) {
        print('❌ About document does not exist');
        throw 'About data not found';
      }

      final data = doc.data();
      print('📄 Raw Firestore data: $data');

      if (data == null) {
        print('❌ Document data is null');
        throw 'About data is null';
      }

      try {
        final about = About.fromFirestore(doc);
        print('✅ Successfully parsed About object:');
        print('  - Name: ${about.name}');
        print('  - Title: ${about.title}');
        print('  - Skills count: ${about.skills.length}');
        print('  - Experiences count: ${about.experiences.length}');
        print('  - Education count: ${about.education.length}');
        print('  - Profile Image URL: ${about.profileImageUrl}');
        return about;
      } catch (parseError, stackTrace) {
        print('❌ Error parsing About data:');
        print('Error: $parseError');
        print('Stack trace: $stackTrace');
        throw 'Failed to parse about data: $parseError';
      }
    } catch (e, stackTrace) {
      print('❌ Error fetching about data:');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      throw 'Failed to fetch about data: $e';
    }
  }

  // Projects data
  Future<List<Project>> getProjects() async {
    try {
      print('Fetching projects from Firestore...');
      final snapshot =
          await _firestore.collection('projects').orderBy('order').get();

      print('Found ${snapshot.docs.length} projects');
      final projects = snapshot.docs.map((doc) {
        print('Processing project: ${doc.id}');
        print('Project data: ${doc.data()}');
        return Project.fromFirestore(doc);
      }).toList();

      print('Successfully parsed ${projects.length} projects');
      return projects;
    } catch (e, stackTrace) {
      print('Error fetching projects: $e');
      print('Stack trace: $stackTrace');
      throw 'Failed to fetch projects: $e';
    }
  }

  // Image caching
  Future<String> getCachedImageUrl(String imagePath) async {
    try {
      print('🖼️ Getting cached image URL for: $imagePath');

      if (imagePath.isEmpty) {
        print('⚠️ Image path is empty');
        return '';
      }

      // Check if the URL is already a full URL
      if (imagePath.startsWith('http')) {
        print('📥 URL is already a full URL, downloading directly');
        try {
          final file = await _cacheManager.downloadFile(imagePath);
          print('✅ Image downloaded successfully to: ${file.file.path}');
          return imagePath;
        } catch (e) {
          print('❌ Error downloading image from URL: $e');
          return imagePath; // Return the URL even if caching fails
        }
      }

      // If it's a storage path, get the download URL
      print('📥 Getting download URL from Firebase Storage');
      final ref = _storage.ref().child(imagePath);
      final url = await ref.getDownloadURL();
      print('✅ Got download URL: $url');

      try {
        print('📥 Downloading and caching image...');
        final file = await _cacheManager.downloadFile(url);
        print('✅ Image cached successfully at: ${file.file.path}');
        return url;
      } catch (e) {
        print('❌ Error caching image: $e');
        return url; // Return the URL even if caching fails
      }
    } catch (e, stackTrace) {
      print('❌ Error in getCachedImageUrl:');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return imagePath; // Return the original path if everything fails
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
