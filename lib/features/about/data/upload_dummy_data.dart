import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DummyDataUploader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadDummyData() async {
    try {
      // Check if Firebase is initialized
      if (!Firebase.apps.isNotEmpty) {
        throw Exception('Firebase is not initialized');
      }

      print('🔄 Starting dummy data upload...');
      print('📝 Preparing data...');

      // Create dummy About data
      final aboutData = {
        'name': 'John Doe',
        'title': 'Senior Flutter Developer',
        'description':
            'Passionate Flutter developer with 5+ years of experience in building cross-platform applications. Specialized in clean architecture, state management, and UI/UX design.',
        'skills': [
          'Flutter',
          'Dart',
          'Firebase',
          'REST APIs',
          'Clean Architecture',
          'GetX',
          'State Management',
          'UI/UX Design',
          'Git',
          'CI/CD',
        ],
        'profileImageUrl':
            'https://firebasestorage.googleapis.com/v0/b/portfolio-app-2025.appspot.com/o/profile_images%2Fprofile_image.png?alt=media&token=1234567890',
        'socialLinks': {
          'linkedin': 'https://linkedin.com/in/johndoe',
          'github': 'https://github.com/johndoe',
          'dribbble': 'https://dribbble.com/johndoe',
          'youtube': 'https://youtube.com/@johndoe',
        },
        'experiences': [
          {
            'company': 'Tech Corp',
            'position': 'Senior Flutter Developer',
            'period': '2021 - Present',
            'description':
                'Leading the development of multiple Flutter applications.',
            'achievements': [
              'Implemented clean architecture in 3 major projects',
              'Reduced app size by 40% through optimization',
              'Mentored 5 junior developers',
            ],
          },
          {
            'company': 'StartUp Inc',
            'position': 'Flutter Developer',
            'period': '2019 - 2021',
            'description':
                'Developed and maintained multiple Flutter applications.',
            'achievements': [
              'Built 5 production apps from scratch',
              'Integrated Firebase services',
              'Implemented CI/CD pipeline',
            ],
          },
        ],
        'education': [
          {
            'institution': 'University of Technology',
            'degree': 'Bachelor of Computer Science',
            'period': '2015 - 2019',
            'description':
                'Specialized in Mobile Development and Software Engineering',
          },
        ],
      };

      print('📤 Attempting to upload to Firestore...');
      print('📍 Collection: about, Document: profile');

      // Upload to Firestore
      await _firestore.collection('about').doc('profile').set(aboutData);
      print('✅ Dummy data uploaded successfully!');
    } catch (e, stackTrace) {
      print('❌ Error uploading dummy data:');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> deleteDummyData() async {
    try {
      print('🔄 Starting dummy data deletion...');
      await _firestore.collection('about').doc('profile').delete();
      print('✅ Dummy data deleted successfully!');
    } catch (e, stackTrace) {
      print('❌ Error deleting dummy data:');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}

// Example usage:
// void main() async {
//   final uploader = DummyDataUploader();
//   
//   // Upload dummy data
//   await uploader.uploadDummyData();
//   
//   // Delete dummy data when done
//   // await uploader.deleteDummyData();
// } 