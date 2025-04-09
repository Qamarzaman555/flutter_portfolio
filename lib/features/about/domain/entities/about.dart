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
    final data = doc.data() as Map<String, dynamic>;
    return About(
      name: data['name'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      skills: List<String>.from(data['skills'] ?? []),
      profileImageUrl: data['profileImageUrl'] ?? '',
      socialLinks: Map<String, String>.from(data['socialLinks'] ?? {}),
      experiences: (data['experiences'] as List<dynamic>?)
              ?.map((e) => Experience.fromMap(e))
              .toList() ??
          [],
      education: (data['education'] as List<dynamic>?)
              ?.map((e) => Education.fromMap(e))
              .toList() ??
          [],
    );
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
    return Experience(
      company: map['company'] ?? '',
      position: map['position'] ?? '',
      period: map['period'] ?? '',
      description: map['description'] ?? '',
      achievements: List<String>.from(map['achievements'] ?? []),
    );
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
    return Education(
      institution: map['institution'] ?? '',
      degree: map['degree'] ?? '',
      period: map['period'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
