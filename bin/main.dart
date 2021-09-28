import 'dart:io';

import 'package:args/args.dart';
import 'package:any_icon_maker/any_icon_maker.dart';
import 'package:yaml/yaml.dart';

Future<void> main(List<String> args) async {
  final parser = ArgParser();
  parser.addFlag(
    'help',
    abbr: 'h',
    negatable: false,
  );
  parser.addOption(
    'icon',
    valueHelp: 'path',
    defaultsTo: 'app_icon_1024.png',
    help: 'Path to app_icon_1024.png.',
  );
  parser.addOption(
    'output',
    abbr: 'o',
    valueHelp: 'path',
    help: 'The output path (defaults to stdout)',
  );

  final options = parser.parse(args);

  if (options['help'] == true || options.rest.isEmpty) {
    print('Usage: any_icon_maker app_icon_1024.png\n');
    print(parser.usage);
    return;
  }

  File configFile = File('any_icon_maker.yaml');
  final configYaml = loadYaml(configFile.readAsStringSync());
  List<ImageSet> imageSetList = (configYaml['image_sets'] as List)
      .map((e) => ImageSet.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  final anyIconMaker = AnyIconMaker();
  await anyIconMaker.make(
    options['icon'],
    options['output'],
    imageSetList,
  );
}
