import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final List<String> galleryImages;
  final int order;
  final Map<String, dynamic>? features;
  final String? category;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    required this.galleryImages,
    required this.order,
    this.features,
    this.category,
  });

  factory Project.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Project(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      technologies: List<String>.from(data['technologies'] ?? []),
      githubUrl: data['githubUrl'],
      liveUrl: data['liveUrl'],
      galleryImages: List<String>.from(data['galleryImages'] ?? []),
      order: data['order'] ?? 0,
      features: data['features'],
      category: data['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'technologies': technologies,
      'githubUrl': githubUrl,
      'liveUrl': liveUrl,
      'galleryImages': galleryImages,
      'order': order,
      'features': features,
      'category': category,
    };
  }
}
