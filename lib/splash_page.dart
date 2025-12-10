import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:substrack/core/widgets/loading_jump_indicator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AnimationController _exitController;

  @override
  void initState() {
    super.initState();
    _onNavigate();
  }

  void _onNavigate() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    _exitController.forward();

    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FadeOut(
            manualTrigger: true,
            controller: (controller) => _exitController = controller,
            duration: const Duration(milliseconds: 800),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Image.asset('assets/subtrackLogo.png', width: 200),
                ),

                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: JumpingDotsLoader(
                    dotColor: colorscheme.primary,
                    dotSize: 15.0,
                    duration: const Duration(milliseconds: 800),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
