import 'package:flutter/material.dart';

const Map<String, Color> categoryColors = {
  'Musculoskeletal: Upper Extremity & Spine': Color(0xFF3B82F6), // blue
  'Musculoskeletal: Lower Extremity': Color(0xFF6366F1),         // indigo
  'Neurology: TBI': Color(0xFFA855F7),                           // purple
  'Neurology: Cerebrovascular Accident (CVA)': Color(0xFFC084FC), // light purple
  'Neurology: SCI': Color(0xFF8B5CF6),                           // violet
  'Neurology: Miscellaneous': Color(0xFFD946EF),                 // fuchsia
  'Electrodiagnostic Medicine (EDX)': Color(0xFF14B8A6),         // teal
  'Pediatrics': Color(0xFFF472B6),                               // pink
  'Prosthetics & Orthotics': Color(0xFF06B6D4),                  // cyan
  'Cardiopulmonary & Cancer Rehabilitation': Color(0xFFEF4444),  // red
  'Pain Medicine': Color(0xFFF59E0B),                            // amber
  'Rheumatology': Color(0xFF22C55E),                             // green
  'Physical Modalities': Color(0xFF0EA5E9),                      // sky
  'Miscellaneous': Color(0xFF9CA3AF),                            // gray
};

Color getCategoryColor(String category) =>
    categoryColors[category] ?? const Color(0xFF9CA3AF);

const Map<String, String> categoryShortNames = {
  'Musculoskeletal: Upper Extremity & Spine': 'MSK: Upper/Spine',
  'Musculoskeletal: Lower Extremity': 'MSK: Lower',
  'Neurology: TBI': 'TBI',
  'Neurology: Cerebrovascular Accident (CVA)': 'CVA',
  'Neurology: SCI': 'SCI',
  'Neurology: Miscellaneous': 'Neuro: Misc',
  'Electrodiagnostic Medicine (EDX)': 'EDX',
  'Cardiopulmonary & Cancer Rehabilitation': 'Cardio/Cancer',
  'Prosthetics & Orthotics': 'P&O',
  'Pain Medicine': 'Pain',
  'Physical Modalities': 'Modalities',
};

String getCategoryShortName(String category) =>
    categoryShortNames[category] ?? category;
