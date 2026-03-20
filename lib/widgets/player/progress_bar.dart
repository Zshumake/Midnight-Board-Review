import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/audio_provider.dart';
import '../../utils/theme.dart';
import '../../utils/formatters.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audio, _) {
        final posMs = audio.position.inMilliseconds.toDouble();
        final durMs = audio.duration.inMilliseconds.toDouble();
        final max = durMs > 0 ? durMs : 1.0;
        // Use drag value while dragging, otherwise use actual position
        final value = (_dragValue ?? posMs).clamp(0.0, max);

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
                onChangeStart: (_) {
                  audio.setDragging(true);
                },
                onChanged: (val) {
                  setState(() => _dragValue = val);
                },
                onChangeEnd: (val) {
                  audio.setDragging(false);
                  audio.seekTo(Duration(milliseconds: val.toInt()));
                  setState(() => _dragValue = null);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _dragValue != null
                          ? formatDuration(
                              Duration(milliseconds: _dragValue!.toInt()))
                          : formatDuration(audio.position),
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
