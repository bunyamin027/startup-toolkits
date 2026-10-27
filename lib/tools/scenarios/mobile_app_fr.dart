import '../l10n/tool_text.dart';
import 'scenario.dart';

/// Mobile app example (Pacely) in French.
const mobileAppFr = ScenarioText(
  fields: {
    'leanCanvas': {
      'company': 'Pacely',
      'problem':
          'Les plans de course génériques ignorent le sommeil, le stress et les séances manquées.\n'
          'Les débutants se blessent en en faisant trop, trop tôt.\n'
          'Un coach humain coûte trop cher pour la plupart des coureurs.',
      'solution':
          'Un coach IA qui réécrit la semaine après chaque sortie.\n'
          'Des alertes de charge avant la blessure, pas après.\n'
          'Des consignes vocales pendant la course, en mots simples.',
      'uvp':
          'Un coach de course dans votre poche, qui s’adapte à votre vraie semaine.',
      'segment':
          'Coureurs amateurs qui préparent leur premier 10 km ou semi-marathon',
      'channels':
          'App Store et Google Play\nClubs de course\nCommunautés Instagram et Strava',
      'revenue':
          'Offre gratuite\nPremium : 9,99 \$ par mois ou 59,99 \$ par an',
      'costs':
          'Développement de l’app\nCoûts cloud et IA\nCommissions des stores',
      'metrics':
          'Coureurs actifs par semaine\nConversion gratuit vers payant\nRétention à 30 jours',
      'advantage':
          'Un modèle d’entraînement conçu avec des scientifiques du sport sur 2 millions de sorties réelles.',
    },
    'swot': {
      'company': 'Pacely',
      'strengths':
          'Des plans qui s’adaptent chaque semaine\nExcellente note sur l’App Store\nDes scientifiques du sport dans l’équipe',
      'weaknesses':
          'Dépend des données de la montre\nPetit budget marketing\nUniquement la course, pas d’autres sports',
      'opportunities':
          'De plus en plus d’inscrits aux courses\nPartenariats avec les organisateurs\nProgrammes bien-être en entreprise',
      'threats':
          'Les fabricants de montres ajoutent leur propre coaching\nChangements des règles d’abonnement des plateformes',
    },
    'competitors': {
      'price': '12,99 \$ par mois',
      'strength': 'Marque',
      'weakness': 'Plans figés',
    },
    'persona': {
      'name': 'Rachel la coureuse',
      'role': 'Enseignante qui prépare son premier semi-marathon',
      'age': '31',
      'location': 'Bordeaux',
      'goals':
          'Finir un semi-marathon sans blessure\nCourir trois fois par semaine',
      'pains':
          'Chaque plan s’effondre après une mauvaise semaine, et elle a déjà eu une périostite',
      'tools': 'Une montre connectée\nStrava\nVidéos de course sur YouTube',
      'quote':
          'Je n’ai pas besoin d’un plan pour une semaine parfaite. Il m’en faut un pour ma semaine.',
      'channels':
          'Club de course local\nComptes Instagram de running\nNewsletters de courses',
    },
    'interviewQuestions': {
      'segment': 'Coureurs amateurs',
      'problemArea': 'la préparation d’une course',
      'product': 'Pacely',
    },
    'invoice': {
      'company': 'Pacely SAS',
      'email': 'facturation@pacely.app',
      'client': 'Semi-marathon du Lac',
      'item1': 'Partenariat plan d’entraînement officiel (saison)',
      'item2': 'Codes Premium pour 500 coureurs',
    },
    'incomeExpense': {'category': 'Cloud'},
    'pitchDeck': {
      'company': 'Pacely',
      'oneLiner':
          'Un coach de course IA qui adapte votre plan à votre vraie semaine.',
      'problem':
          'La plupart des coureurs suivent des plans figés qui cassent après une mauvaise semaine, et beaucoup se blessent.',
      'solution':
          'Pacely réécrit chaque semaine selon votre sommeil, vos sorties et votre ressenti, et vous prévient avant d’en faire trop.',
      'market':
          '60 M de coureurs amateurs aux États-Unis et dans l’UE ; marché accessible de 1,2 Md\$',
      'model': 'Freemium ; Premium à 9,99 \$ par mois ou 59,99 \$ par an',
      'traction':
          '120 000 téléchargements, 6 500 coureurs payants, note de 4,8',
      'competition':
          'Apps à plans figés (bon marché, pas adaptatives), coachs humains (excellents, mais 150 \$ par mois)',
      'team':
          'Defne (CEO, ex-responsable produit d’une app fitness), Leo (CTO, ingénieur ML), Ali (coach principal, scientifique du sport)',
      'ask':
          'Seed de 1,5 M\$ pour lancer Android et développer les partenariats de courses',
      'email': 'fondateurs@pacely.app',
    },
    'onePager': {
      'company': 'Pacely',
      'oneLiner':
          'Un coach de course IA qui adapte votre plan à votre vraie semaine.',
      'problem':
          'La plupart des coureurs suivent des plans figés qui cassent après une mauvaise semaine, et beaucoup se blessent.',
      'solution':
          'Pacely réécrit chaque semaine selon votre sommeil, vos sorties et votre ressenti, et vous prévient avant d’en faire trop.',
      'customer': 'Coureurs amateurs qui préparent une course',
      'market': 'Marché accessible de 1,2 Md\$',
      'traction': '120 000 téléchargements, 6 500 coureurs payants',
      'team': 'Defne (CEO), Leo (CTO), Ali (Coach principal)',
      'ask': 'Seed de 1,5 M\$',
      'email': 'fondateurs@pacely.app',
    },
    'investorTracker': {
      'firm': 'Fonds d’apps grand public',
      'next': 'Envoyer les données de rétention',
    },
    'kanban': {'owner': 'Leo'},
    'okr': {'objective': 'Que les coureurs continuent de s’entraîner'},
    'roadmap': {'why': 'Les coureurs le demandent'},
    'userStory': {
      'feature': 'Rattrapage des sorties manquées',
      'user': 'coureur',
      'want': 'que mon plan s’ajuste quand je manque une sortie',
      'benefit':
          'je reste sur la bonne voie sans doubler la charge ni me blesser',
      'criteria':
          'Une sortie manquée est détectée le lendemain matin\nLe reste de la semaine est rééquilibré automatiquement\nLa distance hebdomadaire n’augmente jamais de plus de 10 %\nLe coureur voit ce qui a changé et pourquoi',
      'outOfScope':
          'Plans d’entraînement croisé\nModification manuelle de chaque séance',
      'metric':
          '15 % de coureurs en moins qui abandonnent leur plan le premier mois',
    },
    'standup': {'who': 'Leo'},
    'brandName': {
      'keyword': 'allure',
      'keyword2': 'foulée',
      'benefit': 's’entraîner plus intelligemment, pas plus dur',
      'audience': 'coureurs',
    },
    'colorPalette': {'company': 'Pacely'},
    'landingPage': {
      'company': 'Pacely',
      'audience': 'coureurs',
      'outcome': 'Arrivez au jour J en forme, pas blessé',
      'problem': 'Les plans figés cassent dès que la vie s’accélère.',
      'features':
          'Un plan qui s’adapte après chaque sortie\nDes alertes avant le surentraînement\nUn coaching vocal pendant la course',
      'proof': 'Noté 4,8 par 6 500 coureurs',
      'cta': 'Commencer gratuitement',
    },
    'emailTemplates': {
      'sender': 'Defne',
      'company': 'Pacely',
      'oneLiner': 'un coach de course IA qui s’adapte à votre vraie semaine',
      'hook': 'votre intervention sur les blessures des nouveaux coureurs',
      'traction': '6 500 coureurs payants et une note de 4,8',
    },
    'seoKeywords': {
      'topic': 'préparation semi-marathon',
      'audience': 'coureurs débutants',
      'alternative': 'un coach de course',
      'location': 'Bordeaux',
    },
    'crm': {
      'company': 'Semi-marathon du Lac',
      'next': 'Envoyer la présentation du partenariat',
    },
    'proposal': {
      'company': 'Pacely SAS',
      'client': 'Semi-marathon du Lac',
      'need':
          'L’organisation veut que davantage de primo-coureurs arrivent prêts sur la ligne de départ et terminent la course.',
      'scope':
          'Plan d’entraînement Pacely officiel pour la course\n3 mois de Premium pour chaque inscrit\nUn rapport des arrivées pour les organisateurs',
      'timeline': 'Plan en ligne 16 semaines avant la course',
      'sender': 'Defne Arslan',
    },
    'followUps': {'note': 'Envoyer la présentation du partenariat'},
    'feedback': {'from': 'Coureur'},
    'nda': {
      'company': 'Pacely SAS',
      'otherParty': 'Événements du Lac SARL',
      'purpose': 'l’évaluation d’un partenariat de course',
    },
    'privacyTerms': {
      'company': 'Pacely SAS',
      'service': 'l’application Pacely',
      'email': 'confidentialite@pacely.app',
      'data':
          'Nom et e-mail\nDonnées de course et de fréquence cardiaque\nDonnées de sommeil que vous choisissez de partager\nStatistiques de l’app',
    },
    'contract': {
      'company': 'Pacely SAS',
      'scope': 'Enregistrement des consignes vocales en français',
    },
    'jobPost': {
      'company': 'Pacely',
      'oneLiner': 'un coach de course IA qui s’adapte à votre vraie semaine',
      'title': 'Ingénieur mobile senior (Flutter)',
      'location': 'À distance (fuseaux horaires américains ou européens)',
      'responsibilities':
          'Développer de nouvelles fonctionnalités dans notre app Flutter\nConnecter les montres et les plateformes santé\nGarder l’app rapide et sans plantage',
      'requirements':
          '4 ans ou plus de développement mobile\nUne app Flutter publiée sur les deux stores\nVous courez, ou vous aimeriez',
      'email': 'emplois@pacely.app',
    },
    'interviewLibrary': {
      'company': 'Pacely',
      'title': 'Ingénieur mobile senior',
    },
    'meetingNotes': {'owner': 'Leo', 'meeting': 'Point produit hebdomadaire'},
    'storeListing': {
      'app': 'Pacely',
      'subtitle': 'Coach de course IA',
      'oneLiner': 'un plan de course qui s’adapte à votre semaine',
      'audience': 'coureurs de tous niveaux',
      'features':
          'Plans du 5 km au marathon\nS’adapte après chaque sortie\nAlertes avant le surentraînement\nFonctionne avec votre montre',
      'price': 'Gratuit pour commencer. Premium dès 9,99 \$ par mois.',
      'proof': 'Noté 4,8 par 6 500 coureurs',
    },
    'asoKeywords': {
      'app': 'Pacely',
      'primary': 'coach course',
      'secondary': 'marathon',
      'audience': 'coureur',
      'keywords': 'course,entraînement,plan,5k,10k,allure,jogging,fitness',
      'competitor': 'StrideMate',
    },
    'reviewReply': {
      'app': 'Pacely',
      'topic': 'la synchronisation de la montre',
      'email': 'aide@pacely.app',
    },
    'appPrivacy': {
      'app': 'Pacely',
      'developer': 'Pacely SAS',
      'email': 'confidentialite@pacely.app',
    },
  },
  samples: {
    'competitors': [
      SampleText('StrideMate', {
        'price': '12,99 \$ par mois',
        'strength': 'Immense bibliothèque de plans',
        'weakness': 'Les plans ne s’adaptent jamais',
      }),
      SampleText('Apps des fabricants de montres', {
        'price': 'Gratuit avec la montre',
        'strength': 'Déjà au poignet',
        'weakness': 'Coaching basique',
      }),
      SampleText('Coachs humains', {
        'price': '150 \$ par mois',
        'strength': 'Vraiment personnalisé',
        'weakness': 'Trop cher pour la plupart',
      }),
    ],
    'incomeExpense': [
      SampleText('Abonnements des stores (octobre)', {'category': 'Revenus'}),
      SampleText('Hébergement cloud et IA', {'category': 'Cloud'}),
      SampleText('Publicités Instagram', {'category': 'Marketing'}),
    ],
    'investorTracker': [
      SampleText('Maya Chen', {
        'firm': 'Stride Ventures',
        'next': 'Réunion des associés jeudi',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Business angel (ex-fondateur d’une app fitness)',
        'next': 'Envoyer le BSA-AIR',
      }),
      SampleText('App Seed Partners', {
        'firm': 'Fonds pré-seed',
        'next': 'Demander une intro à Jordan',
      }),
    ],
    'kanban': [
      SampleText('Publier la bêta Android', {'owner': 'Leo'}),
      SampleText('Corriger la synchro montre sur les anciens téléphones', {
        'owner': 'Leo',
      }),
      SampleText('Rédiger le texte du nouvel écran d’abonnement', {
        'owner': 'Defne',
      }),
    ],
    'okr': [
      SampleText('Rétention à 30 jours supérieure à 40 %', {
        'objective': 'Que les coureurs continuent de s’entraîner',
      }),
      SampleText('10 000 coureurs payants', {
        'objective': 'Développer Premium',
      }),
      SampleText('Sessions sans plantage au-dessus de 99,5 %', {
        'objective': 'Que les coureurs continuent de s’entraîner',
      }),
    ],
    'roadmap': [
      SampleText('App Android', {
        'why': 'La moitié de la liste d’attente est sur Android',
      }),
      SampleText('Partenariats de courses', {
        'why': 'Amène les coureurs au bon moment',
      }),
      SampleText('Renforcement musculaire', {
        'why': 'Aide à prévenir les blessures',
      }),
    ],
    'standup': [
      SampleText('Version 2.3 publiée', {'who': 'Leo'}),
      SampleText('Appel avec l’organisateur de la course', {'who': 'Defne'}),
      SampleText('En attente de la validation App Review', {'who': 'Leo'}),
    ],
    'contentCalendar': [
      SampleText('Préparer son premier semi-marathon', {'channel': 'Blog'}),
      SampleText('Histoire de coureur : du canapé au 10 km', {
        'channel': 'Instagram',
      }),
      SampleText('Les nouveautés de la version 2.3', {'channel': 'Newsletter'}),
    ],
    'crm': [
      SampleText('Claire Martin', {
        'company': 'Semi-marathon du Lac',
        'next': 'Démo mar. 10 h',
      }),
      SampleText('Marco Rossi', {
        'company': 'Club des coureurs de la ville',
        'next': 'Relancer vendredi',
      }),
      SampleText('Hanna Berg', {
        'company': 'FitWork Bien-être',
        'next': 'Lancement du pilote',
      }),
    ],
    'followUps': [
      SampleText('Claire : envoyer la présentation du partenariat', {
        'note': 'Joindre les résultats de la saison passée',
      }),
      SampleText('Maya : notes de la réunion des associés', {
        'note': 'En attente de retour',
      }),
      SampleText('Hanna : point sur le pilote', {'note': 'Tout va bien'}),
    ],
    'feedback': [
      SampleText('Mode tapis de course', {'from': 'Avis App Store'}),
      SampleText('Partager son plan avec un ami', {
        'from': 'Sondage dans l’app',
      }),
      SampleText('App Apple Watch', {'from': 'E-mails au support'}),
    ],
    'meetingNotes': [
      SampleText('Envoyer le point investisseurs', {
        'owner': 'Defne',
        'meeting': 'Point produit hebdomadaire',
      }),
      SampleText('Corriger l’abandon sur l’écran d’abonnement', {
        'owner': 'Leo',
        'meeting': 'Revue croissance',
      }),
      SampleText('Relire le nouveau modèle de plan', {
        'owner': 'Ali',
        'meeting': 'Point produit hebdomadaire',
      }),
    ],
    'kpiBoard': [
      SampleText('Revenu mensuel récurrent', {
        'current': '38 000 \$',
        'target': '50 000 \$',
      }),
      SampleText('Rétention à 30 jours', {'current': '34 %', 'target': '40 %'}),
      SampleText('Attrition mensuelle', {'current': '5 %', 'target': '2 %'}),
    ],
  },
);
