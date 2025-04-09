import 'package:cloud_firestore/cloud_firestore.dart';

class About {
  final String name;
  final String title;
  final String description;
  final List<String> skills;
  final String profileImageUrl;
  final Map<String, String> socialLinks;
  final List<Experience> experiences;
  final List<Education> education;

  About({
    required this.name,
    required this.title,
    required this.description,
    required this.skills,
    required this.profileImageUrl,
    required this.socialLinks,
    required this.experiences,
    required this.education,
  });

  factory About.fromFirestore(DocumentSnapshot doc) {
    try {
      final data = doc.data() as Map<String, dynamic>;
      print('📝 Parsing About data from Firestore:');
      print('  Raw data: $data');

      // Parse skills
      final skillsList = data['skills'] as List<dynamic>?;
      final skills = skillsList?.map((e) => e.toString()).toList() ?? [];
      print('  Skills parsed: $skills');

      // Parse social links
      final socialLinksMap = data['socialLinks'] as Map<String, dynamic>?;
      final socialLinks = socialLinksMap?.map(
            (key, value) => MapEntry(key, value.toString()),
          ) ??
          {};
      print('  Social links parsed: $socialLinks');

      // Parse experiences
      final experiencesList = data['experiences'] as List<dynamic>?;
      final experiences = experiencesList
              ?.map((e) => Experience.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [];
      print('  Experiences parsed: ${experiences.length}');

      // Parse education
      final educationList = data['education'] as List<dynamic>?;
      final education = educationList
              ?.map((e) => Education.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [];
      print('  Education parsed: ${education.length}');

      return About(
        name: data['name']?.toString() ?? '',
        title: data['title']?.toString() ?? '',
        description: data['description']?.toString() ?? '',
        skills: skills,
        profileImageUrl: data['profileImageUrl']?.toString() ?? '',
        socialLinks: socialLinks,
        experiences: experiences,
        education: education,
      );
    } catch (e, stackTrace) {
      print('❌ Error in About.fromFirestore:');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}

class Experience {
  final String company;
  final String position;
  final String period;
  final String description;
  final List<String> achievements;

  Experience({
    required this.company,
    required this.position,
    required this.period,
    required this.description,
    required this.achievements,
  });

  factory Experience.fromMap(Map<String, dynamic> map) {
    try {
      final achievementsList = map['achievements'] as List<dynamic>?;
      final achievements =
          achievementsList?.map((e) => e.toString()).toList() ?? [];

      return Experience(
        company: map['company']?.toString() ?? '',
        position: map['position']?.toString() ?? '',
        period: map['period']?.toString() ?? '',
        description: map['description']?.toString() ?? '',
        achievements: achievements,
      );
    } catch (e, stackTrace) {
      print('❌ Error in Experience.fromMap:');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}

class Education {
  final String institution;
  final String degree;
  final String period;
  final String description;

  Education({
    required this.institution,
    required this.degree,
    required this.period,
    required this.description,
  });

  factory Education.fromMap(Map<String, dynamic> map) {
    try {
      return Education(
        institution: map['institution']?.toString() ?? '',
        degree: map['degree']?.toString() ?? '',
        period: map['period']?.toString() ?? '',
        description: map['description']?.toString() ?? '',
      );
    } catch (e, stackTrace) {
      print('❌ Error in Education.fromMap:');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
