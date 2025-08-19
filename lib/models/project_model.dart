import 'package:flutter/material.dart';

class ProjectModel {
  final IconData icon;
  final String title;
  final String description;
  final String? subtitle; // Tambahkan properti subtitle untuk header
  final Color color;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final String? imageUrl;
  final String? role; // Tambahkan properti untuk detail studi kasus
  final String? duration; // Tambahkan properti untuk detail studi kasus
  final String? tools; // Tambahkan properti untuk detail studi kasus
  final String? problemTitle; // Tambahkan properti untuk studi kasus
  final String? problemDescription; // Tambahkan properti untuk studi kasus
  final String? goalTitle; // Tambahkan properti untuk studi kasus
  final String? goalDescription; // Tambahkan properti untuk studi kasus
  final List<Map<String, dynamic>>?
  designProcess; // Tambahkan properti untuk proses desain
  final List<Map<String, String>>?
  previewImages; // Tambahkan properti untuk gambar pratinjau

  ProjectModel({
    required this.icon,
    required this.title,
    required this.description,
    required this.subtitle,
    required this.color,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    this.imageUrl,
    this.role,
    this.duration,
    this.tools,
    this.problemTitle,
    this.problemDescription,
    this.goalTitle,
    this.goalDescription,
    this.designProcess,
    this.previewImages,
  });
}
