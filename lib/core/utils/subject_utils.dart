
import 'package:flutter/material.dart';

IconData getSubjectIcon(String subject) {
  switch (subject.toLowerCase()) {
    case 'mathematics':
      return Icons.calculate;
    case 'physics':
      return Icons.rocket_launch;
    case 'chemistry':
      return Icons.science;
    case 'biology':
      return Icons.psychology;
    case 'computer science':
      return Icons.computer;
    case 'english':
      return Icons.menu_book;
    case 'history':
      return Icons.history_edu;
    case 'geography':
      return Icons.public;
    case 'economics':
      return Icons.trending_up;
    case 'business studies':
      return Icons.business;
    case 'psychology':
      return Icons.psychology_outlined;
    case 'art':
      return Icons.palette;
    case 'music':
      return Icons.music_note;
    case 'physical education':
      return Icons.sports_soccer;
    case 'foreign languages':
      return Icons.language;
    default:
      return Icons.school;
  }
}