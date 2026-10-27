import '../l10n/tool_text.dart';
import 'scenario.dart';

/// E-commerce example (Olivara) in French.
const ecommerceFr = ScenarioText(
  fields: {
    'leanCanvas': {
      'company': 'Olivara',
      'problem':
          'L’huile d’olive des supermarchés est souvent coupée, vieille ou mal étiquetée.\n'
          'Les petites oliveraies familiales n’atteignent pas les acheteurs étrangers.\n'
          'En rayon, difficile de reconnaître une bonne huile.',
      'solution':
          'Une huile d’un seul domaine, expédiée quelques semaines après la récolte.\n'
          'Date de récolte et oliveraie imprimées sur chaque bouteille.\n'
          'Un abonnement de recharge livré avant que vous en manquiez.',
      'uvp':
          'Une huile d’olive fraîche et traçable, de l’oliveraie à votre cuisine.',
      'segment':
          'Cuisiniers amateurs aux États-Unis et en Europe qui achètent des produits gourmets en ligne',
      'channels':
          'Recettes sur Instagram et TikTok\nBlogueurs culinaires\nPlaces de marché en ligne',
      'revenue':
          'Bouteilles : 24 \$ pièce\nAbonnement de recharge : 19 \$ par mois',
      'costs':
          'Huile des oliveraies partenaires\nMise en bouteille et expédition\nPublicités sur les réseaux sociaux',
      'metrics': 'Taux de réachat\nCoût d’acquisition client\nPanier moyen',
      'advantage':
          'Contrats exclusifs avec 9 oliveraies familiales et une récolte primée.',
    },
    'swot': {
      'company': 'Olivara',
      'strengths':
          'Huile primée\nContrats directs avec des oliveraies familiales\nForte communauté Instagram',
      'weaknesses':
          'Une seule catégorie de produits\nFrais d’expédition élevés vers les États-Unis\nRécolte saisonnière, stock limité',
      'opportunities':
          'Demande croissante d’aliments traçables\nCoffrets cadeaux pour les fêtes\nRestaurants qui achètent en gros',
      'threats':
          'Mauvaises récoltes après une sécheresse\nHuiles coupées bon marché aux étiquettes haut de gamme',
    },
    'competitors': {
      'price': '18 \$ la bouteille',
      'strength': 'Marque',
      'weakness': 'Huile coupée',
    },
    'persona': {
      'name': 'Fiona la gourmande',
      'role': 'Responsable marketing passionnée de cuisine',
      'age': '34',
      'location': 'Lyon',
      'goals':
          'Cuisiner plus sainement\nAcheter des aliments à l’origine claire',
      'pains':
          'S’est fait avoir par des étiquettes « extra vierge » et ne sait pas distinguer une bonne huile',
      'tools':
          'Recettes Instagram\nUne appli de livraison de courses\nPlaces de marché en ligne',
      'quote':
          'Si je paie pour une bonne huile, je veux savoir d’où elle vient.',
      'channels':
          'Comptes culinaires Instagram\nNewsletters de recettes\nMarchés de producteurs',
    },
    'interviewQuestions': {
      'segment': 'Cuisiniers amateurs qui achètent des produits gourmets',
      'problemArea': 'l’achat d’huile d’olive',
      'product': 'Olivara',
    },
    'invoice': {
      'company': 'Olivara SAS',
      'email': 'commandes@olivara.shop',
      'client': 'Restaurant Bella Cucina',
      'item1': 'Huile d’olive vierge extra, bidon de 5 litres',
      'item2': 'Coffret cadeau (3 bouteilles)',
    },
    'incomeExpense': {'category': 'Expédition'},
    'pitchDeck': {
      'company': 'Olivara',
      'oneLiner':
          'Une huile d’olive fraîche et traçable d’oliveraies familiales, livrée chez vous.',
      'problem':
          'La plupart des huiles en rayon sont coupées ou vieilles, et les petites oliveraies n’atteignent pas les acheteurs étrangers.',
      'solution':
          'Olivara vend en ligne une huile d’un seul domaine, expédiée quelques semaines après la récolte, avec un abonnement de recharge.',
      'market':
          '45 M d’acheteurs gourmets aux États-Unis et dans l’UE ; marché accessible de 1,8 Md\$',
      'model':
          'Vente directe à 24 \$ la bouteille et abonnement de recharge à 19 \$ par mois',
      'traction': '8 000 commandes, 38 % de réachat, 42 k\$ de revenu mensuel',
      'competition':
          'Marques de supermarché (bon marché, coupées), marques premium (chères, non traçables)',
      'team':
          'Defne (CEO, ex-cheffe de marque alimentaire), Leo (croissance, ex-agence e-commerce), Ali (approvisionnement, oléiculteur de troisième génération)',
      'ask':
          'Seed de 900 k\$ pour ouvrir un entrepôt aux États-Unis et doubler la publicité',
      'email': 'fondateurs@olivara.shop',
    },
    'onePager': {
      'company': 'Olivara',
      'oneLiner':
          'Une huile d’olive fraîche et traçable d’oliveraies familiales, livrée chez vous.',
      'problem':
          'La plupart des huiles en rayon sont coupées ou vieilles, et les petites oliveraies n’atteignent pas les acheteurs étrangers.',
      'solution':
          'Olivara vend en ligne une huile d’un seul domaine, expédiée quelques semaines après la récolte, avec un abonnement de recharge.',
      'customer': 'Cuisiniers amateurs aux États-Unis et en Europe',
      'market': 'Marché accessible de 1,8 Md\$',
      'traction': '8 000 commandes, 38 % de réachat',
      'team': 'Defne (CEO), Leo (Croissance), Ali (Approvisionnement)',
      'ask': 'Seed de 900 k\$',
      'email': 'fondateurs@olivara.shop',
    },
    'investorTracker': {
      'firm': 'Fonds grand public',
      'next': 'Envoyer les données de cohortes',
    },
    'kanban': {'owner': 'Defne'},
    'okr': {'objective': 'Faire revenir les clients'},
    'roadmap': {'why': 'Les clients le demandent'},
    'userStory': {
      'feature': 'Abonnement de recharge',
      'user': 'client régulier',
      'want': 'recevoir une nouvelle bouteille avant que la mienne soit vide',
      'benefit': 'je ne cuisine jamais sans bonne huile',
      'criteria':
          'Le client choisit une livraison tous les 1, 2 ou 3 mois\nPeut sauter ou suspendre en un geste\nReçoit un rappel 3 jours avant l’envoi\nEst débité automatiquement au prix de l’abonnement',
      'outOfScope':
          'Mélanger plusieurs produits dans un colis\nAbonnements cadeaux',
      'metric': '25 % des clients abonnés sous 3 mois',
    },
    'standup': {'who': 'Defne'},
    'brandName': {
      'keyword': 'olive',
      'keyword2': 'oliveraie',
      'benefit': 'goûtez la récolte chez vous',
      'audience': 'cuisiniers amateurs',
    },
    'colorPalette': {'company': 'Olivara'},
    'landingPage': {
      'company': 'Olivara',
      'audience': 'cuisiniers amateurs',
      'outcome': 'Une huile d’olive digne de confiance',
      'problem':
          'La plupart des huiles de supermarché sont coupées, vieilles, ou les deux.',
      'features':
          'Huile d’un seul domaine, mise en bouteille après la récolte\nDate de récolte et oliveraie sur chaque bouteille\nRecharges livrées avant que vous en manquiez',
      'proof': 'Notée 4,9 par 8 000 clients',
      'cta': 'Découvrir la récolte',
    },
    'emailTemplates': {
      'sender': 'Defne',
      'company': 'Olivara',
      'oneLiner':
          'une huile d’olive fraîche et traçable d’oliveraies familiales',
      'hook': 'votre publication sur les étiquettes alimentaires honnêtes',
      'traction': '8 000 commandes et 38 % de réachat',
    },
    'seoKeywords': {
      'topic': 'huile d’olive',
      'audience': 'cuisiniers amateurs',
      'alternative': 'huile d’olive de supermarché',
      'location': 'France',
    },
    'crm': {'company': 'Bella Cucina', 'next': 'Envoyer des échantillons'},
    'proposal': {
      'company': 'Olivara SAS',
      'client': 'Bella Cucina',
      'need':
          'Bella Cucina souhaite un approvisionnement régulier en huile d’olive premium, avec une histoire à partager avec ses clients.',
      'scope':
          '40 litres d’huile vierge extra par mois\nCartes de présentation de l’oliveraie pour les tables\nPrix fixe pendant 12 mois',
      'timeline': 'Première livraison dans la semaine suivant la signature',
      'sender': 'Defne Arslan',
    },
    'followUps': {'note': 'Envoyer des échantillons'},
    'feedback': {'from': 'Client'},
    'nda': {
      'company': 'Olivara SAS',
      'otherParty': 'Bella Cucina SARL',
      'purpose': 'l’évaluation d’un partenariat d’approvisionnement',
    },
    'privacyTerms': {
      'company': 'Olivara SAS',
      'service': 'la boutique en ligne Olivara',
      'email': 'confidentialite@olivara.shop',
      'data':
          'Nom et e-mail\nAdresse de livraison\nHistorique des commandes\nStatistiques du site',
    },
    'contract': {
      'company': 'Olivara SAS',
      'scope': 'Conception du coffret cadeau des fêtes et des étiquettes',
    },
    'jobPost': {
      'company': 'Olivara',
      'oneLiner':
          'une huile d’olive fraîche et traçable d’oliveraies familiales',
      'title': 'Responsable marketing de croissance',
      'location': 'À distance (fuseaux horaires européens)',
      'responsibilities':
          'Piloter la publicité sociale, du visuel au budget\nDévelopper l’e-mail et l’abonnement de recharge\nTravailler avec des créateurs culinaires',
      'requirements':
          '3 ans ou plus en marketing e-commerce\nÀ l’aise avec les budgets et les chiffres\nL’amour de la bonne cuisine',
      'email': 'emplois@olivara.shop',
    },
    'interviewLibrary': {
      'company': 'Olivara',
      'title': 'Responsable marketing de croissance',
    },
    'meetingNotes': {'owner': 'Defne', 'meeting': 'Point ops hebdomadaire'},
    'storeListing': {
      'app': 'Olivara',
      'subtitle': 'Huile d’olive fraîche, livrée',
      'oneLiner': 'l’huile d’olive directement de l’oliveraie',
      'audience': 'cuisiniers amateurs',
      'features':
          'Commandez en deux gestes\nGérez votre abonnement de recharge\nRecettes de nos producteurs partenaires\nSuivez chaque livraison',
      'price': 'Téléchargement gratuit. Vous ne payez que vos commandes.',
      'proof': 'Notée 4,9 par 8 000 clients',
    },
    'asoKeywords': {
      'app': 'Olivara',
      'primary': 'huile d’olive',
      'secondary': 'épicerie',
      'audience': 'cuisinier',
      'keywords': 'bio,aliment,livraison,recettes,gourmet,sain,boutique,cadeau',
      'competitor': 'GroveBox',
    },
    'reviewReply': {
      'app': 'Olivara',
      'topic': 'le délai de livraison',
      'email': 'aide@olivara.shop',
    },
    'appPrivacy': {
      'app': 'Olivara',
      'developer': 'Olivara SAS',
      'email': 'confidentialite@olivara.shop',
    },
  },
  samples: {
    'competitors': [
      SampleText('Golden Press', {
        'price': '37 \$ la bouteille',
        'strength': 'Très belle image de marque',
        'weakness': 'Très chère',
      }),
      SampleText('Marques de supermarché', {
        'price': '9 \$ la bouteille',
        'strength': 'Bon marché et partout',
        'weakness': 'Coupée, sans date de récolte',
      }),
      SampleText('GroveBox', {
        'price': '29 \$ par mois',
        'strength': 'Modèle d’abonnement',
        'weakness': 'Expédie depuis un seul entrepôt',
      }),
    ],
    'incomeExpense': [
      SampleText('Ventes de la boutique en ligne (octobre)', {
        'category': 'Revenus',
      }),
      SampleText('Huile des oliveraies partenaires', {'category': 'Stock'}),
      SampleText('Expédition et emballage', {'category': 'Logistique'}),
    ],
    'investorTracker': [
      SampleText('Maya Chen', {
        'firm': 'Harvest Consumer Fund',
        'next': 'Réunion des associés jeudi',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Business angel (ex-fondateur d’une marque alimentaire)',
        'next': 'Envoyer le BSA-AIR',
      }),
      SampleText('D2C Seed Partners', {
        'firm': 'Fonds pré-seed',
        'next': 'Demander une intro à Jordan',
      }),
    ],
    'kanban': [
      SampleText('Photographier le coffret cadeau des fêtes', {'owner': 'Leo'}),
      SampleText('Négocier les tarifs d’expédition vers les États-Unis', {
        'owner': 'Defne',
      }),
      SampleText('Lancer l’abonnement de recharge', {'owner': 'Leo'}),
    ],
    'okr': [
      SampleText('Taux de réachat supérieur à 40 %', {
        'objective': 'Faire revenir les clients',
      }),
      SampleText('1 000 abonnés', {'objective': 'Faire revenir les clients'}),
      SampleText('Ouvrir un entrepôt aux États-Unis', {
        'objective': 'Livrer plus vite aux États-Unis',
      }),
    ],
    'roadmap': [
      SampleText('Coffrets cadeaux des fêtes', {
        'why': 'Demande n° 1 en décembre dernier',
      }),
      SampleText('Entrepôt aux États-Unis', {
        'why': 'Livraison réduite à 3 jours',
      }),
      SampleText('Huiles aromatisées', {
        'why': 'Meilleure marge, nouveaux clients',
      }),
    ],
    'standup': [
      SampleText('120 commandes des fêtes emballées', {'who': 'Ali'}),
      SampleText('Appel avec le nouveau transporteur', {'who': 'Defne'}),
      SampleText('En attente des étiquettes de l’imprimeur', {'who': 'Leo'}),
    ],
    'contentCalendar': [
      SampleText('Reconnaître une huile d’olive fraîche d’une vieille', {
        'channel': 'Blog',
      }),
      SampleText('Jour de récolte dans notre oliveraie partenaire', {
        'channel': 'Instagram',
      }),
      SampleText('Guide des cadeaux des fêtes', {'channel': 'Newsletter'}),
    ],
    'crm': [
      SampleText('Claire Martin', {
        'company': 'Bella Cucina',
        'next': 'Dégustation mar. 10 h',
      }),
      SampleText('Marco Rossi', {
        'company': 'Épicerie Rossi',
        'next': 'Relancer vendredi',
      }),
      SampleText('Hanna Berg', {
        'company': 'Bistro Berg',
        'next': 'Première livraison',
      }),
    ],
    'followUps': [
      SampleText('Claire : envoyer les notes de dégustation', {
        'note': 'Joindre la liste de prix',
      }),
      SampleText('Maya : notes de la réunion des associés', {
        'note': 'En attente de retour',
      }),
      SampleText('Hanna : point après la première livraison', {
        'note': 'Tout va bien',
      }),
    ],
    'feedback': [
      SampleText('Une petite bouteille d’essai', {
        'from': 'Avis de la boutique',
      }),
      SampleText('Emballage sans plastique', {'from': 'Abonnés Instagram'}),
      SampleText('Livraison plus rapide', {'from': 'Enquête de commande'}),
    ],
    'meetingNotes': [
      SampleText('Envoyer le point investisseurs', {
        'owner': 'Defne',
        'meeting': 'Point ops hebdomadaire',
      }),
      SampleText('Corriger l’abandon au paiement', {
        'owner': 'Leo',
        'meeting': 'Revue croissance',
      }),
      SampleText('Choisir un transporteur pour les États-Unis', {
        'owner': 'Ali',
        'meeting': 'Point ops hebdomadaire',
      }),
    ],
    'kpiBoard': [
      SampleText('Revenu mensuel', {
        'current': '42 000 \$',
        'target': '50 000 \$',
      }),
      SampleText('Taux de réachat', {'current': '34 %', 'target': '40 %'}),
      SampleText('Taux de retour', {'current': '5 %', 'target': '2 %'}),
    ],
  },
);
