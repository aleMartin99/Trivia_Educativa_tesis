import 'package:flutter/foundation.dart';

//TODO change points system to amount of questions

class ChallengeController {
  final currentPageNotifier =
      ValueNotifier<int>(1); // notificador de pagina actual
  int get currentPage => currentPageNotifier.value;
  set currentPage(int value) => currentPageNotifier.value = value;

  int qtdRightAnswers = 0;
  //TODO remove points with new server
  int puntos = 0;
}