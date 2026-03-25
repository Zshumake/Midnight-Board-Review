import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../services/storage_service.dart';
import '../utils/theme.dart';
import '../widgets/primitives/animated_appear.dart';
import '../widgets/primitives/app_card.dart';
import '../widgets/player/main_player.dart';
import '../widgets/player/sticky_player.dart';
import '../widgets/library/category_tabs.dart';
import '../widgets/library/search_bar.dart';
import '../widgets/library/episode_list.dart';
import '../widgets/modals/info_modal.dart';
import '../widgets/modals/report_modal.dart';
import '../widgets/modals/rss_modal.dart';
import '../widgets/modals/auth_button.dart';

class HomeScreen extends StatefulWidget {
  final int? initialEpisode;
  final double? initialTime;

  const HomeScreen({super.key, this.initialEpisode, this.initialTime});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  bool _showStickyPlayer = false;
  bool _bockenekMode = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final storage = context.read<StorageService>();
      setState(() {
        _bockenekMode = storage.isBockenekMode();
      });

      if (!storage.hasSeenInfo()) {
        InfoModal.show(context).then((_) => storage.markInfoSeen());
      }

      if (widget.initialEpisode != null) {
        final audio = context.read<AudioProvider>();
        audio.loadEpisode(widget.initialEpisode!).then((_) {
          if (widget.initialTime != null && widget.initialTime! > 0) {
            audio.seekTo(Duration(seconds: widget.initialTime!.toInt()));
          }
        });
      }
    });
  }

  void _onScroll() {
    final show = _scrollController.offset > 400;
    if (show != _showStickyPlayer) {
      setState(() => _showStickyPlayer = show);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Ambient background glow — layered
          Positioned.fill(
            child: Container(color: AppColors.bgCharcoal),
          ),
          Positioned(
            top: -120,
            left: 0,
            right: 0,
            height: 600,
            child: Container(
              decoration: const BoxDecoration(gradient: AppColors.heroGradient),
            ),
          ),
          // Subtle secondary glow at bottom
          Positioned(
            bottom: -200,
            left: 0,
            right: 0,
            height: 400,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomCenter,
                  radius: 1.5,
                  colors: [
                    AppColors.accentAmber.withValues(alpha: 0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          if (_bockenekMode) const _FloatingHeads(),

          // Main scrollable content
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Responsive.maxContentWidth(context),
              ),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // Collapsing app bar
                  SliverAppBar(
                    expandedHeight: 72,
                    floating: true,
                    snap: true,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        'Midnight Board Review',
                        style: AppTypography.headlineSm(context).copyWith(
                          fontSize: 17,
                        ),
                      ),
                      centerTitle: true,
                    ),
                    actions: [
                      const AuthButton(),
                      const SizedBox(width: Spacing.xs),
                      IconButton(
                        icon: const Icon(Icons.rss_feed_rounded, size: 20),
                        onPressed: () => RssModal.show(context),
                        tooltip: 'RSS Feed',
                      ),
                      IconButton(
                        icon: const Icon(Icons.info_outline_rounded, size: 20),
                        onPressed: () => InfoModal.show(context),
                        tooltip: 'Info',
                      ),
                      const SizedBox(width: Spacing.sm),
                    ],
                  ),

                  // Body content
                  SliverPadding(
                    padding: EdgeInsets.only(
                        bottom: _showStickyPlayer ? 90 : Spacing.xl),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Player hero
                        AnimatedAppear(
                          delay: const Duration(milliseconds: 100),
                          child: const MainPlayer(),
                        ),
                        const SizedBox(height: Spacing.xl),

                        // Categories
                        AnimatedAppear(
                          delay: const Duration(milliseconds: 200),
                          child: const CategoryTabs(),
                        ),

                        // Search
                        AnimatedAppear(
                          delay: const Duration(milliseconds: 250),
                          child: const EpisodeSearchBar(),
                        ),
                        const SizedBox(height: Spacing.sm),

                        // Episode list
                        const EpisodeList(),
                        const SizedBox(height: Spacing.xxl),

                        // RSS section
                        AnimatedAppear(
                          delay: const Duration(milliseconds: 300),
                          child: _buildRssSection(context),
                        ),

                        // Footer
                        _buildFooter(context),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sticky player
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            left: 0,
            right: 0,
            bottom: _showStickyPlayer ? 0 : -100,
            child: const StickyPlayer(),
          ),
        ],
      ),
    );
  }

  Widget _buildRssSection(BuildContext context) {
    final hPad = Responsive.horizontalPadding(context);

    return AppCard(
      gradient: true,
      margin: EdgeInsets.symmetric(horizontal: hPad),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(Spacing.md),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentAmber.withValues(alpha: 0.08),
            ),
            child: const Icon(Icons.rss_feed_rounded,
                color: AppColors.accentAmber, size: 28),
          ),
          const SizedBox(height: Spacing.md),
          Text('Listen on Your Favorite Podcast App',
              style: AppTypography.headlineSm(context),
              textAlign: TextAlign.center),
          const SizedBox(height: Spacing.lg),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => RssModal.show(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.xl, vertical: Spacing.md),
                decoration: BoxDecoration(
                  gradient: AppColors.amberGradient,
                  borderRadius: BorderRadius.circular(Radii.sm),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentAmber.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.copy_rounded, color: Colors.white, size: 16),
                    SizedBox(width: Spacing.sm),
                    Text('Get RSS Feed URL',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Spacing.xxl, horizontal: Spacing.lg),
      child: Column(
        children: [
          // Divider
          Container(
            width: 40,
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.borderSubtle,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: Spacing.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _footerLink('Report Issue', () => ReportModal.show(context)),
              _dot(),
              _footerLink(
                _bockenekMode ? 'Bockenek: ON' : 'Bockenek',
                _toggleBockenek,
                highlight: _bockenekMode,
              ),
            ],
          ),
          const SizedBox(height: Spacing.sm),
          Text('Version 3.0.0',
              style: AppTypography.labelSm(context)),
        ],
      ),
    );
  }

  Widget _footerLink(String text, VoidCallback onTap,
      {bool highlight = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Spacing.sm, vertical: Spacing.xs),
          child: Text(
            text,
            style: TextStyle(
              color: highlight ? AppColors.accentGold : AppColors.textFaint,
              fontSize: 12,
              fontWeight: highlight ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _dot() {
    return Container(
      width: 3,
      height: 3,
      margin: const EdgeInsets.symmetric(horizontal: Spacing.sm),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.textFaint,
      ),
    );
  }

  void _toggleBockenek() async {
    setState(() => _bockenekMode = !_bockenekMode);
    final storage = context.read<StorageService>();
    await storage.setBockenekMode(_bockenekMode);
  }
}

// Bockenek floating heads easter egg
class _FloatingHeads extends StatefulWidget {
  const _FloatingHeads();

  @override
  State<_FloatingHeads> createState() => _FloatingHeadsState();
}

class _FloatingHeadsState extends State<_FloatingHeads>
    with TickerProviderStateMixin {
  late final List<_HeadData> _heads;

  @override
  void initState() {
    super.initState();
    _heads = List.generate(6, (i) {
      final controller = AnimationController(
        duration: Duration(seconds: 8 + i * 3),
        vsync: this,
      )..repeat();
      return _HeadData(
        controller: controller,
        startX: (i * 0.17) % 1.0,
        size: 40.0 + (i % 3) * 15,
      );
    });
  }

  @override
  void dispose() {
    for (final h in _heads) {
      h.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: _heads.map((h) {
          return AnimatedBuilder(
            animation: h.controller,
            builder: (context, child) {
              final screenWidth = MediaQuery.of(context).size.width;
              final screenHeight = MediaQuery.of(context).size.height;
              final progress = h.controller.value;
              final x =
                  h.startX * screenWidth + 20 * math.sin(progress * 6.28);
              final y = screenHeight * (1 - progress);

              return Positioned(
                left: x,
                top: y,
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    'assets/Bockenek.png',
                    width: h.size,
                    height: h.size,
                    errorBuilder: (_, e, st) => Icon(Icons.face,
                        size: h.size, color: AppColors.accentAmber),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class _HeadData {
  final AnimationController controller;
  final double startX;
  final double size;

  _HeadData({
    required this.controller,
    required this.startX,
    required this.size,
  });
}
