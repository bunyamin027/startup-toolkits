import '../l10n/tool_text.dart';
import 'scenario.dart';

/// Mobile app example (Pacely) in German.
const mobileAppDe = ScenarioText(
  fields: {
    'leanCanvas': {
      'company': 'Pacely',
      'problem':
          'Standard-Laufpläne ignorieren Schlaf, Stress und verpasste Einheiten.\n'
          'Anfänger verletzen sich, weil sie zu früh zu viel machen.\n'
          'Ein persönlicher Trainer ist für die meisten zu teuer.',
      'solution':
          'Ein KI-Coach, der die Woche nach jedem Lauf neu plant.\n'
          'Belastungswarnungen vor der Verletzung, nicht danach.\n'
          'Sprachhinweise beim Laufen, in einfachen Worten.',
      'uvp':
          'Ein Laufcoach in der Hosentasche, der sich an deine echte Woche anpasst.',
      'segment':
          'Freizeitläufer, die sich auf ihren ersten 10-km-Lauf oder Halbmarathon vorbereiten',
      'channels':
          'App Store und Google Play\nLauftreffs\nInstagram- und Strava-Communitys',
      'revenue':
          'Kostenloser Tarif\nPremium: 9,99 \$ im Monat oder 59,99 \$ im Jahr',
      'costs': 'App-Entwicklung\nCloud- und KI-Kosten\nGebühren der App-Stores',
      'metrics':
          'Wöchentlich aktive Läufer\nUmwandlung von kostenlos zu zahlend\n30-Tage-Bindung',
      'advantage':
          'Ein Trainingsmodell, mit Sportwissenschaftlern auf 2 Millionen echten Läufen entwickelt.',
    },
    'swot': {
      'company': 'Pacely',
      'strengths':
          'Pläne, die sich jede Woche anpassen\nHohe App-Store-Bewertung\nSportwissenschaftler im Team',
      'weaknesses':
          'Abhängig von Uhrendaten\nKleines Marketingbudget\nNur Laufen, keine anderen Sportarten',
      'opportunities':
          'Immer mehr Anmeldungen zu Läufen\nPartnerschaften mit Veranstaltern\nBetriebliche Gesundheitsprogramme',
      'threats':
          'Uhrenhersteller bauen eigenes Coaching ein\nGeänderte Abo-Regeln der Plattformen',
    },
    'competitors': {
      'price': '12,99 \$ im Monat',
      'strength': 'Marke',
      'weakness': 'Starre Pläne',
    },
    'persona': {
      'name': 'Läuferin Rahel',
      'role': 'Lehrerin, die ihren ersten Halbmarathon vorbereitet',
      'age': '31',
      'location': 'Hamburg',
      'goals':
          'Einen Halbmarathon ohne Verletzung beenden\nDreimal pro Woche laufen',
      'pains':
          'Jeder Plan zerfällt nach einer schlechten Woche, und sie hatte schon eine Schienbeinkantenreizung',
      'tools': 'Eine Smartwatch\nStrava\nLaufvideos auf YouTube',
      'quote':
          'Ich brauche keinen Plan für eine perfekte Woche. Ich brauche einen für meine Woche.',
      'channels':
          'Lauftreff vor Ort\nLauf-Accounts auf Instagram\nNewsletter von Laufveranstaltungen',
    },
    'interviewQuestions': {
      'segment': 'Freizeitläufer',
      'problemArea': 'die Vorbereitung auf einen Lauf',
      'product': 'Pacely',
    },
    'invoice': {
      'company': 'Pacely GmbH',
      'email': 'rechnung@pacely.app',
      'client': 'Seeufer-Halbmarathon',
      'item1': 'Partnerschaft offizieller Trainingsplan (Saison)',
      'item2': 'Premium-Codes für 500 Läufer',
    },
    'incomeExpense': {'category': 'Cloud'},
    'pitchDeck': {
      'company': 'Pacely',
      'oneLiner':
          'Ein KI-Laufcoach, der deinen Plan an deine echte Woche anpasst.',
      'problem':
          'Die meisten Läufer folgen starren Plänen, die nach einer schlechten Woche zerbrechen, und viele verletzen sich.',
      'solution':
          'Pacely plant jede Woche nach Schlaf, Läufen und Befinden neu und warnt, bevor du es übertreibst.',
      'market':
          '60 Mio. Freizeitläufer in den USA und der EU; erreichbarer Markt von 1,2 Mrd. \$',
      'model': 'Freemium; Premium für 9,99 \$ im Monat oder 59,99 \$ im Jahr',
      'traction': '120.000 Downloads, 6.500 zahlende Läufer, Bewertung 4,8',
      'competition':
          'Apps mit starren Plänen (günstig, nicht adaptiv), persönliche Trainer (super, aber 150 \$ im Monat)',
      'team':
          'Defne (CEO, ehem. Produktleiterin einer Fitness-App), Leo (CTO, ML-Ingenieur), Ali (Cheftrainer, Sportwissenschaftler)',
      'ask':
          '1,5 Mio. \$ Seed für den Android-Start und mehr Laufpartnerschaften',
      'email': 'gruender@pacely.app',
    },
    'onePager': {
      'company': 'Pacely',
      'oneLiner':
          'Ein KI-Laufcoach, der deinen Plan an deine echte Woche anpasst.',
      'problem':
          'Die meisten Läufer folgen starren Plänen, die nach einer schlechten Woche zerbrechen, und viele verletzen sich.',
      'solution':
          'Pacely plant jede Woche nach Schlaf, Läufen und Befinden neu und warnt, bevor du es übertreibst.',
      'customer': 'Freizeitläufer, die sich auf einen Lauf vorbereiten',
      'market': 'Erreichbarer Markt von 1,2 Mrd. \$',
      'traction': '120.000 Downloads, 6.500 zahlende Läufer',
      'team': 'Defne (CEO), Leo (CTO), Ali (Cheftrainer)',
      'ask': '1,5 Mio. \$ Seed',
      'email': 'gruender@pacely.app',
    },
    'investorTracker': {
      'firm': 'Consumer-App-Fonds',
      'next': 'Bindungsdaten senden',
    },
    'kanban': {'owner': 'Leo'},
    'okr': {'objective': 'Läufer im Training halten'},
    'roadmap': {'why': 'Läufer fragen danach'},
    'userStory': {
      'feature': 'Ausgleich verpasster Läufe',
      'user': 'Läufer',
      'want': 'dass sich mein Plan anpasst, wenn ich einen Lauf verpasse',
      'benefit':
          'ich auf Kurs bleibe, ohne doppelt zu laufen und mich zu verletzen',
      'criteria':
          'Ein verpasster Lauf wird am nächsten Morgen erkannt\nDer Rest der Woche wird automatisch neu verteilt\nDie Wochendistanz steigt nie um mehr als 10 %\nDer Läufer sieht, was sich geändert hat und warum',
      'outOfScope':
          'Pläne für Ausgleichssport\nJede Einheit von Hand bearbeiten',
      'metric': '15 % weniger Läufer, die ihren Plan im ersten Monat abbrechen',
    },
    'standup': {'who': 'Leo'},
    'brandName': {
      'keyword': 'tempo',
      'keyword2': 'schritt',
      'benefit': 'klüger trainieren, nicht härter',
      'audience': 'Läufer',
    },
    'colorPalette': {'company': 'Pacely'},
    'landingPage': {
      'company': 'Pacely',
      'audience': 'Läufer',
      'outcome': 'Fit an den Start, nicht verletzt',
      'problem': 'Starre Pläne zerbrechen, sobald das Leben hektisch wird.',
      'features':
          'Ein Plan, der sich nach jedem Lauf anpasst\nWarnungen vor Übertraining\nSprachcoaching beim Laufen',
      'proof': 'Mit 4,8 bewertet von 6.500 Läufern',
      'cta': 'Kostenlos starten',
    },
    'emailTemplates': {
      'sender': 'Defne',
      'company': 'Pacely',
      'oneLiner': 'ein KI-Laufcoach, der sich an deine echte Woche anpasst',
      'hook': 'dein Vortrag über Verletzungen bei Laufanfängern',
      'traction': '6.500 zahlende Läufer und eine Bewertung von 4,8',
    },
    'seoKeywords': {
      'topic': 'Halbmarathon-Training',
      'audience': 'Laufanfänger',
      'alternative': 'einen Lauftrainer',
      'location': 'Hamburg',
    },
    'crm': {
      'company': 'Seeufer-Halbmarathon',
      'next': 'Partnerschaftspräsentation senden',
    },
    'proposal': {
      'company': 'Pacely GmbH',
      'client': 'Seeufer-Halbmarathon',
      'need':
          'Der Veranstalter möchte, dass mehr Erstläufer gut vorbereitet an den Start gehen und das Ziel erreichen.',
      'scope':
          'Offizieller Pacely-Trainingsplan für den Lauf\n3 Monate Premium für alle Angemeldeten\nEin Finisher-Bericht für die Veranstalter',
      'timeline': 'Plan 16 Wochen vor dem Lauf verfügbar',
      'sender': 'Defne Arslan',
    },
    'followUps': {'note': 'Partnerschaftspräsentation senden'},
    'feedback': {'from': 'Läufer'},
    'nda': {
      'company': 'Pacely GmbH',
      'otherParty': 'Seeufer Events GmbH',
      'purpose': 'die Prüfung einer Laufpartnerschaft',
    },
    'privacyTerms': {
      'company': 'Pacely GmbH',
      'service': 'die Pacely-App',
      'email': 'datenschutz@pacely.app',
      'data':
          'Name und E-Mail\nLauf- und Herzfrequenzdaten\nSchlafdaten, die du teilen möchtest\nApp-Statistiken',
    },
    'contract': {
      'company': 'Pacely GmbH',
      'scope': 'Aufnahme der Sprachhinweise auf Deutsch',
    },
    'jobPost': {
      'company': 'Pacely',
      'oneLiner': 'ein KI-Laufcoach, der sich an deine echte Woche anpasst',
      'title': 'Senior Mobile Engineer (Flutter) (m/w/d)',
      'location': 'Remote (US- oder europäische Zeitzonen)',
      'responsibilities':
          'Neue Funktionen in unserer Flutter-App bauen\nUhren und Gesundheitsplattformen anbinden\nDie App schnell und absturzfrei halten',
      'requirements':
          'Mindestens 4 Jahre Erfahrung mit mobilen Apps\nEine Flutter-App in beiden Stores veröffentlicht\nDu läufst oder möchtest es',
      'email': 'jobs@pacely.app',
    },
    'interviewLibrary': {
      'company': 'Pacely',
      'title': 'Senior Mobile Engineer',
    },
    'meetingNotes': {'owner': 'Leo', 'meeting': 'Wöchentliches Produktmeeting'},
    'storeListing': {
      'app': 'Pacely',
      'subtitle': 'KI-Laufcoach',
      'oneLiner': 'ein Laufplan, der sich an deine Woche anpasst',
      'audience': 'Läufer jedes Niveaus',
      'features':
          'Pläne von 5 km bis Marathon\nPasst sich nach jedem Lauf an\nWarnt vor Übertraining\nFunktioniert mit deiner Uhr',
      'price': 'Kostenlos starten. Premium ab 9,99 \$ im Monat.',
      'proof': 'Mit 4,8 bewertet von 6.500 Läufern',
    },
    'asoKeywords': {
      'app': 'Pacely',
      'primary': 'laufcoach',
      'secondary': 'marathon',
      'audience': 'läufer',
      'keywords': 'laufen,training,plan,5k,10k,tempo,joggen,fitness',
      'competitor': 'StrideMate',
    },
    'reviewReply': {
      'app': 'Pacely',
      'topic': 'die Synchronisierung mit der Uhr',
      'email': 'hilfe@pacely.app',
    },
    'appPrivacy': {
      'app': 'Pacely',
      'developer': 'Pacely GmbH',
      'email': 'datenschutz@pacely.app',
    },
  },
  samples: {
    'competitors': [
      SampleText('StrideMate', {
        'price': '12,99 \$ im Monat',
        'strength': 'Riesige Planbibliothek',
        'weakness': 'Pläne passen sich nie an',
      }),
      SampleText('Apps der Uhrenhersteller', {
        'price': 'Kostenlos mit der Uhr',
        'strength': 'Schon am Handgelenk',
        'weakness': 'Einfaches Coaching',
      }),
      SampleText('Persönliche Trainer', {
        'price': '150 \$ im Monat',
        'strength': 'Wirklich persönlich',
        'weakness': 'Für die meisten zu teuer',
      }),
    ],
    'incomeExpense': [
      SampleText('Store-Abos (Oktober)', {'category': 'Umsatz'}),
      SampleText('Cloud- und KI-Hosting', {'category': 'Cloud'}),
      SampleText('Instagram-Werbung', {'category': 'Marketing'}),
    ],
    'investorTracker': [
      SampleText('Maya Chen', {
        'firm': 'Stride Ventures',
        'next': 'Partnermeeting Donnerstag',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Business Angel (ehem. Gründer einer Fitness-App)',
        'next': 'Wandeldarlehen senden',
      }),
      SampleText('App Seed Partners', {
        'firm': 'Pre-Seed-Fonds',
        'next': 'Jordan um Intro bitten',
      }),
    ],
    'kanban': [
      SampleText('Android-Beta veröffentlichen', {'owner': 'Leo'}),
      SampleText('Uhren-Sync auf älteren Handys reparieren', {'owner': 'Leo'}),
      SampleText('Text für die neue Abo-Seite schreiben', {'owner': 'Defne'}),
    ],
    'okr': [
      SampleText('30-Tage-Bindung über 40 %', {
        'objective': 'Läufer im Training halten',
      }),
      SampleText('10.000 zahlende Läufer', {'objective': 'Premium ausbauen'}),
      SampleText('Absturzfreie Sitzungen über 99,5 %', {
        'objective': 'Läufer im Training halten',
      }),
    ],
    'roadmap': [
      SampleText('Android-App', {
        'why': 'Die Hälfte der Warteliste nutzt Android',
      }),
      SampleText('Laufpartnerschaften', {
        'why': 'Bringt Läufer im richtigen Moment',
      }),
      SampleText('Krafttraining', {'why': 'Hilft, Verletzungen vorzubeugen'}),
    ],
    'standup': [
      SampleText('Version 2.3 veröffentlicht', {'who': 'Leo'}),
      SampleText('Gespräch mit dem Laufveranstalter', {'who': 'Defne'}),
      SampleText('Warten auf das App Review', {'who': 'Leo'}),
    ],
    'contentCalendar': [
      SampleText('So bereitest du deinen ersten Halbmarathon vor', {
        'channel': 'Blog',
      }),
      SampleText('Läufergeschichte: vom Sofa zu 10 km', {
        'channel': 'Instagram',
      }),
      SampleText('Neu in Version 2.3', {'channel': 'Newsletter'}),
    ],
    'crm': [
      SampleText('Lena Fischer', {
        'company': 'Seeufer-Halbmarathon',
        'next': 'Demo Di. 10:00',
      }),
      SampleText('Marco Rossi', {
        'company': 'Stadtläufer e. V.',
        'next': 'Freitag nachfassen',
      }),
      SampleText('Hanna Berg', {
        'company': 'FitWork Gesundheit',
        'next': 'Pilotstart',
      }),
    ],
    'followUps': [
      SampleText('Lena: Partnerschaftspräsentation senden', {
        'note': 'Ergebnisse der letzten Saison beilegen',
      }),
      SampleText('Maya: Notizen zum Partnermeeting', {
        'note': 'Warten auf Feedback',
      }),
      SampleText('Hanna: Rückfrage zum Pilot', {'note': 'Alles in Ordnung'}),
    ],
    'feedback': [
      SampleText('Laufband-Modus', {'from': 'App-Store-Bewertungen'}),
      SampleText('Plan mit Freunden teilen', {'from': 'Umfrage in der App'}),
      SampleText('Apple-Watch-App', {'from': 'Support-E-Mails'}),
    ],
    'meetingNotes': [
      SampleText('Investoren-Update senden', {
        'owner': 'Defne',
        'meeting': 'Wöchentliches Produktmeeting',
      }),
      SampleText('Abbrüche auf der Abo-Seite beheben', {
        'owner': 'Leo',
        'meeting': 'Wachstums-Review',
      }),
      SampleText('Neues Planmodell prüfen', {
        'owner': 'Ali',
        'meeting': 'Wöchentliches Produktmeeting',
      }),
    ],
    'kpiBoard': [
      SampleText('Monatlich wiederkehrender Umsatz', {
        'current': '38.000 \$',
        'target': '50.000 \$',
      }),
      SampleText('30-Tage-Bindung', {'current': '34 %', 'target': '40 %'}),
      SampleText('Monatliche Kündigungsrate', {
        'current': '5 %',
        'target': '2 %',
      }),
    ],
  },
);
