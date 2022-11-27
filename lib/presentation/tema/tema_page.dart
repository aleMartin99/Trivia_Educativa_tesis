import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:provider/provider.dart';

import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/settings/settings_imports.dart';
import 'tema_imports.dart';
import '/../core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TemaPage extends StatefulWidget {
  const TemaPage(
      {Key? key,
      required this.asignatura,
      required this.idEstudiante,
      required this.notas})
      : super(key: key);
  final Asignatura asignatura;
  final String idEstudiante;
  final List<NotaProv> notas;

  @override
  _TemaPageState createState() => _TemaPageState();
}

class _TemaPageState extends State<TemaPage> {
  @override
  initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);
    bool _pinned = true;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              expandedHeight: 220,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            alignment: Alignment.centerLeft,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            padding: const EdgeInsets.all(0),
                            icon: Icon(
                              Icons.arrow_back,
                              size: 25,
                              color: settingsController
                                  .currentAppTheme.iconTheme.color,
                            )),
                        Text(
                          widget.asignatura.descripcion,
                          style: AppTextStyles.titleBold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              pinned: _pinned,
              floating: true,
              flexibleSpace: Container(
                padding: const EdgeInsets.only(top: 106),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).brightness == Brightness.light
                        ? AppColors.purple
                        : const Color.fromARGB(153, 81, 6, 255),
                    const Color(0xFF57B6E0),
                  ], stops: const [
                    0.0,
                    1.0
                  ], transform: const GradientRotation(2.13959913 * pi)),
                ),
                child: FlexibleSpaceBar(
                  background: GlassImage(
                    // height: 200,
                    width: double.infinity,
                    blur: 1.5,
                    image: widget.asignatura.networkImage
                        ? Image.network(
                            widget.asignatura.image,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            widget.asignatura.image,
                            fit: BoxFit.cover,
                          ),
                    overlayColor: Colors.white.withOpacity(0.1),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.blue.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(0),
                    shadowColor: Colors.white.withOpacity(0.24),
                  ),
                ),
              ),
            ),
            (widget.asignatura.temas.isNotEmpty)
                ? SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20),
                          child: Text(
                            //TODO I10n
                            'Temas',
                            style: AppTextStyles.titleBold.copyWith(
                              color: Theme.of(context).primaryIconTheme.color,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: ListView(
                            primary: false,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 0),
                            // crossAxisCount: 2,
                            // crossAxisSpacing: 16,
                            // mainAxisSpacing: 10,
                            // shrinkWrap: true,
                            //  padding: EdgeInsets.only(bottom: 1),
                            clipBehavior: Clip.antiAlias,
                            children: widget.asignatura.temas
                                .map((tema) => TemaCardWidget(
                                    nombre: tema.descripcion,
                                    cantNiveles: tema.niveles.length,
                                    onTap: () {
                                      //TODO hacer validacion para tema vacio
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.nivelRoute,
                                        arguments: NivelPageArgs(
                                            niveles: tema.niveles,
                                            notas: widget.notas,
                                            asignatura: widget.asignatura,
                                            idEstudiante: widget.idEstudiante,
                                            idTema: tema.id),
                                      );
                                    }))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(I10n.of(context).noData),
          ],
        ));
  }
}
