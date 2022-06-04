import 'package:educational_quiz_app/view/settings/settings_controller.dart';
import 'package:flutter/material.dart';

//import 'package:dev_quiz/core/app_colors.dart';
import 'package:educational_quiz_app/core/core.dart';
import 'package:provider/provider.dart';

class ChartWidget extends StatefulWidget {
  final double percent;

  const ChartWidget({
    Key? key,
    required this.percent,
  }) : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget>
    with SingleTickerProviderStateMixin {
  // tipo late: indicamos que so vamos inicializa-lo depois
  late AnimationController _controller;
  late Animation<double> _animation;

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // a principio essa Tween eh aquela animacao que vai "crescendo" de um valor inicial a um valor final
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.percent,
    ).animate(_controller);

    _controller.forward(); // para a animacao "ir para a frente"
  }

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return SizedBox(
      height: 80,
      width: 80,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) => Stack(
          children: [
            Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: _animation.value,
                  backgroundColor: AppColors.chartSecondary,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.chartPrimary),
                ),
              ),
            ),
            Center(
              child: Text(
                "${(_animation.value * 100).toStringAsFixed(0)}%",
                style: AppTextStyles.heading.copyWith(
                  color: settingsController.currentAppTheme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
