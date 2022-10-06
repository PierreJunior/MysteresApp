class RosaryPrayerService {
  late int _currentStep;
  late String _selectedDay;

  RosaryPrayerService(String selectedDay) {
    _currentStep = 1;
    _selectedDay = selectedDay.toLowerCase();
  }

  final List<Map<String, Object>> _prayerSteps = [
    {
      "title": "Apostles' Creed",
      "name": "Apostles' Creed",
      "display_name": "Apostles' Creed",
      "value":
          "I believe in God, the Father Almighty, Creator of Heaven and earth; and in Jesus Christ, His only Son, Our Lord, Who was conceived by the Holy Ghost, born of the Virgin Mary, suffered under Pontius Pilate, was crucified; died, and was buried. He descended into Hell; the third day He arose again from the dead; He ascended into Heaven, sitteth at the right hand of God, the Father Almighty; from thence He shall come to judge the living and the dead. I believe in the Holy Spirit, the holy Catholic Church, the communion of saints, the forgiveness of sins, the resurrection of the body, and life everlasting. Amen.'",
      "step_number": 1,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Our Father",
      "name": "",
      "display_name": "",
      "value": "",
      "step_number": 2,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Hail Mary",
      "name": "",
      "display_name": "",
      "value": "",
      "step_number": 3,
      "type": "normal",
      "repeat": 3
    },
    {
      "title": "Glory Be",
      "name": "",
      "display_name": "",
      "value": "",
      "step_number": 4,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "null",
      "name": "null",
      "value": "null",
      "step_number": 5,
      "type": "mystere",
      "repeat": 1
    },
  ];

  final Map<String, List<Map<String, Object>>> _dayMystereMap = {
    "monday": [
      {"value": "Joyeux 1", "step_number": 5, "title": "", "number": 1},
      {"value": "Joyeux 2", "step_number": 10, "title": "", "number": 2},
      {"value": "Joyeux 3", "step_number": 15, "title": "", "number": 3},
      {"value": "Joyeux 4", "step_number": 20, "title": "", "number": 4},
      {"value": "Joyeux 5", "step_number": 25, "title": "", "number": 5},
    ],
    "tuesday": [
      {"value": "Douloureux 1", "step_number": 5, "title": ""},
      {"value": "Douloureux 2", "step_number": 10, "title": ""},
      {"value": "Douloureux 3", "step_number": 15, "title": ""},
      {"value": "Douloureux 4", "step_number": 20, "title": ""},
      {"value": "Douloureux 5", "step_number": 25, "title": ""},
    ],
    "wednesday": [
      {"value": "Glorieux 1", "step_number": 5, "title": ""},
      {"value": "Glorieux 2", "step_number": 10, "title": ""},
      {"value": "Glorieux 3", "step_number": 15, "title": ""},
      {"value": "Glorieux 4", "step_number": 20, "title": ""},
      {"value": "Glorieux 5", "step_number": 25, "title": ""},
    ],
    "thursday": [
      {
        "value":
            """Dès que Jésus fut baptisé, il sortit de l'eau; voici que les cieux s'ouvrirent, et il vit l'Esprit de Dieu descendre comme une colombe et venir sur lui. Et des cieux, une voix disait: "Celui-ci est mon Fils bien-aimé; en lui j'ai mis tout mon amour (Mt 3,16-17)""",
        "step_number": 5,
        "title": "Le Baptême dans le Jourdain"
      },
      {"value": "Lumineux 2", "step_number": 10, "title": ""},
      {"value": "Lumineux 3", "step_number": 15, "title": ""},
      {"value": "Lumineux 4", "step_number": 20, "title": ""},
      {"value": "Lumineux 5", "step_number": 25, "title": ""},
    ],
    "friday": [
      {"value": "Douloureux 1", "step_number": 5, "title": ""},
      {"value": "Douloureux 2", "step_number": 10, "title": ""},
      {"value": "Douloureux 3", "step_number": 15, "title": ""},
      {"value": "Douloureux 4", "step_number": 20, "title": ""},
      {"value": "Douloureux 5", "step_number": 25, "title": ""},
    ],
    "saturday": [
      {"value": "Joyeux 1", "step_number": 5, "title": ""},
      {"value": "Joyeux 2", "step_number": 10, "title": ""},
      {"value": "Joyeux 3", "step_number": 15, "title": ""},
      {"value": "Joyeux 4", "step_number": 20, "title": ""},
      {"value": "Joyeux 5", "step_number": 25, "title": ""},
    ],
    "sunday": [
      {"value": "Glorieux 1", "step_number": 5, "title": ""},
      {"value": "Glorieux 2", "step_number": 10, "title": ""},
      {"value": "Glorieux 3", "step_number": 15, "title": ""},
      {"value": "Glorieux 4", "step_number": 20, "title": ""},
      {"value": "Glorieux 5", "step_number": 25, "title": ""},
    ],
  };

  Map<int, String> title = {
    1: "Apostles' Creed",
    2: "Our Father",
    3: "Three Hail Marys",
    4: "Glory Be",
    5: "First Mysteres",
    6: "Our Father",
    7: "Ten Hail Marys",
    8: "Glory Be",
    9: "Fatima Prayer",
    10: "Second Mysteres",
    11: "Our Father",
    12: "Ten Hail Marys",
    13: "Glory Be",
    14: "Fatima Prayer",
    15: "Third Mysteres",
    16: "Our Father",
    17: "Ten Hail Marys",
    18: "Glory Be",
    19: "Fatima Prayer",
    20: "Fourth Mysteres",
    21: "Our Father",
    22: "Ten Hail Marys",
    23: "Glory Be",
    24: "Fatima Prayer",
    25: "Fifth Mysteres",
    26: "Our Father",
    27: "Ten Hail Marys",
    28: "Glory Be",
    29: "Fatima Prayer",
    30: "Hail Holy Queen",
  };

  Map<String, List<String>> mysteres = {
    "Monday": [
      "Dès que Jésus fut baptisé, il sortit de l'eau; voici que les cieux s'ouvrirent, et il vit l'Esprit de Dieu descendre comme une colombe et venir sur lui. Et des cieux, une voix disait: \"Celui-ci est mon Fils bien-aimé;  en lui j'ai mis tout mon amour (Mt 3,16-17)",
      "Trois jours plus tard, il y avait un mariage à Cana en Galilée. La mère de Jésus était là. Jésus aussi avait été invité au repas de noces avec ses disciples. Or, on manqua de vin; la mère de Jésus lui dit: \"Ils n'ont plus de vin\". Jésus répondit: \"Femme, que me veux-tu? Mon heure n'est pas encore venue\". Sa mère dit aux serviteurs: \"Faites tout ce qu'il vous dira. (Jn 2, 1-5)",
      "Les temps sont accomplis: le règne de Dieu est tout proche. Convertissez-vous et croyez à la Bonne Nouvelle. (Mc 1, 15)",
      "Six jours après, Jésus prend avec lui Pierre, Jacques et Jean son frère, et il les emmène à l'écart, sur une haute montagne. Il fut transfiguré devant eux; son visage devint brillant comme le soleil, et ses vêtements, blancs comme la lumière»(Mt 17, 1-2).",
      "Pendant le repas, Jésus prit du pain, prononça la bénédiction, le rompit et le donna à ses disciples, en disant: \"Prenez, mangez: ceci est mon corps (Mt 26, 26)",
    ],
  };

  Map<int, String> prayers = {
    1: 'I believe in God, the Father Almighty, Creator of Heaven and earth; and in Jesus Christ, His only Son, Our Lord, Who was conceived by the Holy Ghost, born of the Virgin Mary, suffered under Pontius Pilate, was crucified; died, and was buried. He descended into Hell; the third day He arose again from the dead; He ascended into Heaven, sitteth at the right hand of God, the Father Almighty; from thence He shall come to judge the living and the dead. I believe in the Holy Spirit, the holy Catholic Church, the communion of saints, the forgiveness of sins, the resurrection of the body, and life everlasting. Amen.',
    2: 'Our Father, Who art in heaven, hallowed be Thy name; Thy kingdom come; Thy will be done on earth as it is in heaven. Give us this day our daily bread; and forgive us our trespasses as we forgive those who trespass against us; and lead us not into temptation, but deliver us from evil, Amen.',
    3: 'Hail Mary, full of grace. The Lord is with thee. Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen.',
    4: 'Glory be to the Father, to the Son, and to the Holy Spirit, as it was, is now, and ever shall be, world without end. Amen.',
    5: 'On the large bead, meditate on the first mystery',
    6: 'Our Father, Who art in heaven, Hallowed be Thy Name. Thy Kingdom come. Thy Will be done, on earth as it is in Heaven. Give us this day our daily bread. And forgive us our trespasses, as we forgive those who trespass against us. And lead us not into temptation, but deliver us from evil. Amen.',
    7: 'Hail Mary, Full of Grace, The Lord is with thee. Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners now, and at the hour of our death. Amen.',
    8: 'Glory be to the Father, and to the Son, and to the Holy Spirit. As it was in the beginning, is now, and ever shall be, world without end. Amen.',
    9: 'O my Jesus, forgive us our sins, save us from the fires of hell, and lead all souls to heaven,especially those most in need of Thy mercy.',
    10: 'second Mysteres',
    11: 'Our Father, Who art in heaven, Hallowed be Thy Name. Thy Kingdom come. Thy Will be done, on earth as it is in Heaven. Give us this day our daily bread. And forgive us our trespasses, as we forgive those who trespass against us. And lead us not into temptation, but deliver us from evil. Amen.',
    12: 'Hail Mary, Full of Grace, The Lord is with thee. Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners now, and at the hour of our death. Amen.',
    13: 'Glory be to the Father, and to the Son, and to the Holy Spirit. As it was in the beginning, is now, and ever shall be, world without end. Amen.',
    14: 'O my Jesus, forgive us our sins, save us from the fires of hell, and lead all souls to heaven,especially those most in need of Thy mercy.',
    15: 'Third Mysteres',
    16: 'Our Father, Who art in heaven, Hallowed be Thy Name. Thy Kingdom come. Thy Will be done, on earth as it is in Heaven. Give us this day our daily bread. And forgive us our trespasses, as we forgive those who trespass against us. And lead us not into temptation, but deliver us from evil. Amen.',
    17: 'Hail Mary, Full of Grace, The Lord is with thee. Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners now, and at the hour of our death. Amen.',
    18: 'Glory be to the Father, and to the Son, and to the Holy Spirit. As it was in the beginning, is now, and ever shall be, world without end. Amen.',
    19: 'O my Jesus, forgive us our sins, save us from the fires of hell, and lead all souls to heaven,especially those most in need of Thy mercy.',
    20: 'Fourth Mysteres',
    21: 'Our Father, Who art in heaven, Hallowed be Thy Name. Thy Kingdom come. Thy Will be done, on earth as it is in Heaven. Give us this day our daily bread. And forgive us our trespasses, as we forgive those who trespass against us. And lead us not into temptation, but deliver us from evil. Amen.',
    22: 'Hail Mary, Full of Grace, The Lord is with thee. Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners now, and at the hour of our death. Amen.',
    23: 'Glory be to the Father, and to the Son, and to the Holy Spirit. As it was in the beginning, is now, and ever shall be, world without end. Amen.',
    24: 'O my Jesus, forgive us our sins, save us from the fires of hell, and lead all souls to heaven,especially those most in need of Thy mercy.',
    25: 'Fifth Mysteres',
    26: 'Our Father, Who art in heaven, Hallowed be Thy Name. Thy Kingdom come. Thy Will be done, on earth as it is in Heaven. Give us this day our daily bread. And forgive us our trespasses, as we forgive those who trespass against us. And lead us not into temptation, but deliver us from evil. Amen.',
    27: 'Hail Mary, Full of Grace, The Lord is with thee. Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners now, and at the hour of our death. Amen.',
    28: 'Glory be to the Father, and to the Son, and to the Holy Spirit. As it was in the beginning, is now, and ever shall be, world without end. Amen.',
    29: 'O my Jesus, forgive us our sins, save us from the fires of hell, and lead all souls to heaven,especially those most in need of Thy mercy.',
    30: 'Hail, Holy Queen, Mother of mercy, our life, our sweetness, and our hope. To thee do we cry, poor banished children of Eve, to thee do we send up our sighs, mourning and weeping in this valley of tears. Turn then, most gracious advocate, thine eyes of mercy toward us; and after this our exile show unto us the blessed fruit of thy womb Jesus, O clement, O loving, O sweet Virgin Mary. Pray for us, O holy Mother of God. That we may be made worthy of the promises of Christ. O God, whose only-begotten Son, by His life, death, and resurrection, has purchased for us the rewards of eternal salvation; grant we beseech Thee, that meditating upon these mysteries of the most holy Rosary of the Blessed Virgin Mary, we may imitate what they contain and obtain what they promise. Through the same Christ our Lord. Amen.',
  };

  void setStep(int step) => _currentStep = step;

  int getCurrentStep() => _currentStep;

  void increaseStep() {
    _currentStep++;
  }

  void decreaseStep() {
    if (_currentStep > 1) {
      _currentStep--;
    }
  }

  int getTotalPrayerSteps() => _prayerSteps.length;

  Map<String, Object> getPrayer() {
    // Check step type.
    Map<String, Object> step =
        _prayerSteps.firstWhere((e) => e["step_number"] == _currentStep);

    if (step["type"] == "mystere") {
      Map<String, Object>? mystere = _dayMystereMap[_selectedDay]
          ?.firstWhere((e) => e["step_number"] == _currentStep);

      step["title"] = mystere!["title"]!;
      step["name"] = mystere["title"]!;
      step["value"] = mystere["value"]!;
    }

    return step;
  }
}
