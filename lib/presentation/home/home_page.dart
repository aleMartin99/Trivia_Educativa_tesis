import 'dart:developer';

import 'package:trivia_educativa/core/app_routes.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/data/models/user_model.dart';
import 'package:trivia_educativa/presentation/home/home_controller.dart';
import 'package:trivia_educativa/presentation/home/home_state.dart';
import 'package:trivia_educativa/presentation/home/widgets/appbar/app_bar_widget.dart';
import 'package:trivia_educativa/presentation/home/widgets/asignatura_card/asignatura_card_widget.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  // final cont

  void _loadData() async {
    await controller.getNotasProv();
    await controller.getAsignaturas();
    //  await controller.getProfesores();
    // await controller.getCursos();
  }

  @override
  initState() {
    _loadData();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(controller.toString());
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    if (controller.state == HomeState.success) {
      //TODO make validation for data to all pages like asignatura(home)
      if (controller.asignaturas == null) {
        return Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                child: Column(
                  children: [
                    Image.asset(AppImages.error),
//TODO I10n
                    const Text('No existen Asignaturas'),
                  ],
                ),
                //  height: 500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
              child: Text(
                I10n.of(context).problem_Subjects,
                style: AppTextStyles.heading15,
              ),
            )
          ],
        ));
      } else {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              backgroundColor:
                  settingsController.currentAppTheme.scaffoldBackgroundColor,
              //TODO put the correct color. from theme
              //  settingsController.currentAppTheme.scaffoldBackgroundColor,
              appBar: AppBarWidget(
                //*cambie el usuario ya que lo cargo del login y lo paso x paramtros
                user: widget.user,
                notasProv: controller.notasProv!,
                context: context,
                settingsController: settingsController,
              ),
              //TODO check loading condition
              body: (controller.state == HomeState.loading)
                  ? const Center(
                      child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
                    ))
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: GridView.count(
                          physics: const BouncingScrollPhysics(),
                          childAspectRatio: 1.2,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 16,
                          children: controller.asignaturas!
                              .map((asignatura) => AsignaturaCardWidget(
                                    nombre: asignatura.descripcion,
                                    //TODO hacer validaciones para cosas vacias
                                    cantTemas:
                                        asignatura.cursos.last.temas.length,
                                    cursos: asignatura.cursos,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.temaRoute,
                                          arguments: TemaPageArgs(
                                              idAsignatura: asignatura.id,
                                              idCurso:
                                                  asignatura.cursos.last.id,
                                              temas: asignatura
                                                  .cursos.last.temas));
                                    },
                                  ))
                              .toList(),
                        ),
                      ),
                    )),
        );
      }
    }
    return const Center(
        child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
    ));
  }
}