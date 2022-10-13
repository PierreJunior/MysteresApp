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
          "Je crois en Dieu, le Père tout-puissant, créateur du ciel et de la terre.  Et en Jésus Christ, son fils unique, notre Seigneur ; qui a été conçu du Saint-Esprit, est né de la Vierge Marie, a souffert sous Ponce Pilate, a été crucifié, est mort et a été enseveli, est descendu aux enfers ; le troisième jour est ressuscité des morts, est monté aux cieux, est assis à la droite de Dieu le Père tout-puissant, d’où il viendra juger les vivants et les morts. Je crois en l’Esprit Saint, à la sainte Église catholique, à la communion des saints, à la rémission des péchés, à la résurrection de la chair, à la vie éternelle. Amen'",
      "step_number": 1,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Notre Père",
      "name": "Notre Père",
      "display_name": "Notre Père",
      "value":
          "Notre Père, qui es aux cieux, que ton nom soit sanctifié, que ton règne vienne, que ta volonté soit faite, sur la terre comme au ciel. Donne-nous aujourd'hui notre pain de ce jour, pardonne-nous nos offenses, come nous pardonnons aussi à ceux qui nous ont offensés, et ne nous laisse pas entrer en tentation, mais délivre-nous du mal. Amen",
      "step_number": 2,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Je vous salue, Marie",
      "name": "Je vous salue, Marie",
      "display_name": "Je vous salue, Marie",
      "value":
          "Je vous salue, Marie, pleine de grâces, le Seigneur est avec vous, vous êtes bénie entre toutes les femmes, et Jésus, le fruit de vos entrailles, est béni. Sainte Marie, Mère de Dieu, priez pour nous, pauvres pécheurs, maintenant, et à l'heure de notre mort. Amen",
      "step_number": 3,
      "type": "normal",
      "repeat": 3
    },
    {
      "title": "Gloire au Père ",
      "name": "Gloire au Père ",
      "display_name": "Gloire au Père ",
      "value":
          "Gloire au Père et au Fils at au Saint-Esprit. Comme il était au commencement, maintenant et toujours, et dans les siècles des siècles. Amen.",
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
    {
      "title": "Notre Père",
      "name": "Notre Père",
      "display_name": "Notre Père",
      "value":
          "Notre Père, qui es aux cieux, que ton nom soit sanctifié, que ton règne vienne, que ta volonté soit faite, sur la terre comme au ciel. Donne-nous aujourd'hui notre pain de ce jour, pardonne-nous nos offenses, come nous pardonnons aussi à ceux qui nous ont offensés, et ne nous laisse pas entrer en tentation, mais délivre-nous du mal. Amen",
      "step_number": 6,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Je vous salue, Marie",
      "name": "Je vous salue, Marie",
      "display_name": "Je vous salue, Marie",
      "value":
          "Je vous salue, Marie, pleine de grâces, le Seigneur est avec vous, vous êtes bénie entre toutes les femmes, et Jésus, le fruit de vos entrailles, est béni. Sainte Marie, Mère de Dieu, priez pour nous, pauvres pécheurs, maintenant, et à l'heure de notre mort. Amen",
      "step_number": 7,
      "type": "normal",
      "repeat": 10
    },
    {
      "title": "Gloire au Père ",
      "name": "Gloire au Père ",
      "display_name": "Gloire au Père ",
      "value":
          "Gloire au Père et au Fils at au Saint-Esprit. Comme il était au commencement, maintenant et toujours, et dans les siècles des siècles. Amen.",
      "step_number": 8,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Gloire au Père ",
      "name": "Gloire au Père ",
      "display_name": "Gloire au Père ",
      "value":
          "O mon Jésus, pardonne-nous nos péchés, préserve-nous du feu de l'enfer et conduis au ciel toutes les petit âmes surtout celles qui ont le plus besoin de ta miséricorde. Amen.",
      "step_number": 9,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "null",
      "name": "null",
      "value": "null",
      "step_number": 10,
      "type": "mystere",
      "repeat": 1
    },
    {
      "title": "Notre Père",
      "name": "Notre Père",
      "display_name": "Notre Père",
      "value":
          "Notre Père, qui es aux cieux, que ton nom soit sanctifié, que ton règne vienne, que ta volonté soit faite, sur la terre comme au ciel. Donne-nous aujourd'hui notre pain de ce jour, pardonne-nous nos offenses, come nous pardonnons aussi à ceux qui nous ont offensés, et ne nous laisse pas entrer en tentation, mais délivre-nous du mal. Amen",
      "step_number": 11,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Je vous salue, Marie",
      "name": "Je vous salue, Marie",
      "display_name": "Je vous salue, Marie",
      "value":
          "Je vous salue, Marie, pleine de grâces, le Seigneur est avec vous, vous êtes bénie entre toutes les femmes, et Jésus, le fruit de vos entrailles, est béni. Sainte Marie, Mère de Dieu, priez pour nous, pauvres pécheurs, maintenant, et à l'heure de notre mort. Amen",
      "step_number": 12,
      "type": "normal",
      "repeat": 10
    },
    {
      "title": "Gloire au Père ",
      "name": "Gloire au Père ",
      "display_name": "Gloire au Père ",
      "value":
          "Gloire au Père et au Fils at au Saint-Esprit. Comme il était au commencement, maintenant et toujours, et dans les siècles des siècles. Amen.",
      "step_number": 13,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Gloire au Père ",
      "name": "Gloire au Père ",
      "display_name": "Gloire au Père ",
      "value":
          "O mon Jésus, pardonne-nous nos péchés, préserve-nous du feu de l'enfer et conduis au ciel toutes les petit âmes surtout celles qui ont le plus besoin de ta miséricorde. Amen.",
      "step_number": 14,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "null",
      "name": "null",
      "value": "null",
      "step_number": 15,
      "type": "mystere",
      "repeat": 1
    },
    {
      "title": "Notre Père",
      "name": "Notre Père",
      "display_name": "Notre Père",
      "value":
          "Notre Père, qui es aux cieux, que ton nom soit sanctifié, que ton règne vienne, que ta volonté soit faite, sur la terre comme au ciel. Donne-nous aujourd'hui notre pain de ce jour, pardonne-nous nos offenses, come nous pardonnons aussi à ceux qui nous ont offensés, et ne nous laisse pas entrer en tentation, mais délivre-nous du mal. Amen",
      "step_number": 16,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Je vous salue, Marie",
      "name": "Je vous salue, Marie",
      "display_name": "Je vous salue, Marie",
      "value":
          "Je vous salue, Marie, pleine de grâces, le Seigneur est avec vous, vous êtes bénie entre toutes les femmes, et Jésus, le fruit de vos entrailles, est béni. Sainte Marie, Mère de Dieu, priez pour nous, pauvres pécheurs, maintenant, et à l'heure de notre mort. Amen",
      "step_number": 17,
      "type": "normal",
      "repeat": 10
    },
    {
      "title": "Gloire au Père ",
      "name": "Gloire au Père ",
      "display_name": "Gloire au Père ",
      "value":
          "Gloire au Père et au Fils at au Saint-Esprit. Comme il était au commencement, maintenant et toujours, et dans les siècles des siècles. Amen.",
      "step_number": 18,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Gloire au Père ",
      "name": "Gloire au Père ",
      "display_name": "Gloire au Père ",
      "value":
          "O mon Jésus, pardonne-nous nos péchés, préserve-nous du feu de l'enfer et conduis au ciel toutes les petit âmes surtout celles qui ont le plus besoin de ta miséricorde. Amen.",
      "step_number": 19,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "null",
      "name": "null",
      "value": "null",
      "step_number": 20,
      "type": "mystere",
      "repeat": 1
    },
    {
      "title": "Notre Père",
      "name": "Notre Père",
      "display_name": "Notre Père",
      "value":
          "Notre Père, qui es aux cieux, que ton nom soit sanctifié, que ton règne vienne, que ta volonté soit faite, sur la terre comme au ciel. Donne-nous aujourd'hui notre pain de ce jour, pardonne-nous nos offenses, come nous pardonnons aussi à ceux qui nous ont offensés, et ne nous laisse pas entrer en tentation, mais délivre-nous du mal. Amen",
      "step_number": 21,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Je vous salue, Marie",
      "name": "Je vous salue, Marie",
      "display_name": "Je vous salue, Marie",
      "value":
          "Je vous salue, Marie, pleine de grâces, le Seigneur est avec vous, vous êtes bénie entre toutes les femmes, et Jésus, le fruit de vos entrailles, est béni. Sainte Marie, Mère de Dieu, priez pour nous, pauvres pécheurs, maintenant, et à l'heure de notre mort. Amen",
      "step_number": 22,
      "type": "normal",
      "repeat": 10
    },
    {
      "title": "Gloire au Père ",
      "name": "Gloire au Père ",
      "display_name": "Gloire au Père ",
      "value":
          "Gloire au Père et au Fils at au Saint-Esprit. Comme il était au commencement, maintenant et toujours, et dans les siècles des siècles. Amen.",
      "step_number": 23,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Gloire au Père ",
      "name": "Gloire au Père ",
      "display_name": "Gloire au Père ",
      "value":
          "O mon Jésus, pardonne-nous nos péchés, préserve-nous du feu de l'enfer et conduis au ciel toutes les petit âmes surtout celles qui ont le plus besoin de ta miséricorde. Amen.",
      "step_number": 24,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "null",
      "name": "null",
      "value": "null",
      "step_number": 25,
      "type": "mystere",
      "repeat": 1
    },
    {
      "title": "Notre Père",
      "name": "Notre Père",
      "display_name": "Notre Père",
      "value":
          "Notre Père, qui es aux cieux, que ton nom soit sanctifié, que ton règne vienne, que ta volonté soit faite, sur la terre comme au ciel. Donne-nous aujourd'hui notre pain de ce jour, pardonne-nous nos offenses, come nous pardonnons aussi à ceux qui nous ont offensés, et ne nous laisse pas entrer en tentation, mais délivre-nous du mal. Amen",
      "step_number": 26,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Je vous salue, Marie",
      "name": "Je vous salue, Marie",
      "display_name": "Je vous salue, Marie",
      "value":
          "Je vous salue, Marie, pleine de grâces, le Seigneur est avec vous, vous êtes bénie entre toutes les femmes, et Jésus, le fruit de vos entrailles, est béni. Sainte Marie, Mère de Dieu, priez pour nous, pauvres pécheurs, maintenant, et à l'heure de notre mort. Amen",
      "step_number": 27,
      "type": "normal",
      "repeat": 10
    },
    {
      "title": "Gloire au Père ",
      "name": "Gloire au Père ",
      "display_name": "Gloire au Père ",
      "value":
          "Gloire au Père et au Fils at au Saint-Esprit. Comme il était au commencement, maintenant et toujours, et dans les siècles des siècles. Amen.",
      "step_number": 28,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Gloire au Père ",
      "name": "Gloire au Père ",
      "display_name": "Gloire au Père ",
      "value":
          "O mon Jésus, pardonne-nous nos péchés, préserve-nous du feu de l'enfer et conduis au ciel toutes les petit âmes surtout celles qui ont le plus besoin de ta miséricorde. Amen.",
      "step_number": 29,
      "type": "normal",
      "repeat": 1
    },
    {
      "title": "Salut, ô Reine",
      "name": "Salut, ô Reine",
      "display_name": "Salut, ô Reine",
      "value":
          "Salut, ô Reine, mère de miséricorde ; notre vie, notre douceur et notre espérance, salut ! Enfants d'Eve, exilés, nous crions vers vous ; vers vous nous soupirons, gémissant et pleurant dans cette vallée de larmes. O vous, notre avocate, tournez vers nous vos regards miséricordieux. Et après cet exil, montrez-nous Jésus, le fruit béni de vos entrailles, ô clémente, ô miséricordieuse, ô douce Vierge Marie !",
      "step_number": 30,
      "type": "normal",
      "repeat": 1
    },
  ];

  final Map<String, List<Map<String, Object>>> _dayMystereMap = {
    "monday": [
      {
        "value":
            "Le sixième mois, l'ange Gabriel fut envoyé par Dieu dans une ville de Galilée, appelée Nazareth, à une vierge, accordée en mariage à un homme de la maison de David, appelé Joseph; et le nom de la Vierge était Marie. (Lc 1,26-27) ",
        "step_number": 5,
        "title": "L'Annonciation de l'Ange Gabriel à la Vierge Marie",
        "number": 1
      },
      {
        "value":
            """En ces jours-là, Marie se mit en route rapidement vers une ville da la montagne de Judée. Elle entra dans la maison de Zacharie et salua Élisabeth. Or, quand  Élisabeth entendit la salutation de Marie, l'enfant tressaillit en elle. Alors, Élisabeth fut rempli de l'Esprit Saint, et s'écria d'une voie forte: "Tu es bénie entre toutes les femmes, et le fruit de tes entrailles est béni! (Lc 1, 39-42)""",
        "step_number": 10,
        "title": "Visite de la Vierge Marie à sa cousine Élisabeth",
        "number": 2
      },
      {
        "value":
            "En ces jours-là, parut un édit de l'empereur, ordonnant de recenser toute la terre - ce premier recensement eut lieu lorsque Quirinius était gouverneur de Syrie. Et chacun allait se faire inscrire dans sa ville origine.  Joseph, lui aussi, quitta la ville de Nazareth en Galilée, pour monter en Judée, à la ville de David appelée Bethléem, car il était de la maison et de la descendance de David. Il venait se faire inscrire avec Marie, son épouse, qui était enceinte. Or, pendant qu'ils étaient là, arrivèrent les jours où elle devait enfanter. Et elle mit au monde son fils premier-né; elle l'emmaillota et le coucha dans une mangeoire, car il n'y avait pas de place pour eux dans la salle commune (Lc 2,1-7).",
        "step_number": 15,
        "title": " La naissance de Jésus dans la grotte de Bethléem.",
        "number": 3
      },
      {
        "value":
            "Quand arriva le huitième jour, celui de la circoncision, l'enfant reçut le nom de Jésus, le nom que l'ange lui avait donné avant sa conception. Quand arriva le jour fixé par la loi de Moïse pour la purification, les parents de Jésus le portèrent à Jérusalem pour le présenter au Seigneur, selon ce qui est écrit dans la Loi: Tout premier-né de sexe masculin sera consacré au Seigneur (Lc 2, 21-24).",
        "step_number": 20,
        "title": "Jésus est présenté au temple par Marie et Joseph",
        "number": 4
      },
      {
        "value":
            "Chaque année, les parents de Jésus allaient à Jérusalem pour la fête de la Pâque. Quand il eut douze ans, ils firent le pèlerinage suivant la coutume. Comme ils s'en retournaient à la fin de la semaine, le jeune Jésus resta à Jérusalem sans que ses parents s'en aperçoivent. Pensant qu'il était avec leurs compagnons de route, ils firent une journée de chemin avant de le chercher parmi leurs parents et connaissance. Ne le trouvant pas, ils revirent à Jérusalem en continuant à le chercher. C'est au bout de trois jours qu'ils le retrouvèrent dans le Temple, assis au milieu des docteurs de la Loi: il les écoutait et leur posait des questions, et tous ceux qui l'entendaient s'extasiaient sur son intelligence et sur ses réponses (Lc 2, 41-47)",
        "step_number": 25,
        "title": "Jésus retrouvé dans le temple",
        "number": 5
      },
    ],
    "tuesday": [
      {
        "value":
            """Alors Jésus parvient avec eux à un domaine appelé Gethsémani et leur dit: "Restez ici, pendant que je m'en vais là-bas pour prier". Il emmena Pierre, ainsi que Jacques et Jean, les deux fils de Zébédée, et il commença à ressentir tristesse et angoisse. Il leur dit alors: "Mon âme est triste à en mourir. Demeurez ici et veillez avec moi". Il s'écarta un peu et tomba la face contre terre, en faisant cette prière: "Mon Père, s'il est possible, que cette coupe passe loin de moi! Cependant, non pas comme je veux, mais comme tu veux(Mt 26, 36-39)""",
        "step_number": 5,
        "title": " L'agonie de Jésus à Gethsémani"
      },
      {
        "value":
            "Pilate leur relâcha Barabbas; et, après avoir fait battre de verges Jésus, il le livra pour être crucifié(Mt 27, 26)",
        "step_number": 10,
        "title": "La flagellation de Jésus"
      },
      {
        "value":
            """Alors les soldats du gouverneur emmenèrent Jésus dans le prétoire et rassemblèrent autour de lui toute la garde. Ils lui enlevèrent ses vêtements et le couvrirent d'un manteau rouge. Puis, avec des épines, ils tressèrent une couronne, et la posèrent sur sa tête; ils lui mirent un roseau dans la main droite et, pour se moquer de lui, ils s'agenouillaient en leui disant: "Salut, roi des Juifs!(Mt 27, 27-29)""",
        "step_number": 15,
        "title": "Le couronnement d'épines"
      },
      {
        "value":
            "Ils réquisitionnent, pour porter la croix, un passant, Simon de Cyrène, le père d'Alexandre et de Rufus, qui revenait des champs. Et ils amènent Jésus à l'endroit appelé Golgotha, c'est-à-dire: Lieu-du-Crâne, ou Calvaire(Mc 15, 21-22)",
        "step_number": 20,
        "title": "Le portement de la Croix"
      },
      {
        "value":
            """Lorsqu'on fut arrivé au lieu dit Le Crâne, ou Calvaire, on mit Jésus en croix, avec les deux malfaiteurs, l'un à droite et l'autre à gauche. Jésus disait: "Père, pardonne-leur: ils ne savent pas ce qu'ils font"... Il était déjà presque midi; l'obscurité se fit dans tout le pays jusqu'à trois heures, car le soleil s'était caché. Le rideau du temple se déchira par le milieu. Alors, Jésus poussa un grand cri: "Père, entre tes mains je remets mon esprit(Lc  23, 32-33, 44-46)""",
        "step_number": 25,
        "title": "Jésus est crucifié et meurt sur la Croix"
      },
    ],
    "wednesday": [
      {
        "value":
            """Le premier jour de la semaine, de grand matin, les femmes se rendirent au sépulcre, portant des aromates qu'elles avaient préparés. Elles trouvèrent la pierre roulée sur le côté du tombeau. Elles entrèrent, mais ne trouvèrent pas le corps du Seigneur Jésus. Elles ne savaient que penser, lorsque deux hommes se présentèrent à elles, avec un vêtement éblouissant. Saisies de crainte, elles baissaient le visage vers le sol. Ils leur dirent: "Pourquoi cherchez-vous le Vivant parmi les morts? Il n'est pas ici, il est ressucité(Lc 24, 1-6)""",
        "step_number": 5,
        "title": "La Résurrection de Jésus"
      },
      {
        "value":
            "Le Seigneur Jésus, après leur avoir parlé, fut enlevé au ciel et s'assit à la droite de Dieu(Mc 16, 19)",
        "step_number": 10,
        "title": "L'Ascension du Seigneur au ciel"
      },
      {
        "value":
            "Quand arriva le jour de la Pentecôte, ils se trouvaient réunis tous ensemble. Soudain, il vint du ciel un bruit pareil à celui d'un violent coup de vent: toute la maison où ils se tenaient en fut remplie. Ils virent apparaître comme une sorte de feu qui se partageait en langues et qui se posa sur chacun d'eux. Alors ils furent tous remplis de l'Esprit Saint: ils se mirent à parler en d'autres langues, et chacun s'exprimait selon le don de l'Esprit(Ac 2, 1-4)",
        "step_number": 15,
        "title": "La descente du Saint-Esprit au Cénacle"
      },
      {
        "value":
            "Désormais tous les âges me diront bienheureuse. Le Puissant fit pour moi des merveilles(Lc 1, 48-49)",
        "step_number": 20,
        "title": "L'Assomption de Marie au Ciel"
      },
      {
        "value":
            "Un signe grandiose apparut dans le ciel: une Femme, ayant le soleil pour manteau, la lune sous les pieds, et sur la tête une couronne de douze étoiles(Ap 12, 1)",
        "step_number": 25,
        "title": "Marie est couronnée Reine du ciel et de la terre"
      },
    ],
    "thursday": [
      {
        "value":
            """Dès que Jésus fut baptisé, il sortit de l'eau; voici que les cieux s'ouvrirent, et il vit l'Esprit de Dieu descendre comme une colombe et venir sur lui. Et des cieux, une voix disait: "Celui-ci est mon Fils bien-aimé; en lui j'ai mis tout mon amour (Mt 3,16-17)""",
        "step_number": 5,
        "title": "Le Baptême dans le Jourdain"
      },
      {
        "value":
            """Trois jours plus tard, il y avait un mariage à Cana en Galilée. La mère de Jésus était là. Jésus aussi avait été invité au repas de noces avec ses disciples. Or, on manqua de vin; la mère de Jésus lui dit: "Ils n'ont plus de vin". Jésus répondit: "Femme, que me veux-tu? Mon heure n'est pas encore venue". Sa mère dit aux serviteurs: "Faites tout ce qu'il vous dira. (Jn 2, 1-5)""",
        "step_number": 10,
        "title": "Les noces de Cana"
      },
      {
        "value":
            "Les temps sont accomplis: le règne de Dieu est tout proche. Convertissez-vous et croyez à la Bonne Nouvelle. (Mc 1, 15)",
        "step_number": 15,
        "title": "L'annonce du Royaume de Dieu et l'invitation à la conversion"
      },
      {
        "value":
            "Six jours après, Jésus prend avec lui Pierre, Jacques et Jean son frère, et il les emmène à l'écart, sur une haute montagne. Il fut transfiguré devant eux; son visage devint brillant comme le soleil, et ses vêtements, blancs comme la lumière»(Mt 17, 1-2).",
        "step_number": 20,
        "title": "La transfiguration"
      },
      {
        "value":
            """Pendant le repas, Jésus prit du pain, prononça la bénédiction, le rompit et le donna à ses disciples, en disant: "Prenez, mangez: ceci est mon corps (Mt 26, 26)""",
        "step_number": 25,
        "title": " L'institution de l'Eucharistie"
      },
    ],
    "friday": [
      {
        "value":
            """Alors Jésus parvient avec eux à un domaine appelé Gethsémani et leur dit: "Restez ici, pendant que je m'en vais là-bas pour prier". Il emmena Pierre, ainsi que Jacques et Jean, les deux fils de Zébédée, et il commença à ressentir tristesse et angoisse. Il leur dit alors: "Mon âme est triste à en mourir. Demeurez ici et veillez avec moi". Il s'écarta un peu et tomba la face contre terre, en faisant cette prière: "Mon Père, s'il est possible, que cette coupe passe loin de moi! Cependant, non pas comme je veux, mais comme tu veux(Mt 26, 36-39)""",
        "step_number": 5,
        "title": " L'agonie de Jésus à Gethsémani"
      },
      {
        "value":
            "Pilate leur relâcha Barabbas; et, après avoir fait battre de verges Jésus, il le livra pour être crucifié(Mt 27, 26)",
        "step_number": 10,
        "title": "La flagellation de Jésus"
      },
      {
        "value":
            """Alors les soldats du gouverneur emmenèrent Jésus dans le prétoire et rassemblèrent autour de lui toute la garde. Ils lui enlevèrent ses vêtements et le couvrirent d'un manteau rouge. Puis, avec des épines, ils tressèrent une couronne, et la posèrent sur sa tête; ils lui mirent un roseau dans la main droite et, pour se moquer de lui, ils s'agenouillaient en leui disant: "Salut, roi des Juifs!(Mt 27, 27-29)""",
        "step_number": 15,
        "title": "Le couronnement d'épines"
      },
      {
        "value":
            "Ils réquisitionnent, pour porter la croix, un passant, Simon de Cyrène, le père d'Alexandre et de Rufus, qui revenait des champs. Et ils amènent Jésus à l'endroit appelé Golgotha, c'est-à-dire: Lieu-du-Crâne, ou Calvaire(Mc 15, 21-22)",
        "step_number": 20,
        "title": "Le portement de la Croix"
      },
      {
        "value":
            """Lorsqu'on fut arrivé au lieu dit Le Crâne, ou Calvaire, on mit Jésus en croix, avec les deux malfaiteurs, l'un à droite et l'autre à gauche. Jésus disait: "Père, pardonne-leur: ils ne savent pas ce qu'ils font"... Il était déjà presque midi; l'obscurité se fit dans tout le pays jusqu'à trois heures, car le soleil s'était caché. Le rideau du temple se déchira par le milieu. Alors, Jésus poussa un grand cri: "Père, entre tes mains je remets mon esprit(Lc  23, 32-33, 44-46)""",
        "step_number": 25,
        "title": "Jésus est crucifié et meurt sur la Croix"
      },
    ],
    "saturday": [
      {
        "value":
            "Le sixième mois, l'ange Gabriel fut envoyé par Dieu dans une ville de Galilée, appelée Nazareth, à une vierge, accordée en mariage à un homme de la maison de David, appelé Joseph; et le nom de la Vierge était Marie. (Lc 1,26-27) ",
        "step_number": 5,
        "title": "L'Annonciation de l'Ange Gabriel à la Vierge Marie",
        "number": 1
      },
      {
        "value":
            """En ces jours-là, Marie se mit en route rapidement vers une ville da la montagne de Judée. Elle entra dans la maison de Zacharie et salua Élisabeth. Or, quand  Élisabeth entendit la salutation de Marie, l'enfant tressaillit en elle. Alors, Élisabeth fut rempli de l'Esprit Saint, et s'écria d'une voie forte: "Tu es bénie entre toutes les femmes, et le fruit de tes entrailles est béni! (Lc 1, 39-42)""",
        "step_number": 10,
        "title": "Visite de la Vierge Marie à sa cousine Élisabeth",
        "number": 2
      },
      {
        "value":
            "En ces jours-là, parut un édit de l'empereur, ordonnant de recenser toute la terre - ce premier recensement eut lieu lorsque Quirinius était gouverneur de Syrie. Et chacun allait se faire inscrire dans sa ville origine.  Joseph, lui aussi, quitta la ville de Nazareth en Galilée, pour monter en Judée, à la ville de David appelée Bethléem, car il était de la maison et de la descendance de David. Il venait se faire inscrire avec Marie, son épouse, qui était enceinte. Or, pendant qu'ils étaient là, arrivèrent les jours où elle devait enfanter. Et elle mit au monde son fils premier-né; elle l'emmaillota et le coucha dans une mangeoire, car il n'y avait pas de place pour eux dans la salle commune (Lc 2,1-7).",
        "step_number": 15,
        "title": " La naissance de Jésus dans la grotte de Bethléem.",
        "number": 3
      },
      {
        "value":
            "Quand arriva le huitième jour, celui de la circoncision, l'enfant reçut le nom de Jésus, le nom que l'ange lui avait donné avant sa conception. Quand arriva le jour fixé par la loi de Moïse pour la purification, les parents de Jésus le portèrent à Jérusalem pour le présenter au Seigneur, selon ce qui est écrit dans la Loi: Tout premier-né de sexe masculin sera consacré au Seigneur (Lc 2, 21-24).",
        "step_number": 20,
        "title": "Jésus est présenté au temple par Marie et Joseph",
        "number": 4
      },
      {
        "value":
            "Chaque année, les parents de Jésus allaient à Jérusalem pour la fête de la Pâque. Quand il eut douze ans, ils firent le pèlerinage suivant la coutume. Comme ils s'en retournaient à la fin de la semaine, le jeune Jésus resta à Jérusalem sans que ses parents s'en aperçoivent. Pensant qu'il était avec leurs compagnons de route, ils firent une journée de chemin avant de le chercher parmi leurs parents et connaissance. Ne le trouvant pas, ils revirent à Jérusalem en continuant à le chercher. C'est au bout de trois jours qu'ils le retrouvèrent dans le Temple, assis au milieu des docteurs de la Loi: il les écoutait et leur posait des questions, et tous ceux qui l'entendaient s'extasiaient sur son intelligence et sur ses réponses (Lc 2, 41-47)",
        "step_number": 25,
        "title": "Jésus retrouvé dans le temple",
        "number": 5
      },
    ],
    "sunday": [
      {
        "value":
            """Le premier jour de la semaine, de grand matin, les femmes se rendirent au sépulcre, portant des aromates qu'elles avaient préparés. Elles trouvèrent la pierre roulée sur le côté du tombeau. Elles entrèrent, mais ne trouvèrent pas le corps du Seigneur Jésus. Elles ne savaient que penser, lorsque deux hommes se présentèrent à elles, avec un vêtement éblouissant. Saisies de crainte, elles baissaient le visage vers le sol. Ils leur dirent: "Pourquoi cherchez-vous le Vivant parmi les morts? Il n'est pas ici, il est ressucité(Lc 24, 1-6)""",
        "step_number": 5,
        "title": "La Résurrection de Jésus"
      },
      {
        "value":
            "Le Seigneur Jésus, après leur avoir parlé, fut enlevé au ciel et s'assit à la droite de Dieu(Mc 16, 19)",
        "step_number": 10,
        "title": "L'Ascension du Seigneur au ciel"
      },
      {
        "value":
            "Quand arriva le jour de la Pentecôte, ils se trouvaient réunis tous ensemble. Soudain, il vint du ciel un bruit pareil à celui d'un violent coup de vent: toute la maison où ils se tenaient en fut remplie. Ils virent apparaître comme une sorte de feu qui se partageait en langues et qui se posa sur chacun d'eux. Alors ils furent tous remplis de l'Esprit Saint: ils se mirent à parler en d'autres langues, et chacun s'exprimait selon le don de l'Esprit(Ac 2, 1-4)",
        "step_number": 15,
        "title": "La descente du Saint-Esprit au Cénacle"
      },
      {
        "value":
            "Désormais tous les âges me diront bienheureuse. Le Puissant fit pour moi des merveilles(Lc 1, 48-49)",
        "step_number": 20,
        "title": "L'Assomption de Marie au Ciel"
      },
      {
        "value":
            "Un signe grandiose apparut dans le ciel: une Femme, ayant le soleil pour manteau, la lune sous les pieds, et sur la tête une couronne de douze étoiles(Ap 12, 1)",
        "step_number": 25,
        "title": "Marie est couronnée Reine du ciel et de la terre"
      },
    ],
  };

  void setStep(int step) => _currentStep = step;

  int getCurrentStep() => _currentStep;

  void increaseStep() {
    _currentStep++;
    print(_currentStep);
  }

  void decreaseStep() {
    if (_currentStep > 1) {
      _currentStep--;
      print(_currentStep);
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
