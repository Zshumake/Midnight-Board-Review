import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/audio_provider.dart';
import '../../utils/theme.dart';
import '../../utils/formatters.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audio, _) {
        final posMs = audio.position.inMilliseconds.toDouble();
        final durMs = audio.duration.inMilliseconds.toDouble();
        final max = durMs > 0 ? durMs : 1.0;
        final value = posMs.clamp(0.0, max);

        return Semantics(
          label: 'Playback progress',
          slider: true,
          value:
              '${formatDuration(audio.position)} of ${formatDuration(audio.duration)}',
          child: Column(
            children: [
              Slider(
                value: value,
                max: max,
                onChangeStart: (_) => audio.setDragging(true),
                onChanged: (val) {
                  audio.seekTo(Duration(milliseconds: val.toInt()));
                },
                onChangeEnd: (val) {
                  audio.setDragging(false);
                  audio.seekTo(Duration(milliseconds: val.toInt()));
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(audio.position),
                      style: AppTypography.mono(context),
                    ),
                    Text(
                      formatDuration(audio.duration),
                      style: AppTypography.mono(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
