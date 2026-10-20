import 'tool_text.dart';

/// Growth & analytics tools (`catalog/growth.dart`) per language.
const growthText = <String, Map<String, ToolText>>{
  'tr': {
    'kpiBoard': ToolText(
      name: 'KPI panosu',
      description: 'Önemli olan birkaç rakam ve gidişatları.',
      itemLabel: 'KPI',
      stages: {
        'On track': 'Yolunda',
        'At risk': 'Risk altında',
        'Off track': 'Yoldan çıktı',
      },
      fields: {'current': FieldText('Mevcut'), 'target': FieldText('Hedef')},
      samples: [
        SampleText('Aylık tekrarlayan gelir', {
          'current': r'$3.500',
          'target': r'$5.000',
        }),
        SampleText('Denemeden ücretliye', {'current': '%6', 'target': '%8'}),
        SampleText('Aylık kayıp oranı', {'current': '%7', 'target': '%4'}),
      ],
    ),
    'abTest': ToolText(
      name: 'A/B testi anlamlılığı',
      description: 'B varyantı gerçekten daha mı iyi, yoksa şans mı?',
      fields: {
        'visitorsA': FieldText('Ziyaretçi A'),
        'conversionsA': FieldText('Dönüşüm A'),
        'visitorsB': FieldText('Ziyaretçi B'),
        'conversionsB': FieldText('Dönüşüm B'),
      },
    ),
    'funnel': ToolText(
      name: 'Dönüşüm hunisi',
      description: 'İnsanlar ziyaret ile ödeme arasında nerede kopuyor.',
      fields: {
        'visitors': FieldText('Ziyaretçiler'),
        'signups': FieldText('Kayıtlar'),
        'active': FieldText('Aktif kullanıcılar'),
        'paying': FieldText('Ödeyen müşteriler'),
      },
    ),
  },
  'fr': {
    'kpiBoard': ToolText(
      name: 'Tableau de KPI',
      description: 'Les quelques chiffres qui comptent, et leur évolution.',
      itemLabel: 'KPI',
      stages: {
        'On track': 'En bonne voie',
        'At risk': 'À risque',
        'Off track': 'Hors trajectoire',
      },
      fields: {'current': FieldText('Actuel'), 'target': FieldText('Objectif')},
      samples: [
        SampleText('Revenu mensuel récurrent', {
          'current': r'3 500 $',
          'target': r'5 000 $',
        }),
        SampleText('Essai → payant', {'current': '6 %', 'target': '8 %'}),
        SampleText('Churn mensuel', {'current': '7 %', 'target': '4 %'}),
      ],
    ),
    'abTest': ToolText(
      name: 'Significativité d’un test A/B',
      description:
          'La variante B est-elle vraiment meilleure, ou est-ce la chance ?',
      fields: {
        'visitorsA': FieldText('Visiteurs A'),
        'conversionsA': FieldText('Conversions A'),
        'visitorsB': FieldText('Visiteurs B'),
        'conversionsB': FieldText('Conversions B'),
      },
    ),
    'funnel': ToolText(
      name: 'Entonnoir de conversion',
      description: 'Où les gens décrochent entre la visite et le paiement.',
      fields: {
        'visitors': FieldText('Visiteurs'),
        'signups': FieldText('Inscriptions'),
        'active': FieldText('Utilisateurs actifs'),
        'paying': FieldText('Clients payants'),
      },
    ),
  },
  'es': {
    'kpiBoard': ToolText(
      name: 'Panel de KPI',
      description: 'Las pocas cifras que importan y cómo van.',
      itemLabel: 'KPI',
      stages: {
        'On track': 'En buen camino',
        'At risk': 'En riesgo',
        'Off track': 'Desviado',
      },
      fields: {'current': FieldText('Actual'), 'target': FieldText('Objetivo')},
      samples: [
        SampleText('Ingresos recurrentes mensuales', {
          'current': r'3500 $',
          'target': r'5000 $',
        }),
        SampleText('De prueba a pago', {'current': '6 %', 'target': '8 %'}),
        SampleText('Churn mensual', {'current': '7 %', 'target': '4 %'}),
      ],
    ),
    'abTest': ToolText(
      name: 'Significancia de un test A/B',
      description: '¿La variante B es realmente mejor o es solo suerte?',
      fields: {
        'visitorsA': FieldText('Visitantes A'),
        'conversionsA': FieldText('Conversiones A'),
        'visitorsB': FieldText('Visitantes B'),
        'conversionsB': FieldText('Conversiones B'),
      },
    ),
    'funnel': ToolText(
      name: 'Embudo de conversión',
      description: 'Dónde abandona la gente entre la visita y el pago.',
      fields: {
        'visitors': FieldText('Visitantes'),
        'signups': FieldText('Registros'),
        'active': FieldText('Usuarios activos'),
        'paying': FieldText('Clientes de pago'),
      },
    ),
  },
  'de': {
    'kpiBoard': ToolText(
      name: 'KPI-Board',
      description:
          'Die wenigen Zahlen, die zählen, und wie sie sich entwickeln.',
      itemLabel: 'KPI',
      stages: {
        'On track': 'Im Plan',
        'At risk': 'Gefährdet',
        'Off track': 'Verfehlt',
      },
      fields: {'current': FieldText('Aktuell'), 'target': FieldText('Ziel')},
      samples: [
        SampleText('Monatlich wiederkehrender Umsatz', {
          'current': r'3.500 $',
          'target': r'5.000 $',
        }),
        SampleText('Test → Abo', {'current': '6 %', 'target': '8 %'}),
        SampleText('Monatlicher Churn', {'current': '7 %', 'target': '4 %'}),
      ],
    ),
    'abTest': ToolText(
      name: 'A/B-Test-Signifikanz',
      description: 'Ist Variante B wirklich besser, oder nur Glück?',
      fields: {
        'visitorsA': FieldText('Besucher A'),
        'conversionsA': FieldText('Conversions A'),
        'visitorsB': FieldText('Besucher B'),
        'conversionsB': FieldText('Conversions B'),
      },
    ),
    'funnel': ToolText(
      name: 'Conversion-Funnel',
      description: 'Wo Menschen zwischen Besuch und Zahlung abspringen.',
      fields: {
        'visitors': FieldText('Besucher'),
        'signups': FieldText('Anmeldungen'),
        'active': FieldText('Aktive Nutzer'),
        'paying': FieldText('Zahlende Kunden'),
      },
    ),
  },
};
