import '../l10n/tool_text.dart';
import 'scenario.dart';

/// R&D example (Terralab) in French.
const rndFr = ScenarioText(
  fields: {
    'leanCanvas': {
      'company': 'Terralab',
      'problem':
          'Les exploitations irriguent 30 à 40 % de trop, car l’humidité du sol est estimée au jugé.\n'
          'Un capteur de sol de qualité labo coûte plus de 1 000 \$.\n'
          'Le prix de l’eau et les restrictions liées à la sécheresse augmentent.',
      'solution':
          'Une sonde à 90 \$ qui mesure l’humidité à trois profondeurs.\n'
          'Un modèle d’apprentissage automatique qui transforme les mesures en plan d’irrigation quotidien.\n'
          'Des alertes sur le téléphone, sans agronome.',
      'uvp':
          'Des données de sol de qualité labo pour un dixième du prix : chaque parcelle est arrosée selon ses besoins, pas par habitude.',
      'segment':
          'Exploitations fruitières et maraîchères de taille moyenne en zones sèches',
      'channels':
          'Coopératives agricoles\nRevendeurs de matériel d’irrigation\nJournées techniques et salons agricoles',
      'revenue':
          'Sondes : 90 \$ l’unité\nPlateforme de données : 4 \$ par sonde et par mois',
      'costs':
          'Équipe R&D et essais en laboratoire\nFabrication des sondes\nPilotes sur le terrain',
      'metrics':
          'Eau économisée par hectare\nSondes installées\nTaux de conversion des pilotes en clients',
      'advantage':
          'Méthode de mesure en cours de brevet et 3 ans de données issues d’essais universitaires.',
    },
    'swot': {
      'company': 'Terralab',
      'strengths':
          'Capteur en cours de brevet\nPartenariat avec un laboratoire universitaire\nDonnées de 12 exploitations pilotes',
      'weaknesses':
          'Cycles de développement matériel longs\nPas encore de ligne de production certifiée\nPetite équipe commerciale',
      'opportunities':
          'Subventions publiques pour l’efficacité de l’eau\nRègles d’irrigation plus strictes dans les zones sèches\nCoopératives qui achètent en volume',
      'threats':
          'Grandes marques d’irrigation qui ajoutent des capteurs\nPénuries de composants électroniques',
    },
    'competitors': {
      'price': '1 200 \$ par capteur',
      'strength': 'Précision',
      'weakness': 'Cher',
    },
    'persona': {
      'name': 'Gabriel l’arboriculteur',
      'role': 'Propriétaire d’un verger de 40 hectares',
      'age': '47',
      'location': 'Vaucluse',
      'goals':
          'Réduire la facture d’eau sans perdre de rendement\nRespecter les nouvelles règles d’irrigation',
      'pains':
          'Arrose par habitude et ne voit les problèmes qu’une fois les arbres stressés',
      'tools':
          'Une appli météo\nUn programmateur d’irrigation\nLes conseils de l’agronome de la coopérative',
      'quote':
          'Je n’ai pas besoin de plus de données. J’ai besoin de savoir quand arroser.',
      'channels':
          'Réunions de coopérative\nRevendeurs d’irrigation\nGroupes WhatsApp de producteurs locaux',
    },
    'interviewQuestions': {
      'segment': 'Arboriculteurs et maraîchers',
      'problemArea': 'la planification de l’irrigation',
      'product': 'Terralab',
    },
    'invoice': {
      'company': 'Terralab SAS',
      'email': 'facturation@terralab.io',
      'client': 'Coopérative du Val Vert',
      'item1': 'Kit de sondes de sol (10 sondes)',
      'item2': 'Plateforme de données, licence annuelle par exploitation',
    },
    'incomeExpense': {'category': 'Laboratoire'},
    'pitchDeck': {
      'company': 'Terralab',
      'oneLiner':
          'Des capteurs de sol abordables qui disent aux exploitations exactement quand arroser.',
      'problem':
          'Les exploitations irriguent 30 à 40 % de trop, car un capteur de sol précis coûte plus de 1 000 \$.',
      'solution':
          'Une sonde à 90 \$ et un modèle d’apprentissage automatique qui transforment les mesures du sol en plan d’irrigation quotidien.',
      'market':
          '570 000 exploitations moyennes en zones sèches ; marché adressable de 2,1 Md\$',
      'model':
          'Vente de sondes et 4 \$ par sonde et par mois pour la plateforme',
      'traction':
          '12 exploitations pilotes, 31 % d’eau économisée en moyenne, brevet déposé, subvention R&D de 250 k\$',
      'competition':
          'Capteurs de labo (précis mais chers), services satellites (bon marché mais peu précis)',
      'team':
          'Elif (CEO, agronome), Can (CTO, docteur en capteurs), Jonas (responsable matériel, ex-fabricant d’irrigation)',
      'ask':
          'Seed de 1,2 M\$ pour certifier la production et équiper 300 exploitations',
      'email': 'fondateurs@terralab.io',
    },
    'onePager': {
      'company': 'Terralab',
      'oneLiner':
          'Des capteurs de sol abordables qui disent aux exploitations exactement quand arroser.',
      'problem':
          'Les exploitations irriguent 30 à 40 % de trop, car un capteur de sol précis coûte plus de 1 000 \$.',
      'solution':
          'Une sonde à 90 \$ et un modèle d’apprentissage automatique qui transforment les mesures du sol en plan d’irrigation quotidien.',
      'customer':
          'Exploitations fruitières et maraîchères de taille moyenne en zones sèches',
      'market': 'Marché adressable de 2,1 Md\$',
      'traction':
          '12 exploitations pilotes, 31 % d’eau économisée, brevet déposé',
      'team': 'Elif (CEO), Can (CTO), Jonas (Matériel)',
      'ask': 'Seed de 1,2 M\$',
      'email': 'fondateurs@terralab.io',
    },
    'investorTracker': {
      'firm': 'Fonds à impact',
      'next': 'Envoyer les résultats des pilotes',
    },
    'kanban': {'owner': 'Elif'},
    'okr': {'objective': 'Prouver les économies d’eau sur le terrain'},
    'roadmap': {'why': 'Demandé par les exploitations pilotes'},
    'userStory': {
      'feature': 'Plan d’irrigation quotidien',
      'user': 'chef d’exploitation',
      'want': 'voir combien de temps arroser chaque parcelle aujourd’hui',
      'benefit': 'j’arrête de deviner et j’économise de l’eau',
      'criteria':
          'Le plan est prêt chaque jour à 6 h\nAffiche les minutes par parcelle et par zone\nExplique la raison en une ligne\nFonctionne avec le programmateur déjà installé',
      'outOfScope':
          'Pilotage automatique des vannes\nConseils de fertilisation',
      'metric':
          '25 % d’eau en moins sur les exploitations pilotes en une saison',
    },
    'standup': {'who': 'Elif'},
    'brandName': {
      'keyword': 'sol',
      'keyword2': 'terra',
      'benefit': 'arroser chaque parcelle selon ses besoins, pas par habitude',
      'audience': 'producteurs',
    },
    'colorPalette': {'company': 'Terralab'},
    'landingPage': {
      'company': 'Terralab',
      'audience': 'les producteurs',
      'outcome': 'Sachez exactement quand arroser',
      'problem':
          'Arroser par habitude gaspille de l’eau, de l’argent et parfois la récolte.',
      'features':
          'Une sonde à 90 \$ qui mesure trois profondeurs\nUn plan d’irrigation quotidien pour chaque parcelle\nDes alertes avant que les plantes ne souffrent',
      'proof': 'Testé sur 12 exploitations : 31 % d’eau économisée',
      'cta': 'Demander un pilote',
    },
    'emailTemplates': {
      'sender': 'Elif',
      'company': 'Terralab',
      'oneLiner':
          'des capteurs de sol abordables qui disent aux exploitations quand arroser',
      'hook': 'votre intervention sur la climate tech au sommet AgriFood',
      'traction': '12 exploitations pilotes et un brevet déposé',
    },
    'seoKeywords': {
      'topic': 'capteur d’humidité du sol',
      'audience': 'producteurs',
      'alternative': 'tensiomètres',
      'location': 'Provence',
    },
    'crm': {
      'company': 'Coopérative du Val Vert',
      'next': 'Planifier une visite terrain',
    },
    'proposal': {
      'company': 'Terralab SAS',
      'client': 'Coopérative du Val Vert',
      'need':
          'Le Val Vert veut que ses 15 exploitations adhérentes réduisent l’eau d’irrigation sans perdre de rendement.',
      'scope':
          '60 sondes de sol installées sur 15 exploitations\nPlateforme de données pour une saison\nJournée de formation pour les chefs d’exploitation',
      'timeline':
          'Sondes installées dans les trois semaines suivant la signature',
      'sender': 'Elif Kaya',
    },
    'followUps': {'note': 'Envoyer les résultats des pilotes'},
    'feedback': {'from': 'Exploitation pilote'},
    'nda': {
      'company': 'Terralab SAS',
      'otherParty': 'Coopérative du Val Vert',
      'purpose': 'l’évaluation d’un essai conjoint sur le terrain',
    },
    'privacyTerms': {
      'company': 'Terralab SAS',
      'service': 'l’application Terralab et ses sondes de sol',
      'email': 'confidentialite@terralab.io',
      'data':
          'Nom et e-mail\nEmplacement de l’exploitation et limites des parcelles\nMesures de sol de vos sondes\nStatistiques d’utilisation de l’app',
    },
    'contract': {
      'company': 'Terralab SAS',
      'scope': 'Concevoir un boîtier de sonde étanche pour le terrain',
    },
    'jobPost': {
      'company': 'Terralab',
      'oneLiner':
          'des capteurs de sol abordables qui disent aux exploitations quand arroser',
      'title': 'Ingénieur·e firmware embarqué',
      'location': 'Hybride (labo deux jours par semaine)',
      'responsibilities':
          'Porter le firmware des sondes du prototype à la production\nRéduire la consommation pour tenir deux saisons sur une pile\nParticiper aux essais terrain avec les exploitations pilotes',
      'requirements':
          'Plus de 3 ans de C embarqué sur des appareils basse consommation\nExpérience des capteurs ou de la radio (LoRa, BLE)\nAussi à l’aise au champ qu’au labo',
      'email': 'jobs@terralab.io',
    },
    'interviewLibrary': {
      'company': 'Terralab',
      'title': 'Ingénieur·e firmware embarqué',
    },
    'meetingNotes': {'owner': 'Elif', 'meeting': 'Point R&D hebdo'},
    'storeListing': {
      'app': 'Terralab',
      'subtitle': 'Irrigation intelligente',
      'oneLiner': 'des capteurs de sol qui vous disent quand arroser',
      'audience': 'les producteurs',
      'features':
          'Un plan d’irrigation quotidien pour chaque parcelle\nHumidité du sol à trois profondeurs\nAlertes avant que les plantes ne souffrent\nRapports d’économies d’eau pour les subventions et audits',
      'price': 'Inclus avec chaque sonde Terralab.',
      'proof': 'Utilisé sur 12 exploitations pilotes',
    },
    'asoKeywords': {
      'app': 'Terralab',
      'primary': 'irrigation',
      'secondary': 'sol',
      'audience': 'agriculteur',
      'keywords': 'capteur,humidité,eau,ferme,jardin,verger,culture,goutte',
      'competitor': 'AquaProbe',
    },
    'reviewReply': {
      'app': 'Terralab',
      'topic': 'les alertes d’arrosage',
      'email': 'aide@terralab.io',
    },
    'appPrivacy': {
      'app': 'Terralab',
      'developer': 'Terralab SAS',
      'email': 'confidentialite@terralab.io',
    },
  },
  samples: {
    'competitors': [
      SampleText('AquaProbe Pro', {
        'price': '1 200 \$ par capteur',
        'strength': 'Précision de laboratoire',
        'weakness': 'Trop cher pour la plupart des exploitations',
      }),
      SampleText('Tensiomètres', {
        'price': 'À partir de 80 \$',
        'strength': 'Bon marché et connus',
        'weakness': 'Lecture manuelle, une seule profondeur',
      }),
      SampleText('SatIrrig', {
        'price': '6 \$ par hectare et par mois',
        'strength': 'Aucun matériel',
        'weakness': 'Données satellites trop grossières pour une parcelle',
      }),
    ],
    'incomeExpense': [
      SampleText('Abonnements des exploitations pilotes', {
        'category': 'Revenus',
      }),
      SampleText('Salaires des ingénieurs', {'category': 'Équipe'}),
      SampleText('Essais en labo et composants', {'category': 'R&D'}),
    ],
    'investorTracker': [
      SampleText('Maya Chen', {
        'firm': 'AgriTech Ventures',
        'next': 'Réunion des associés jeudi',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Business angel (ex-PDG d’un fabricant d’irrigation)',
        'next': 'Envoyer le BSA-AIR',
      }),
      SampleText('Climate Seed Fund', {
        'firm': 'Fonds climat',
        'next': 'Demander une intro à Jordan',
      }),
    ],
    'kanban': [
      SampleText('Calibrer le lot de sondes n° 4', {'owner': 'Can'}),
      SampleText('Préparer le rapport d’avancement de la subvention', {
        'owner': 'Elif',
      }),
      SampleText('Installer les sondes sur l’exploitation pilote 12', {
        'owner': 'Jonas',
      }),
    ],
    'okr': [
      SampleText('Mener des pilotes sur 20 exploitations', {
        'objective': 'Prouver les économies d’eau sur le terrain',
      }),
      SampleText('Économie d’eau moyenne au-dessus de 25 %', {
        'objective': 'Prouver les économies d’eau sur le terrain',
      }),
      SampleText('Obtenir le marquage CE', {
        'objective': 'Se préparer à la production',
      }),
    ],
    'roadmap': [
      SampleText('Deux saisons sur une seule pile', {
        'why': 'Première demande des exploitations pilotes',
      }),
      SampleText('Prise en charge des passerelles LoRaWAN', {
        'why': 'Exploitations sans couverture mobile',
      }),
      SampleText('Recommandations de fertilisation', {
        'why': 'Ouvre une deuxième source de revenus',
      }),
    ],
    'standup': [
      SampleText('Essai terrain terminé sur l’exploitation pilote 7', {
        'who': 'Jonas',
      }),
      SampleText('Appel avec le conseil en brevets', {'who': 'Elif'}),
      SampleText('En attente des puces capteurs du fournisseur', {
        'who': 'Can',
      }),
    ],
    'contentCalendar': [
      SampleText('Ce que 12 exploitations pilotes nous ont appris sur l’eau', {
        'channel': 'Blog',
      }),
      SampleText('Dans le labo : comment une sonde est calibrée', {
        'channel': 'LinkedIn',
      }),
      SampleText('Conseils d’irrigation avant le pic de l’été', {
        'channel': 'Instagram',
      }),
    ],
    'crm': [
      SampleText('Claire Martin', {
        'company': 'Coopérative du Val Vert',
        'next': 'Démo terrain mardi 10 h',
      }),
      SampleText('Marco Rossi', {
        'company': 'Vergers Rossi',
        'next': 'Relancer vendredi',
      }),
      SampleText('Hanna Berg', {
        'company': 'Vignobles Berg',
        'next': 'Installer les sondes',
      }),
    ],
    'followUps': [
      SampleText('Claire : envoyer le compte rendu de la démo', {
        'note': 'Joindre le graphique des économies d’eau',
      }),
      SampleText('Maya : notes de la réunion des associés', {
        'note': 'En attente de retour',
      }),
      SampleText('Hanna : bilan de saison', {
        'note': 'Toutes les sondes en ligne',
      }),
    ],
    'feedback': [
      SampleText('Meilleure autonomie de la pile', {
        'from': 'Exploitations pilotes 2, 5 et 9',
      }),
      SampleText('L’app en espagnol', {'from': 'Vergers Rossi'}),
      SampleText('Alertes d’arrosage plus claires', {'from': 'Groupe pilote'}),
    ],
    'meetingNotes': [
      SampleText('Envoyer le rapport d’avancement de la subvention', {
        'owner': 'Elif',
        'meeting': 'Point R&D hebdo',
      }),
      SampleText('Corriger la dérive des sondes par temps froid', {
        'owner': 'Can',
        'meeting': 'Revue labo',
      }),
      SampleText('Choisir un partenaire de fabrication', {
        'owner': 'Jonas',
        'meeting': 'Point R&D hebdo',
      }),
    ],
    'kpiBoard': [
      SampleText('Exploitations équipées de sondes', {
        'current': '12',
        'target': '20',
      }),
      SampleText('Économie d’eau moyenne', {
        'current': '22 %',
        'target': '25 %',
      }),
      SampleText('Taux de panne des sondes', {
        'current': '6 %',
        'target': '2 %',
      }),
    ],
  },
);
