/// Exports episode data from Dart to JSON for the RSS generator.
/// Run: dart run scripts/export_episodes_json.dart

import 'dart:convert';
import 'dart:io';

// We can't import Flutter files directly, so we parse the Dart source.
void main() {
  final episodesFile =
      File('lib/data/episodes_data.dart').readAsStringSync();
  final descriptionsFile =
      File('lib/data/descriptions_data.dart').readAsStringSync();

  // Parse descriptions map
  final descriptions = <String, String>{};
  final descPattern =
      RegExp(r"'([^']+(?:\\.[^']*)*)':\s*'([^']*(?:\\.[^']*)*)'", dotAll: true);
  for (final match in descPattern.allMatches(descriptionsFile)) {
    final key = match.group(1)!.replaceAll("\\'", "'");
    final value = match.group(2)!.replaceAll("\\'", "'");
    descriptions[key] = value;
  }

  // Parse episodes
  final episodes = <Map<String, String>>[];
  final epPattern = RegExp(
    r"Episode\(\s*title:\s*'([^']+(?:\\.[^']*)*)',\s*url:\s*'([^']+)',\s*category:\s*'([^']+(?:\\.[^']*)*)'",
    dotAll: true,
  );

  for (final match in epPattern.allMatches(episodesFile)) {
    final title = match.group(1)!.replaceAll("\\'", "'");
    final url = match.group(2)!;
    final category = match.group(3)!.replaceAll("\\'", "'");
    final description = descriptions[title] ?? '';

    episodes.add({
      'title': title,
      'url': url,
      'category': category,
      'description': description,
    });
  }

  final output = const JsonEncoder.withIndent('  ').convert(episodes);
  File('scripts/episodes.json').writeAsStringSync(output);
  print('✅ Exported ${episodes.length} episodes to scripts/episodes.json');
}
