import '../l10n/tool_text.dart';
import 'scenario.dart';

/// R&D example (Terralab) in German.
const rndDe = ScenarioText(
  fields: {
    'leanCanvas': {
      'company': 'Terralab',
      'problem':
          'Betriebe bewässern 30–40 % zu viel, weil die Bodenfeuchte geschätzt wird.\n'
          'Bodensensoren in Laborqualität kosten über 1.000 \$ pro Stück.\n'
          'Wasserpreise und Dürreauflagen steigen weiter.',
      'solution':
          'Eine 90-\$-Sonde, die die Feuchte in drei Tiefen misst.\n'
          'Ein Machine-Learning-Modell, das die Messwerte in einen täglichen Bewässerungsplan übersetzt.\n'
          'Hinweise aufs Handy, ganz ohne Agronomen.',
      'uvp':
          'Bodendaten in Laborqualität zu einem Zehntel des Preises: Jedes Feld wird nach Bedarf bewässert, nicht nach Gewohnheit.',
      'segment': 'Mittelgroße Obst- und Gemüsebetriebe in trockenen Regionen',
      'channels':
          'Landwirtschaftliche Genossenschaften\nHändler für Bewässerungstechnik\nFeldtage und Agrarmessen',
      'revenue':
          'Sonden: 90 \$ pro Stück\nDatenplattform: 4 \$ pro Sonde und Monat',
      'costs': 'F&E-Team und Labortests\nSondenfertigung\nFeldpiloten',
      'metrics':
          'Eingespartes Wasser pro Hektar\nInstallierte Sonden\nUmwandlung von Pilot zu zahlendem Kunden',
      'advantage':
          'Zum Patent angemeldetes Messverfahren und 3 Jahre Felddaten aus Universitätsversuchen.',
    },
    'swot': {
      'company': 'Terralab',
      'strengths':
          'Zum Patent angemeldeter Sensor\nPartnerschaft mit einem Universitätslabor\nFelddaten von 12 Pilotbetrieben',
      'weaknesses':
          'Lange Entwicklungszyklen bei Hardware\nNoch keine zertifizierte Fertigungslinie\nKleines Vertriebsteam',
      'opportunities':
          'Öffentliche Förderung für Wassereffizienz\nStrengere Bewässerungsregeln in Dürregebieten\nGenossenschaften, die in großen Mengen kaufen',
      'threats':
          'Große Bewässerungsmarken bringen eigene Sensoren\nEngpässe bei Elektronikbauteilen',
    },
    'competitors': {
      'price': '1.200 \$ pro Sensor',
      'strength': 'Genauigkeit',
      'weakness': 'Teuer',
    },
    'persona': {
      'name': 'Obstbauer Gabriel',
      'role': 'Besitzer einer 40-Hektar-Obstplantage',
      'age': '47',
      'location': 'Altes Land',
      'goals':
          'Wasserkosten senken, ohne Ertrag zu verlieren\nDie neuen Bewässerungsregeln einhalten',
      'pains':
          'Bewässert nach Gewohnheit und merkt Probleme erst, wenn die Bäume gestresst sind',
      'tools':
          'Eine Wetter-App\nEine Bewässerungsuhr\nTipps vom Agronomen der Genossenschaft',
      'quote':
          'Ich brauche nicht mehr Daten. Ich muss wissen, wann ich gießen soll.',
      'channels':
          'Genossenschaftstreffen\nBewässerungshändler\nWhatsApp-Gruppen der Erzeuger vor Ort',
    },
    'interviewQuestions': {
      'segment': 'Obst- und Gemüsebauern',
      'problemArea': 'Bewässerungsplanung',
      'product': 'Terralab',
    },
    'invoice': {
      'company': 'Terralab GmbH',
      'email': 'rechnung@terralab.io',
      'client': 'Genossenschaft Grünes Tal eG',
      'item1': 'Bodensonden-Set (10 Sonden)',
      'item2': 'Datenplattform, Jahreslizenz pro Betrieb',
    },
    'incomeExpense': {'category': 'Labor'},
    'pitchDeck': {
      'company': 'Terralab',
      'oneLiner':
          'Günstige Bodensensoren, die Betrieben genau sagen, wann sie bewässern sollen.',
      'problem':
          'Betriebe bewässern 30–40 % zu viel, weil genaue Bodensensoren über 1.000 \$ kosten.',
      'solution':
          'Eine 90-\$-Sonde und ein Machine-Learning-Modell, die Bodenmesswerte in einen täglichen Bewässerungsplan übersetzen.',
      'market':
          '570.000 mittelgroße Betriebe in trockenen Regionen; 2,1 Mrd. \$ adressierbarer Markt',
      'model':
          'Sondenverkauf plus 4 \$ pro Sonde und Monat für die Datenplattform',
      'traction':
          '12 Pilotbetriebe, im Schnitt 31 % weniger Wasser, Patent angemeldet, 250.000 \$ F&E-Förderung',
      'competition':
          'Laborsensoren (genau, aber teuer), Satellitendienste (günstig, aber grob)',
      'team':
          'Elif (CEO, Agronomin), Can (CTO, Promotion in Sensorik), Jonas (Hardware-Lead, früher bei einem Bewässerungshersteller)',
      'ask':
          '1,2 Mio. \$ Seed, um die Fertigung zu zertifizieren und 300 Betriebe zu erreichen',
      'email': 'gruender@terralab.io',
    },
    'onePager': {
      'company': 'Terralab',
      'oneLiner':
          'Günstige Bodensensoren, die Betrieben genau sagen, wann sie bewässern sollen.',
      'problem':
          'Betriebe bewässern 30–40 % zu viel, weil genaue Bodensensoren über 1.000 \$ kosten.',
      'solution':
          'Eine 90-\$-Sonde und ein Machine-Learning-Modell, die Bodenmesswerte in einen täglichen Bewässerungsplan übersetzen.',
      'customer': 'Mittelgroße Obst- und Gemüsebetriebe in trockenen Regionen',
      'market': '2,1 Mrd. \$ adressierbarer Markt',
      'traction': '12 Pilotbetriebe, 31 % weniger Wasser, Patent angemeldet',
      'team': 'Elif (CEO), Can (CTO), Jonas (Hardware)',
      'ask': '1,2 Mio. \$ Seed',
      'email': 'gruender@terralab.io',
    },
    'investorTracker': {
      'firm': 'Impact-Fonds',
      'next': 'Pilotergebnisse schicken',
    },
    'kanban': {'owner': 'Elif'},
    'okr': {'objective': 'Wassereinsparung im Feld beweisen'},
    'roadmap': {'why': 'Von Pilotbetrieben gewünscht'},
    'userStory': {
      'feature': 'Täglicher Bewässerungsplan',
      'user': 'Betriebsleiter',
      'want': 'sehen, wie lange ich jedes Feld heute bewässern soll',
      'benefit': 'ich nicht mehr rate und Wasser spare',
      'criteria':
          'Der Plan steht jeden Tag um 6 Uhr bereit\nZeigt Minuten pro Feld und Zone\nErklärt den Grund in einer Zeile\nFunktioniert mit der vorhandenen Bewässerungsuhr',
      'outOfScope': 'Automatische Ventilsteuerung\nDüngeempfehlungen',
      'metric':
          '25 % weniger Wasser auf den Pilotbetrieben innerhalb einer Saison',
    },
    'standup': {'who': 'Elif'},
    'brandName': {
      'keyword': 'boden',
      'keyword2': 'terra',
      'benefit': 'jedes Feld nach Bedarf statt nach Gewohnheit bewässern',
      'audience': 'Erzeuger',
    },
    'colorPalette': {'company': 'Terralab'},
    'landingPage': {
      'company': 'Terralab',
      'audience': 'Erzeuger',
      'outcome': 'Wisse genau, wann du bewässern musst',
      'problem':
          'Nach Gewohnheit zu bewässern kostet Wasser, Geld und manchmal die Ernte.',
      'features':
          'Eine 90-\$-Sonde, die drei Bodentiefen misst\nEin täglicher Bewässerungsplan für jedes Feld\nHinweise, bevor die Pflanzen leiden',
      'proof': 'Auf 12 Betrieben getestet, 31 % weniger Wasser',
      'cta': 'Pilot anfragen',
    },
    'emailTemplates': {
      'sender': 'Elif',
      'company': 'Terralab',
      'oneLiner':
          'günstige Bodensensoren, die Betrieben sagen, wann sie bewässern sollen',
      'hook': 'dein Vortrag über Climate Tech auf dem AgriFood Summit',
      'traction': '12 Pilotbetriebe und ein angemeldetes Patent',
    },
    'seoKeywords': {
      'topic': 'Bodenfeuchtesensor',
      'audience': 'Erzeuger',
      'alternative': 'Tensiometer',
      'location': 'Brandenburg',
    },
    'crm': {
      'company': 'Genossenschaft Grünes Tal',
      'next': 'Feldbesuch vereinbaren',
    },
    'proposal': {
      'company': 'Terralab GmbH',
      'client': 'Genossenschaft Grünes Tal eG',
      'need':
          'Grünes Tal möchte, dass seine 15 Mitgliedsbetriebe weniger Bewässerungswasser verbrauchen, ohne Ertrag zu verlieren.',
      'scope':
          '60 Bodensonden auf 15 Betrieben installiert\nDatenplattform für eine Saison\nSchulungstag für Betriebsleiter',
      'timeline':
          'Sonden innerhalb von drei Wochen nach Unterschrift installiert',
      'sender': 'Elif Kaya',
    },
    'followUps': {'note': 'Pilotergebnisse schicken'},
    'feedback': {'from': 'Pilotbetrieb'},
    'nda': {
      'company': 'Terralab GmbH',
      'otherParty': 'Genossenschaft Grünes Tal eG',
      'purpose': 'die Prüfung eines gemeinsamen Feldversuchs',
    },
    'privacyTerms': {
      'company': 'Terralab GmbH',
      'service': 'die Terralab-App und die Bodensonden',
      'email': 'datenschutz@terralab.io',
      'data':
          'Name und E-Mail\nStandort des Betriebs und Feldgrenzen\nBodenmesswerte deiner Sonden\nNutzungsstatistiken der App',
    },
    'contract': {
      'company': 'Terralab GmbH',
      'scope': 'Ein wetterfestes Sondengehäuse für den Feldeinsatz entwerfen',
    },
    'jobPost': {
      'company': 'Terralab',
      'oneLiner':
          'günstige Bodensensoren, die Betrieben sagen, wann sie bewässern sollen',
      'title': 'Embedded-Firmware-Entwickler (m/w/d)',
      'location': 'Hybrid (zwei Tage pro Woche im Labor)',
      'responsibilities':
          'Die Sonden-Firmware vom Prototyp bis zur Serie verantworten\nDen Stromverbrauch auf zwei Saisons pro Batterie senken\nFeldtests mit Pilotbetrieben begleiten',
      'requirements':
          '3+ Jahre Embedded C auf stromsparenden Geräten\nErfahrung mit Sensorik oder Funk (LoRa, BLE)\nIm Feld genauso zu Hause wie im Labor',
      'email': 'jobs@terralab.io',
    },
    'interviewLibrary': {
      'company': 'Terralab',
      'title': 'Embedded-Firmware-Entwickler (m/w/d)',
    },
    'meetingNotes': {'owner': 'Elif', 'meeting': 'Wöchentliches F&E-Meeting'},
    'storeListing': {
      'app': 'Terralab',
      'subtitle': 'Smarte Bewässerung',
      'oneLiner': 'Bodensensoren, die dir sagen, wann du bewässern sollst',
      'audience': 'Erzeuger',
      'features':
          'Ein täglicher Bewässerungsplan für jedes Feld\nBodenfeuchte in drei Tiefen\nHinweise, bevor die Pflanzen leiden\nWasserspar-Berichte für Förderungen und Prüfungen',
      'price': 'Bei jeder Terralab-Sonde inklusive.',
      'proof': 'Im Einsatz auf 12 Pilotbetrieben',
    },
    'asoKeywords': {
      'app': 'Terralab',
      'primary': 'bewässerung',
      'secondary': 'boden',
      'audience': 'landwirt',
      'keywords': 'sensor,feuchte,wasser,hof,garten,obst,ernte,tropf',
      'competitor': 'AquaProbe',
    },
    'reviewReply': {
      'app': 'Terralab',
      'topic': 'die Bewässerungshinweise',
      'email': 'hilfe@terralab.io',
    },
    'appPrivacy': {
      'app': 'Terralab',
      'developer': 'Terralab GmbH',
      'email': 'datenschutz@terralab.io',
    },
  },
  samples: {
    'competitors': [
      SampleText('AquaProbe Pro', {
        'price': '1.200 \$ pro Sensor',
        'strength': 'Genauigkeit wie im Labor',
        'weakness': 'Für die meisten Betriebe zu teuer',
      }),
      SampleText('Tensiometer', {
        'price': 'Ab 80 \$',
        'strength': 'Günstig und bekannt',
        'weakness': 'Manuelles Ablesen in nur einer Tiefe',
      }),
      SampleText('SatIrrig', {
        'price': '6 \$ pro Hektar und Monat',
        'strength': 'Keine Hardware nötig',
        'weakness': 'Satellitendaten zu grob für ein einzelnes Feld',
      }),
    ],
    'incomeExpense': [
      SampleText('Abos der Pilotbetriebe', {'category': 'Umsatz'}),
      SampleText('Gehälter Entwicklung', {'category': 'Team'}),
      SampleText('Labortests und Bauteile', {'category': 'F&E'}),
    ],
    'investorTracker': [
      SampleText('Maya Chen', {
        'firm': 'AgriTech Ventures',
        'next': 'Partnermeeting am Donnerstag',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Business Angel (ehem. CEO eines Bewässerungsherstellers)',
        'next': 'Wandeldarlehen schicken',
      }),
      SampleText('Climate Seed Fund', {
        'firm': 'Klimafonds',
        'next': 'Jordan um ein Intro bitten',
      }),
    ],
    'kanban': [
      SampleText('Sondencharge Nr. 4 kalibrieren', {'owner': 'Can'}),
      SampleText('Zwischenbericht für die Förderung vorbereiten', {
        'owner': 'Elif',
      }),
      SampleText('Sonden auf Pilotbetrieb 12 installieren', {'owner': 'Jonas'}),
    ],
    'okr': [
      SampleText('Piloten auf 20 Betrieben durchführen', {
        'objective': 'Wassereinsparung im Feld beweisen',
      }),
      SampleText('Durchschnittliche Wassereinsparung über 25 %', {
        'objective': 'Wassereinsparung im Feld beweisen',
      }),
      SampleText('CE-Kennzeichnung erhalten', {
        'objective': 'Bereit für die Serienfertigung werden',
      }),
    ],
    'roadmap': [
      SampleText('Zwei Saisons mit einer Batterie', {
        'why': 'Wichtigster Wunsch der Pilotbetriebe',
      }),
      SampleText('Unterstützung für LoRaWAN-Gateways', {
        'why': 'Betriebe ohne Mobilfunkempfang',
      }),
      SampleText('Düngeempfehlungen', {
        'why': 'Eröffnet eine zweite Umsatzquelle',
      }),
    ],
    'standup': [
      SampleText('Feldtest auf Pilotbetrieb 7 abgeschlossen', {'who': 'Jonas'}),
      SampleText('Termin mit der Patentanwältin', {'who': 'Elif'}),
      SampleText('Warten auf Sensorchips vom Lieferanten', {'who': 'Can'}),
    ],
    'contentCalendar': [
      SampleText('Was uns 12 Pilotbetriebe über Wasser gelehrt haben', {
        'channel': 'Blog',
      }),
      SampleText('Blick ins Labor: So wird eine Sonde kalibriert', {
        'channel': 'LinkedIn',
      }),
      SampleText('Bewässerungstipps vor dem Sommerhoch', {
        'channel': 'Instagram',
      }),
    ],
    'crm': [
      SampleText('Anna Schmidt', {
        'company': 'Genossenschaft Grünes Tal',
        'next': 'Felddemo Di 10:00',
      }),
      SampleText('Marco Rossi', {
        'company': 'Obsthof Rossi',
        'next': 'Freitag nachfassen',
      }),
      SampleText('Hanna Berg', {
        'company': 'Weingut Berg',
        'next': 'Sonden installieren',
      }),
    ],
    'followUps': [
      SampleText('Anna: Bericht zur Felddemo schicken', {
        'note': 'Diagramm zur Wassereinsparung beilegen',
      }),
      SampleText('Maya: Notizen zum Partnermeeting', {
        'note': 'Warte auf Rückmeldung',
      }),
      SampleText('Hanna: Saison-Check-in', {'note': 'Alle Sonden online'}),
    ],
    'feedback': [
      SampleText('Längere Batterielaufzeit', {'from': 'Pilotbetriebe 2, 5, 9'}),
      SampleText('App auf Englisch', {'from': 'Obsthof Rossi'}),
      SampleText('Klarere Bewässerungshinweise', {'from': 'Pilotgruppe'}),
    ],
    'meetingNotes': [
      SampleText('Zwischenbericht für die Förderung schicken', {
        'owner': 'Elif',
        'meeting': 'Wöchentliches F&E-Meeting',
      }),
      SampleText('Sondendrift bei Kälte beheben', {
        'owner': 'Can',
        'meeting': 'Labor-Review',
      }),
      SampleText('Fertigungspartner auswählen', {
        'owner': 'Jonas',
        'meeting': 'Wöchentliches F&E-Meeting',
      }),
    ],
    'kpiBoard': [
      SampleText('Betriebe mit installierten Sonden', {
        'current': '12',
        'target': '20',
      }),
      SampleText('Durchschnittliche Wassereinsparung', {
        'current': '22 %',
        'target': '25 %',
      }),
      SampleText('Ausfallrate der Sonden', {'current': '6 %', 'target': '2 %'}),
    ],
  },
);
