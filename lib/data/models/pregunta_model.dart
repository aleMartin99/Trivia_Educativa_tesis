import 'package:educational_quiz_app/data/models/answer_model.dart';

class Pregunta {
  late String id;
  late String descripcion;
  // late String respuestaIncorrecta1;
  // late String respuestaCorrecta;
  // late String respuestaIncorrecta2;
  // late String respuestaIncorrecta3;
  // late int nivel;
  late int puntos;
  late List<AnswerModel> answers;

  Pregunta({
    required this.id,
    required this.descripcion,
    // required this.respuestaCorrecta,
    // required this.respuestaIncorrecta1,
    // required this.respuestaIncorrecta2,
    // required this.respuestaIncorrecta3,
    //   required this.nivel,
    required this.puntos,
    required this.answers,
  }) : assert(
          answers.length == 4,
        );

  Pregunta.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    descripcion = json['descripcion'];
    answers = <AnswerModel>[];

    answers.add(AnswerModel(title: json['respuestaCorrecta'], isRight: true));
    answers.add(AnswerModel(
      title: json['respuestaIncorrecta1'],
    ));
    answers.add(AnswerModel(
      title: json['respuestaIncorrecta2'],
    ));
    answers.add(AnswerModel(
      title: json['respuestaIncorrecta3'],
    ));
    //   nivel = json['nivel'];
    puntos = json['puntos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = id;
    data['descripcion'] = descripcion;
    data['respuestaCorrecta'] = answers[0].title;
    data['respuestaIncorrecta1'] = answers[1].title;
    data['respuestaIncorrecta2'] = answers[2].title;
    data['respuestaIncorrecta3'] = answers[3].title;
    // data['nivel'] = nivel;
    data['puntos'] = puntos;

    return data;
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'respuestaCorrecta': respuestaCorrecta,
  //     'respuestaIncorrecta1': respuestaIncorrecta1,
  //     'respuestaIncorrecta2': respuestaIncorrecta2,
  //     'respuestaIncorrecta3': respuestaIncorrecta3,
  //     'puntos': puntos,
  //     '_id': id,
  //     'nivel': nivel,
  //     'answers': answers.map((x) => x.toMap()).toList(),
  //   };
  // }

  // factory Pregunta.fromMap(Map<String, dynamic> map) {
  //   return Pregunta(
  //     title: map['title'],
  //     answers: List<AnswerModel>.from(
  //         map['answers'].map((x) => AnswerModel.fromMap(x))),
  //   );
  // }

  //String toJson() => json.encode(toMap());

  // factory QuestionModel.fromJson(String source) =>
  //     QuestionModel.fromMap(json.decode(source));
}
