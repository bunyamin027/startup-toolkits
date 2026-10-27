import '../l10n/tool_text.dart';
import 'scenario.dart';

/// E-commerce example (Olivara) in German.
const ecommerceDe = ScenarioText(
  fields: {
    'leanCanvas': {
      'company': 'Olivara',
      'problem':
          'Olivenöl aus dem Supermarkt ist oft verschnitten, alt oder falsch etikettiert.\n'
          'Kleine Familienhaine erreichen keine Käufer im Ausland.\n'
          'Im Regal ist gutes Öl kaum zu erkennen.',
      'solution':
          'Öl von einem einzigen Gut, wenige Wochen nach der Ernte verschickt.\n'
          'Erntedatum und Hain auf jeder Flasche.\n'
          'Ein Nachfüll-Abo, das kommt, bevor das Öl ausgeht.',
      'uvp':
          'Frisches, rückverfolgbares Olivenöl direkt vom Hain in deine Küche.',
      'segment': 'Hobbyköche in den USA und Europa, die Feinkost online kaufen',
      'channels':
          'Rezepte auf Instagram und TikTok\nFood-Blogger\nOnline-Marktplätze',
      'revenue': 'Flaschen: je 24 \$\nNachfüll-Abo: 19 \$ im Monat',
      'costs':
          'Öl von Partnerhainen\nAbfüllung und Versand\nSocial-Media-Werbung',
      'metrics':
          'Wiederkaufrate\nKundengewinnungskosten\nDurchschnittlicher Bestellwert',
      'advantage':
          'Exklusive Verträge mit 9 Familienhainen und eine preisgekrönte Ernte.',
    },
    'swot': {
      'company': 'Olivara',
      'strengths':
          'Preisgekröntes Öl\nDirekte Verträge mit Familienhainen\nStarke Instagram-Community',
      'weaknesses':
          'Nur eine Produktkategorie\nHohe Versandkosten in die USA\nSaisonale Ernte, begrenzter Bestand',
      'opportunities':
          'Wachsende Nachfrage nach rückverfolgbaren Lebensmitteln\nGeschenkboxen für die Feiertage\nRestaurants, die in großen Mengen kaufen',
      'threats':
          'Schlechte Ernten nach Dürre\nBillige Verschnitte mit edlen Etiketten',
    },
    'competitors': {
      'price': '18 \$ pro Flasche',
      'strength': 'Marke',
      'weakness': 'Verschnittenes Öl',
    },
    'persona': {
      'name': 'Feinschmeckerin Fiona',
      'role': 'Marketingmanagerin, die leidenschaftlich gern kocht',
      'age': '34',
      'location': 'München',
      'goals':
          'Zu Hause gesünder kochen\nLebensmittel mit klarer Herkunft kaufen',
      'pains':
          'Ist auf „nativ extra“-Etiketten hereingefallen und erkennt gutes Öl nicht',
      'tools':
          'Instagram-Rezepte\nEine Lebensmittel-Liefer-App\nOnline-Marktplätze',
      'quote': 'Wenn ich für gutes Öl zahle, will ich wissen, woher es kommt.',
      'channels':
          'Food-Accounts auf Instagram\nRezept-Newsletter\nWochenmärkte',
    },
    'interviewQuestions': {
      'segment': 'Hobbyköche, die Feinkost kaufen',
      'problemArea': 'den Kauf von Olivenöl',
      'product': 'Olivara',
    },
    'invoice': {
      'company': 'Olivara GmbH',
      'email': 'bestellung@olivara.shop',
      'client': 'Restaurant Bella Cucina',
      'item1': 'Natives Olivenöl extra, 5-Liter-Kanister',
      'item2': 'Geschenkbox (3 Flaschen)',
    },
    'incomeExpense': {'category': 'Versand'},
    'pitchDeck': {
      'company': 'Olivara',
      'oneLiner':
          'Frisches, rückverfolgbares Olivenöl von Familienhainen, direkt an deine Tür.',
      'problem':
          'Das meiste Olivenöl im Regal ist verschnitten oder alt, und kleine Haine erreichen keine Käufer im Ausland.',
      'solution':
          'Olivara verkauft online Öl von einem einzigen Gut, wenige Wochen nach der Ernte verschickt, mit Nachfüll-Abo.',
      'market':
          '45 Mio. Feinkostkäufer in den USA und der EU; erreichbarer Markt von 1,8 Mrd. \$',
      'model':
          'Direktverkauf für 24 \$ pro Flasche plus Nachfüll-Abo für 19 \$ im Monat',
      'traction': '8.000 Bestellungen, 38 % Wiederkauf, 42.000 \$ Monatsumsatz',
      'competition':
          'Supermarktmarken (billig, verschnitten), Premiummarken (teuer, nicht rückverfolgbar)',
      'team':
          'Defne (CEO, ehem. Markenmanagerin Lebensmittel), Leo (Wachstum, ehem. E-Commerce-Agentur), Ali (Einkauf, Olivenbauer in dritter Generation)',
      'ask': '900.000 \$ Seed für ein US-Lager und doppeltes Werbebudget',
      'email': 'gruender@olivara.shop',
    },
    'onePager': {
      'company': 'Olivara',
      'oneLiner':
          'Frisches, rückverfolgbares Olivenöl von Familienhainen, direkt an deine Tür.',
      'problem':
          'Das meiste Olivenöl im Regal ist verschnitten oder alt, und kleine Haine erreichen keine Käufer im Ausland.',
      'solution':
          'Olivara verkauft online Öl von einem einzigen Gut, wenige Wochen nach der Ernte verschickt, mit Nachfüll-Abo.',
      'customer': 'Hobbyköche in den USA und Europa',
      'market': 'Erreichbarer Markt von 1,8 Mrd. \$',
      'traction': '8.000 Bestellungen, 38 % Wiederkauf',
      'team': 'Defne (CEO), Leo (Wachstum), Ali (Einkauf)',
      'ask': '900.000 \$ Seed',
      'email': 'gruender@olivara.shop',
    },
    'investorTracker': {
      'firm': 'Consumer-Fonds',
      'next': 'Kohortendaten senden',
    },
    'kanban': {'owner': 'Defne'},
    'okr': {'objective': 'Kunden zum Wiederkommen bringen'},
    'roadmap': {'why': 'Kunden fragen danach'},
    'userStory': {
      'feature': 'Nachfüll-Abo',
      'user': 'Stammkunde',
      'want': 'eine neue Flasche bekommen, bevor meine leer ist',
      'benefit': 'ich nie ohne gutes Öl koche',
      'criteria':
          'Kunde wählt eine Lieferung alle 1, 2 oder 3 Monate\nKann mit einem Tipp überspringen oder pausieren\nErhält 3 Tage vor dem Versand eine Erinnerung\nWird automatisch zum Abo-Preis belastet',
      'outOfScope': 'Verschiedene Produkte in einer Box mischen\nGeschenk-Abos',
      'metric': '25 % der Kunden innerhalb von 3 Monaten im Abo',
    },
    'standup': {'who': 'Defne'},
    'brandName': {
      'keyword': 'olive',
      'keyword2': 'hain',
      'benefit': 'die Ernte zu Hause schmecken',
      'audience': 'Hobbyköche',
    },
    'colorPalette': {'company': 'Olivara'},
    'landingPage': {
      'company': 'Olivara',
      'audience': 'Hobbyköche',
      'outcome': 'Olivenöl, dem du vertrauen kannst',
      'problem':
          'Das meiste Supermarkt-Olivenöl ist verschnitten, alt oder beides.',
      'features':
          'Öl von einem Gut, wenige Wochen nach der Ernte abgefüllt\nErntedatum und Hain auf jeder Flasche\nNachfüllungen, bevor das Öl ausgeht',
      'proof': 'Mit 4,9 bewertet von 8.000 Kunden',
      'cta': 'Zur Ernte',
    },
    'emailTemplates': {
      'sender': 'Defne',
      'company': 'Olivara',
      'oneLiner': 'frisches, rückverfolgbares Olivenöl von Familienhainen',
      'hook': 'dein Beitrag über ehrliche Lebensmitteletiketten',
      'traction': '8.000 Bestellungen und 38 % Wiederkauf',
    },
    'seoKeywords': {
      'topic': 'Olivenöl',
      'audience': 'Hobbyköche',
      'alternative': 'Supermarkt-Olivenöl',
      'location': 'Deutschland',
    },
    'crm': {'company': 'Bella Cucina', 'next': 'Verkostungsproben senden'},
    'proposal': {
      'company': 'Olivara GmbH',
      'client': 'Bella Cucina',
      'need':
          'Bella Cucina wünscht eine verlässliche Versorgung mit Premium-Olivenöl, dessen Geschichte es mit den Gästen teilen kann.',
      'scope':
          '40 Liter natives Olivenöl extra pro Monat\nKarten mit der Geschichte des Hains für die Tische\nFestpreis für 12 Monate',
      'timeline': 'Erste Lieferung innerhalb einer Woche nach Unterzeichnung',
      'sender': 'Defne Arslan',
    },
    'followUps': {'note': 'Verkostungsproben senden'},
    'feedback': {'from': 'Kunde'},
    'nda': {
      'company': 'Olivara GmbH',
      'otherParty': 'Bella Cucina GmbH',
      'purpose': 'die Prüfung einer Lieferpartnerschaft',
    },
    'privacyTerms': {
      'company': 'Olivara GmbH',
      'service': 'den Olivara-Onlineshop',
      'email': 'datenschutz@olivara.shop',
      'data':
          'Name und E-Mail\nLieferadresse\nBestellverlauf\nWebsite-Statistiken',
    },
    'contract': {
      'company': 'Olivara GmbH',
      'scope': 'Gestaltung der Feiertags-Geschenkbox und der Flaschenetiketten',
    },
    'jobPost': {
      'company': 'Olivara',
      'oneLiner': 'frisches, rückverfolgbares Olivenöl von Familienhainen',
      'title': 'Growth Marketing Manager (m/w/d)',
      'location': 'Remote (europäische Zeitzonen)',
      'responsibilities':
          'Social-Media-Werbung von der Kreation bis zum Budget verantworten\nE-Mail und Nachfüll-Abo ausbauen\nMit Food-Creatorn zusammenarbeiten',
      'requirements':
          'Mindestens 3 Jahre E-Commerce-Marketing\nSicher im Umgang mit Werbebudgets und Zahlen\nLiebe zu gutem Essen',
      'email': 'jobs@olivara.shop',
    },
    'interviewLibrary': {
      'company': 'Olivara',
      'title': 'Growth Marketing Manager',
    },
    'meetingNotes': {'owner': 'Defne', 'meeting': 'Wöchentliches Ops-Meeting'},
    'storeListing': {
      'app': 'Olivara',
      'subtitle': 'Frisches Olivenöl, geliefert',
      'oneLiner': 'Olivenöl direkt vom Hain',
      'audience': 'Hobbyköche',
      'features':
          'Mit zwei Tipps bestellen\nNachfüll-Abo verwalten\nRezepte unserer Partnerbauern\nJede Lieferung verfolgen',
      'price': 'Kostenloser Download. Du zahlst nur deine Bestellungen.',
      'proof': 'Mit 4,9 bewertet von 8.000 Kunden',
    },
    'asoKeywords': {
      'app': 'Olivara',
      'primary': 'olivenöl',
      'secondary': 'lebensmittel',
      'audience': 'koch',
      'keywords': 'bio,essen,lieferung,rezepte,feinkost,gesund,shop,geschenk',
      'competitor': 'GroveBox',
    },
    'reviewReply': {
      'app': 'Olivara',
      'topic': 'die Lieferzeit',
      'email': 'hilfe@olivara.shop',
    },
    'appPrivacy': {
      'app': 'Olivara',
      'developer': 'Olivara GmbH',
      'email': 'datenschutz@olivara.shop',
    },
  },
  samples: {
    'competitors': [
      SampleText('Golden Press', {
        'price': '37 \$ pro Flasche',
        'strength': 'Wunderschönes Branding',
        'weakness': 'Sehr teuer',
      }),
      SampleText('Supermarktmarken', {
        'price': '9 \$ pro Flasche',
        'strength': 'Billig und überall',
        'weakness': 'Verschnitten, kein Erntedatum',
      }),
      SampleText('GroveBox', {
        'price': '29 \$ im Monat',
        'strength': 'Abo-Modell',
        'weakness': 'Versand aus nur einem Lager',
      }),
    ],
    'incomeExpense': [
      SampleText('Onlineshop-Umsatz (Oktober)', {'category': 'Umsatz'}),
      SampleText('Öl von Partnerhainen', {'category': 'Ware'}),
      SampleText('Versand und Verpackung', {'category': 'Logistik'}),
    ],
    'investorTracker': [
      SampleText('Maya Chen', {
        'firm': 'Harvest Consumer Fund',
        'next': 'Partnermeeting Donnerstag',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Business Angel (ehem. Gründer einer Lebensmittelmarke)',
        'next': 'Wandeldarlehen senden',
      }),
      SampleText('D2C Seed Partners', {
        'firm': 'Pre-Seed-Fonds',
        'next': 'Jordan um Intro bitten',
      }),
    ],
    'kanban': [
      SampleText('Fotos der Feiertags-Geschenkbox', {'owner': 'Leo'}),
      SampleText('Versandpreise in die USA verhandeln', {'owner': 'Defne'}),
      SampleText('Nachfüll-Abo starten', {'owner': 'Leo'}),
    ],
    'okr': [
      SampleText('Wiederkaufrate über 40 %', {
        'objective': 'Kunden zum Wiederkommen bringen',
      }),
      SampleText('1.000 Abonnenten', {
        'objective': 'Kunden zum Wiederkommen bringen',
      }),
      SampleText('US-Lager eröffnen', {
        'objective': 'Schneller in die USA liefern',
      }),
    ],
    'roadmap': [
      SampleText('Feiertags-Geschenkboxen', {
        'why': 'Meistgewünscht im letzten Dezember',
      }),
      SampleText('US-Lager', {'why': 'Lieferung in 3 Tagen'}),
      SampleText('Aromatisierte Öle', {'why': 'Höhere Marge, neue Kunden'}),
    ],
    'standup': [
      SampleText('120 Feiertagsbestellungen gepackt', {'who': 'Ali'}),
      SampleText('Gespräch mit dem neuen Paketdienst', {'who': 'Defne'}),
      SampleText('Warten auf Etiketten von der Druckerei', {'who': 'Leo'}),
    ],
    'contentCalendar': [
      SampleText('Frisches Olivenöl von altem unterscheiden', {
        'channel': 'Blog',
      }),
      SampleText('Erntetag in unserem Partnerhain', {'channel': 'Instagram'}),
      SampleText('Geschenkideen für die Feiertage', {'channel': 'Newsletter'}),
    ],
    'crm': [
      SampleText('Lena Fischer', {
        'company': 'Bella Cucina',
        'next': 'Verkostung Di. 10:00',
      }),
      SampleText('Marco Rossi', {
        'company': 'Feinkost Rossi',
        'next': 'Freitag nachfassen',
      }),
      SampleText('Hanna Berg', {
        'company': 'Bistro Berg',
        'next': 'Erste Lieferung',
      }),
    ],
    'followUps': [
      SampleText('Lena: Verkostungsnotizen senden', {
        'note': 'Preisliste beilegen',
      }),
      SampleText('Maya: Notizen zum Partnermeeting', {
        'note': 'Warten auf Feedback',
      }),
      SampleText('Hanna: Rückfrage nach erster Lieferung', {
        'note': 'Alles in Ordnung',
      }),
    ],
    'feedback': [
      SampleText('Kleinere Probierflasche', {'from': 'Shop-Bewertungen'}),
      SampleText('Plastikfreie Verpackung', {'from': 'Instagram-Follower'}),
      SampleText('Schnellere Lieferung', {'from': 'Bestellumfrage'}),
    ],
    'meetingNotes': [
      SampleText('Investoren-Update senden', {
        'owner': 'Defne',
        'meeting': 'Wöchentliches Ops-Meeting',
      }),
      SampleText('Abbrüche im Checkout beheben', {
        'owner': 'Leo',
        'meeting': 'Wachstums-Review',
      }),
      SampleText('Paketdienst für die USA wählen', {
        'owner': 'Ali',
        'meeting': 'Wöchentliches Ops-Meeting',
      }),
    ],
    'kpiBoard': [
      SampleText('Monatsumsatz', {
        'current': '42.000 \$',
        'target': '50.000 \$',
      }),
      SampleText('Wiederkaufrate', {'current': '34 %', 'target': '40 %'}),
      SampleText('Retourenquote', {'current': '5 %', 'target': '2 %'}),
    ],
  },
);
