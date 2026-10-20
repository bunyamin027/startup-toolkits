import 'tool_text.dart';

/// Investor relations tools (`catalog/investors.dart`) per language.
const investorsText = <String, Map<String, ToolText>>{
  'tr': _tr,
  'fr': _fr,
  'es': _es,
  'de': _de,
};

const _tr = <String, ToolText>{
  'pitchDeck': ToolText(
    name: 'Sunum sihirbazı',
    description: 'Projenizden 10 slaytlık bir sunum taslağı.',
    fields: {
      'company': FieldText('Girişim adı'),
      'oneLiner': FieldText(
        'Tek cümlelik tanım',
        example: 'Serbest çalışanlar için kendi kendini yapan muhasebe.',
      ),
      'problem': FieldText(
        'Problem',
        example:
            'Serbest çalışanlar ayda 5+ saati muhasebeye harcıyor ve vergi indirimlerini kaçırıyor.',
      ),
      'solution': FieldText(
        'Çözüm',
        example:
            'Nimbly bankayı senkronize eder, giderleri sınıflandırır ve üç aylık vergiyi tahmin eder.',
      ),
      'market': FieldText(
        'Pazar büyüklüğü',
        example:
            r'59 milyon ABD’li serbest çalışan; 4 milyar $ hizmet verilebilir pazar',
      ),
      'model': FieldText(
        'İş modeli',
        example: r'Abonelik, aylık $12 veya yıllık $99',
      ),
      'traction': FieldText(
        'Çekiş',
        example: r'1.200 kullanıcı, 3,5 bin $ MRR, aylık %18 büyüme',
      ),
      'competition': FieldText(
        'Rekabet',
        example:
            'Kapsamlı muhasebe paketleri (fazla karmaşık), tablolar (elle)',
      ),
      'team': FieldText(
        'Ekip',
        example:
            'Ada (CEO, eski ürün lideri), Sam (CTO), Lee (mali müşavir, vergi yazılımında 8 yıl)',
      ),
      'ask': FieldText(
        'Talep',
        example: r'18 aylık pist için 750 bin $ pre-seed',
      ),
      'email': FieldText('İletişim e-postası'),
    },
    template: r'''SUNUM TASLAĞI: {company}

Slayt 1. Başlık
{company}: {oneLiner}

Slayt 2. Problem
{problem}

Slayt 3. Çözüm
{solution}

Slayt 4. Neden şimdi
Pazarda ne değişti de bu bugün mümkün hale geldi?

Slayt 5. Pazar büyüklüğü
{market}

Slayt 6. Ürün
Üç ekran görüntüsü ve her biri için tek cümle.

Slayt 7. İş modeli
{model}

Slayt 8. Çekiş
{traction}

Slayt 9. Rekabet
{competition}
{company} şirketinin en iyi köşede tek başına durduğu bir 2×2 gösterin.

Slayt 10. Ekip ve talep
{team}
Aranan yatırım: {ask}
İletişim: {email}

İpucu: her slaytta tek fikir, büyük yazı, sıfatlar yerine rakamlar.''',
  ),
  'onePager': ToolText(
    name: 'Tek sayfa özet',
    description: 'Yatırımcılar için girişiminiz tek sayfada.',
    fields: {
      'company': FieldText('Girişim adı'),
      'oneLiner': FieldText(
        'Tek cümlelik tanım',
        example: 'Serbest çalışanlar için kendi kendini yapan muhasebe.',
      ),
      'problem': FieldText(
        'Problem',
        example:
            'Serbest çalışanlar ayda 5+ saati muhasebeye harcıyor ve vergi indirimlerini kaçırıyor.',
      ),
      'solution': FieldText(
        'Çözüm',
        example:
            'Nimbly bankayı senkronize eder, giderleri sınıflandırır ve üç aylık vergiyi tahmin eder.',
      ),
      'customer': FieldText(
        'Hedef müşteri',
        example: 'Türkiye’deki serbest tasarımcılar ve yazılımcılar',
      ),
      'market': FieldText(
        'Pazar büyüklüğü',
        example: r'4 milyar $ hizmet verilebilir pazar',
      ),
      'traction': FieldText(
        'Çekiş',
        example: r'1.200 kullanıcı, 3,5 bin $ MRR, aylık +%18',
      ),
      'team': FieldText(
        'Ekip',
        example: 'Ada (CEO), Sam (CTO), Lee (mali müşavir)',
      ),
      'ask': FieldText('Talep', example: r'750 bin $ pre-seed'),
      'email': FieldText('İletişim e-postası'),
    },
    template: r'''{company|upper}
{oneLiner}

PROBLEM
{problem}

ÇÖZÜM
{solution}

MÜŞTERİ
{customer}

PAZAR
{market}

ÇEKİŞ
{traction}

EKİP
{team}

TALEP
{ask}

İletişim: {email}''',
  ),
  'investorTracker': ToolText(
    name: 'Yatırımcı takibi',
    description: 'Yatırım sürecinizi aşama aşama izleyin.',
    itemLabel: 'Yatırımcı',
    stages: {
      'To contact': 'Ulaşılacak',
      'Contacted': 'Ulaşıldı',
      'Meeting': 'Görüşme',
      'Committed': 'Taahhüt verdi',
      'Passed': 'Geçti',
    },
    fields: {
      'firm': FieldText('Kurum', example: 'Melek yatırımcı'),
      'amount': FieldText('Yatırım tutarı'),
      'next': FieldText('Sonraki adım', example: 'Sunumu gönder'),
    },
    samples: [
      SampleText('Maya Chen', {
        'firm': 'Northstar Ventures',
        'next': 'Perşembe ortak toplantısı',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Melek yatırımcı',
        'next': 'SAFE gönder',
      }),
      SampleText('Harbor Pre-seed Fonu', {
        'firm': 'Pre-seed fonu',
        'next': 'Jordan’dan tanıştırma iste',
      }),
    ],
  ),
  'valuation': ToolText(
    name: 'Değerleme tahmini',
    description: 'Kaba bir ARR çarpanı aralığı. Değerleme değildir.',
    fields: {
      'arr': FieldText('Yıllık tekrarlayan gelir'),
      'growth': FieldText('Yıllık büyüme'),
    },
  ),
};

const _fr = <String, ToolText>{
  'pitchDeck': ToolText(
    name: 'Assistant pitch deck',
    description: 'Le plan d’un deck de 10 slides à partir de votre projet.',
    fields: {
      'company': FieldText('Nom de la startup'),
      'oneLiner': FieldText(
        'Description en une phrase',
        example:
            'Une comptabilité qui se fait toute seule, pour les freelances.',
      ),
      'problem': FieldText(
        'Problème',
        example:
            'Les freelances perdent plus de 5 heures par mois en comptabilité et ratent des déductions.',
      ),
      'solution': FieldText(
        'Solution',
        example:
            'Nimbly synchronise la banque, classe les dépenses et estime l’impôt trimestriel.',
      ),
      'market': FieldText(
        'Taille du marché',
        example:
            r'59 M de freelances aux États-Unis ; marché adressable de 4 Md$',
      ),
      'model': FieldText(
        'Modèle économique',
        example: r'Abonnement, 12 $/mois ou 99 $/an',
      ),
      'traction': FieldText(
        'Traction',
        example: r'1 200 utilisateurs, 3,5 k$ de MRR, +18 % par mois',
      ),
      'competition': FieldText(
        'Concurrence',
        example:
            'Suites comptables complètes (trop complexes), tableurs (manuels)',
      ),
      'team': FieldText(
        'Équipe',
        example:
            'Ada (CEO, ex-lead produit), Sam (CTO), Lee (expert-comptable, 8 ans dans le logiciel fiscal)',
      ),
      'ask': FieldText(
        'Montant recherché',
        example: r'750 k$ en pre-seed pour 18 mois de runway',
      ),
      'email': FieldText('E-mail de contact'),
    },
    template: r'''PLAN DU PITCH DECK : {company}

Slide 1. Titre
{company} : {oneLiner}

Slide 2. Problème
{problem}

Slide 3. Solution
{solution}

Slide 4. Pourquoi maintenant
Qu’est-ce qui a changé sur le marché pour rendre cela possible aujourd’hui ?

Slide 5. Taille du marché
{market}

Slide 6. Produit
Trois captures d’écran, une phrase chacune.

Slide 7. Modèle économique
{model}

Slide 8. Traction
{traction}

Slide 9. Concurrence
{competition}
Montrez une matrice 2×2 où {company} est seul dans le meilleur coin.

Slide 10. Équipe et levée
{team}
Levée : {ask}
Contact : {email}

Conseil : une idée par slide, gros caractères, des chiffres plutôt que des adjectifs.''',
  ),
  'onePager': ToolText(
    name: 'One-pager',
    description: 'Votre startup sur une seule page pour les investisseurs.',
    fields: {
      'company': FieldText('Nom de la startup'),
      'oneLiner': FieldText(
        'Description en une phrase',
        example:
            'Une comptabilité qui se fait toute seule, pour les freelances.',
      ),
      'problem': FieldText(
        'Problème',
        example:
            'Les freelances perdent plus de 5 heures par mois en comptabilité et ratent des déductions.',
      ),
      'solution': FieldText(
        'Solution',
        example:
            'Nimbly synchronise la banque, classe les dépenses et estime l’impôt trimestriel.',
      ),
      'customer': FieldText(
        'Client cible',
        example: 'Designers et développeurs freelances en France',
      ),
      'market': FieldText(
        'Taille du marché',
        example: r'Marché adressable de 4 Md$',
      ),
      'traction': FieldText(
        'Traction',
        example: r'1 200 utilisateurs, 3,5 k$ de MRR, +18 % par mois',
      ),
      'team': FieldText(
        'Équipe',
        example: 'Ada (CEO), Sam (CTO), Lee (expert-comptable)',
      ),
      'ask': FieldText('Montant recherché', example: r'750 k$ en pre-seed'),
      'email': FieldText('E-mail de contact'),
    },
    template: r'''{company|upper}
{oneLiner}

PROBLÈME
{problem}

SOLUTION
{solution}

CLIENT
{customer}

MARCHÉ
{market}

TRACTION
{traction}

ÉQUIPE
{team}

LA LEVÉE
{ask}

Contact : {email}''',
  ),
  'investorTracker': ToolText(
    name: 'Suivi des investisseurs',
    description: 'Votre pipeline de levée, étape par étape.',
    itemLabel: 'Investisseur',
    stages: {
      'To contact': 'À contacter',
      'Contacted': 'Contacté',
      'Meeting': 'Rendez-vous',
      'Committed': 'Engagé',
      'Passed': 'Décliné',
    },
    fields: {
      'firm': FieldText('Structure', example: 'Business angel'),
      'amount': FieldText('Ticket'),
      'next': FieldText('Prochaine étape', example: 'Envoyer le deck'),
    },
    samples: [
      SampleText('Maya Chen', {
        'firm': 'Northstar Ventures',
        'next': 'Réunion des associés jeudi',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Business angel',
        'next': 'Envoyer le BSA AIR',
      }),
      SampleText('Fonds Harbor Pre-seed', {
        'firm': 'Fonds pre-seed',
        'next': 'Demander une intro à Jordan',
      }),
    ],
  ),
  'valuation': ToolText(
    name: 'Estimation de valorisation',
    description:
        'Une fourchette grossière par multiple d’ARR. Pas une valorisation.',
    fields: {
      'arr': FieldText('Revenu récurrent annuel'),
      'growth': FieldText('Croissance annuelle'),
    },
  ),
};

const _es = <String, ToolText>{
  'pitchDeck': ToolText(
    name: 'Asistente de pitch deck',
    description:
        'El guion de un deck de 10 diapositivas a partir de tu proyecto.',
    fields: {
      'company': FieldText('Nombre de la startup'),
      'oneLiner': FieldText(
        'Descripción en una frase',
        example: 'Contabilidad que se hace sola, para freelancers.',
      ),
      'problem': FieldText(
        'Problema',
        example:
            'Los freelancers pierden más de 5 horas al mes en contabilidad y se les escapan deducciones.',
      ),
      'solution': FieldText(
        'Solución',
        example:
            'Nimbly sincroniza el banco, clasifica los gastos y estima los impuestos trimestrales.',
      ),
      'market': FieldText(
        'Tamaño de mercado',
        example: r'59 M de freelancers en EE. UU.; mercado servible de 4000 M$',
      ),
      'model': FieldText(
        'Modelo de negocio',
        example: r'Suscripción, 12 $/mes o 99 $/año',
      ),
      'traction': FieldText(
        'Tracción',
        example: r'1200 usuarios, 3,5 k$ de MRR, crecimiento mensual del 18 %',
      ),
      'competition': FieldText(
        'Competencia',
        example:
            'Suites contables completas (demasiado complejas), hojas de cálculo (manuales)',
      ),
      'team': FieldText(
        'Equipo',
        example:
            'Ada (CEO, ex responsable de producto), Sam (CTO), Lee (asesora fiscal, 8 años en software de impuestos)',
      ),
      'ask': FieldText(
        'Lo que pides',
        example: r'750 k$ pre-seed para 18 meses de runway',
      ),
      'email': FieldText('Correo de contacto'),
    },
    template: r'''GUION DEL PITCH DECK: {company}

Diapositiva 1. Título
{company}: {oneLiner}

Diapositiva 2. Problema
{problem}

Diapositiva 3. Solución
{solution}

Diapositiva 4. Por qué ahora
¿Qué ha cambiado en el mercado para que esto sea posible hoy?

Diapositiva 5. Tamaño de mercado
{market}

Diapositiva 6. Producto
Tres capturas de pantalla con una frase cada una.

Diapositiva 7. Modelo de negocio
{model}

Diapositiva 8. Tracción
{traction}

Diapositiva 9. Competencia
{competition}
Muestra una matriz 2×2 donde {company} esté solo en la mejor esquina.

Diapositiva 10. Equipo y ronda
{team}
Buscamos: {ask}
Contacto: {email}

Consejo: una idea por diapositiva, letra grande, cifras mejor que adjetivos.''',
  ),
  'onePager': ToolText(
    name: 'One-pager',
    description: 'Tu startup en una sola página para inversores.',
    fields: {
      'company': FieldText('Nombre de la startup'),
      'oneLiner': FieldText(
        'Descripción en una frase',
        example: 'Contabilidad que se hace sola, para freelancers.',
      ),
      'problem': FieldText(
        'Problema',
        example:
            'Los freelancers pierden más de 5 horas al mes en contabilidad y se les escapan deducciones.',
      ),
      'solution': FieldText(
        'Solución',
        example:
            'Nimbly sincroniza el banco, clasifica los gastos y estima los impuestos trimestrales.',
      ),
      'customer': FieldText(
        'Cliente objetivo',
        example: 'Diseñadores y desarrolladores freelance en España',
      ),
      'market': FieldText(
        'Tamaño de mercado',
        example: r'Mercado servible de 4000 M$',
      ),
      'traction': FieldText(
        'Tracción',
        example: r'1200 usuarios, 3,5 k$ de MRR, +18 % mensual',
      ),
      'team': FieldText(
        'Equipo',
        example: 'Ada (CEO), Sam (CTO), Lee (asesora fiscal)',
      ),
      'ask': FieldText('Lo que pides', example: r'750 k$ pre-seed'),
      'email': FieldText('Correo de contacto'),
    },
    template: r'''{company|upper}
{oneLiner}

PROBLEMA
{problem}

SOLUCIÓN
{solution}

CLIENTE
{customer}

MERCADO
{market}

TRACCIÓN
{traction}

EQUIPO
{team}

LA RONDA
{ask}

Contacto: {email}''',
  ),
  'investorTracker': ToolText(
    name: 'Seguimiento de inversores',
    description: 'Tu ronda de financiación, etapa por etapa.',
    itemLabel: 'Inversor',
    stages: {
      'To contact': 'Por contactar',
      'Contacted': 'Contactado',
      'Meeting': 'Reunión',
      'Committed': 'Comprometido',
      'Passed': 'Descartado',
    },
    fields: {
      'firm': FieldText('Entidad', example: 'Business angel'),
      'amount': FieldText('Ticket'),
      'next': FieldText('Siguiente paso', example: 'Enviar el deck'),
    },
    samples: [
      SampleText('Maya Chen', {
        'firm': 'Northstar Ventures',
        'next': 'Reunión de socios el jueves',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Business angel',
        'next': 'Enviar la nota convertible',
      }),
      SampleText('Fondo Harbor Pre-seed', {
        'firm': 'Fondo pre-seed',
        'next': 'Pedir a Jordan una presentación',
      }),
    ],
  ),
  'valuation': ToolText(
    name: 'Estimación de valoración',
    description:
        'Un rango aproximado por múltiplo de ARR. No es una valoración.',
    fields: {
      'arr': FieldText('Ingresos recurrentes anuales'),
      'growth': FieldText('Crecimiento anual'),
    },
  ),
};

const _de = <String, ToolText>{
  'pitchDeck': ToolText(
    name: 'Pitch-Deck-Assistent',
    description: 'Die Gliederung eines 10-Folien-Decks aus deinem Projekt.',
    fields: {
      'company': FieldText('Name des Startups'),
      'oneLiner': FieldText(
        'Beschreibung in einem Satz',
        example: 'Buchhaltung, die sich selbst erledigt, für Freelancer.',
      ),
      'problem': FieldText(
        'Problem',
        example:
            'Freelancer verlieren über 5 Stunden im Monat mit Buchhaltung und verpassen Steuerabzüge.',
      ),
      'solution': FieldText(
        'Lösung',
        example:
            'Nimbly gleicht das Bankkonto ab, sortiert Ausgaben und schätzt die Steuer pro Quartal.',
      ),
      'market': FieldText(
        'Marktgröße',
        example:
            r'59 Mio. Freelancer in den USA; 4 Mrd. $ adressierbarer Markt',
      ),
      'model': FieldText(
        'Geschäftsmodell',
        example: r'Abo, 12 $/Monat oder 99 $/Jahr',
      ),
      'traction': FieldText(
        'Traktion',
        example: r'1.200 Nutzer, 3,5 Tsd. $ MRR, 18 % Wachstum pro Monat',
      ),
      'competition': FieldText(
        'Wettbewerb',
        example:
            'Komplette Buchhaltungssuiten (zu komplex), Tabellen (manuell)',
      ),
      'team': FieldText(
        'Team',
        example:
            'Ada (CEO, ehem. Product Lead), Sam (CTO), Lee (Steuerberaterin, 8 Jahre Steuersoftware)',
      ),
      'ask': FieldText(
        'Kapitalbedarf',
        example: r'750.000 $ Pre-Seed für 18 Monate Runway',
      ),
      'email': FieldText('Kontakt-E-Mail'),
    },
    template: r'''PITCH-DECK-GLIEDERUNG: {company}

Folie 1. Titel
{company}: {oneLiner}

Folie 2. Problem
{problem}

Folie 3. Lösung
{solution}

Folie 4. Warum jetzt
Was hat sich im Markt verändert, das dies heute möglich macht?

Folie 5. Marktgröße
{market}

Folie 6. Produkt
Drei Screenshots mit je einem Satz.

Folie 7. Geschäftsmodell
{model}

Folie 8. Traktion
{traction}

Folie 9. Wettbewerb
{competition}
Zeig eine 2×2-Matrix, in der {company} allein in der besten Ecke steht.

Folie 10. Team und Kapitalbedarf
{team}
Wir suchen: {ask}
Kontakt: {email}

Tipp: eine Idee pro Folie, große Schrift, Zahlen statt Adjektive.''',
  ),
  'onePager': ToolText(
    name: 'One-Pager',
    description: 'Dein Startup auf einer Seite für Investoren.',
    fields: {
      'company': FieldText('Name des Startups'),
      'oneLiner': FieldText(
        'Beschreibung in einem Satz',
        example: 'Buchhaltung, die sich selbst erledigt, für Freelancer.',
      ),
      'problem': FieldText(
        'Problem',
        example:
            'Freelancer verlieren über 5 Stunden im Monat mit Buchhaltung und verpassen Steuerabzüge.',
      ),
      'solution': FieldText(
        'Lösung',
        example:
            'Nimbly gleicht das Bankkonto ab, sortiert Ausgaben und schätzt die Steuer pro Quartal.',
      ),
      'customer': FieldText(
        'Zielkunde',
        example: 'Freiberufliche Designer und Entwickler in Deutschland',
      ),
      'market': FieldText(
        'Marktgröße',
        example: r'4 Mrd. $ adressierbarer Markt',
      ),
      'traction': FieldText(
        'Traktion',
        example: r'1.200 Nutzer, 3,5 Tsd. $ MRR, +18 % pro Monat',
      ),
      'team': FieldText(
        'Team',
        example: 'Ada (CEO), Sam (CTO), Lee (Steuerberaterin)',
      ),
      'ask': FieldText('Kapitalbedarf', example: r'750.000 $ Pre-Seed'),
      'email': FieldText('Kontakt-E-Mail'),
    },
    template: r'''{company|upper}
{oneLiner}

PROBLEM
{problem}

LÖSUNG
{solution}

KUNDE
{customer}

MARKT
{market}

TRAKTION
{traction}

TEAM
{team}

KAPITALBEDARF
{ask}

Kontakt: {email}''',
  ),
  'investorTracker': ToolText(
    name: 'Investoren-Tracker',
    description: 'Deine Fundraising-Pipeline, Phase für Phase.',
    itemLabel: 'Investor',
    stages: {
      'To contact': 'Anzusprechen',
      'Contacted': 'Kontaktiert',
      'Meeting': 'Termin',
      'Committed': 'Zugesagt',
      'Passed': 'Abgesagt',
    },
    fields: {
      'firm': FieldText('Firma', example: 'Business Angel'),
      'amount': FieldText('Ticketgröße'),
      'next': FieldText('Nächster Schritt', example: 'Deck senden'),
    },
    samples: [
      SampleText('Maya Chen', {
        'firm': 'Northstar Ventures',
        'next': 'Partner-Meeting am Donnerstag',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Business Angel',
        'next': 'Wandeldarlehen senden',
      }),
      SampleText('Harbor Pre-Seed-Fonds', {
        'firm': 'Pre-Seed-Fonds',
        'next': 'Jordan um ein Intro bitten',
      }),
    ],
  ),
  'valuation': ToolText(
    name: 'Bewertungsschätzung',
    description: 'Eine grobe Spanne über ARR-Multiples. Keine Bewertung.',
    fields: {
      'arr': FieldText('Jährlich wiederkehrender Umsatz'),
      'growth': FieldText('Wachstum pro Jahr'),
    },
  ),
};
