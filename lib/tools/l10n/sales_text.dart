import 'tool_text.dart';

/// Sales & customers tools (`catalog/sales.dart`) per language.
const salesText = <String, Map<String, ToolText>>{
  'tr': _tr,
  'fr': _fr,
  'es': _es,
  'de': _de,
};

const _tr = <String, ToolText>{
  'crm': ToolText(
    name: 'Mini CRM',
    description: 'Müşteri adaylarını ilk temastan satışa kadar izleyin.',
    itemLabel: 'Müşteri adayı',
    stages: {
      'Lead': 'Yeni aday',
      'Contacted': 'İletişime geçildi',
      'Demo': 'Demo',
      'Won': 'Kazanıldı',
      'Lost': 'Kaybedildi',
    },
    fields: {
      'company': FieldText('Şirket'),
      'value': FieldText('Satış tutarı'),
      'next': FieldText('Sonraki adım', example: 'Demo planla'),
    },
    samples: [
      SampleText('Priya Patel', {'next': 'Salı 10:00’da demo'}),
      SampleText('Marco Rossi', {
        'company': 'Serbest çalışan',
        'next': 'Cuma günü tekrar ara',
      }),
      SampleText('Hanna Berg', {'next': 'Kurulum görüşmesi'}),
    ],
  ),
  'proposal': ToolText(
    name: 'Teklif şablonu',
    description: 'Kapsamı, fiyatı ve sonraki adımları net bir teklif.',
    fields: {
      'company': FieldText('Şirket adı'),
      'client': FieldText('Müşteri'),
      'need': FieldText(
        'Müşterinin ihtiyacı',
        example:
            'Studio North, ekibindeki 12 serbest çalışanın fiş kaybetmesinin önüne geçmek istiyor.',
      ),
      'scope': FieldText(
        'Kapsam',
        example:
            '12 kullanıcılık Nimbly ekip lisansı (1 yıl)\nKurulum eğitimi\nÖncelikli destek',
      ),
      'price': FieldText('Fiyat'),
      'timeline': FieldText(
        'Takvim',
        example:
            'Sözleşmenin imzalanmasından sonraki bir hafta içinde kullanıma hazır',
      ),
      'valid': FieldText('Geçerlilik tarihi', example: '30 Kasım 2026'),
      'sender': FieldText('Adınız'),
    },
    template: r'''TEKLİF
Hazırlayan: {company}
Müşteri: {client}

İHTİYACINIZ
{need}

SUNACAKLARIMIZ
{scope|bullets}

ÜCRET
{price|money}

TAKVİM
{timeline}

SONRAKİ ADIMLAR
1. Onayınızı bu e-postayı yanıtlayarak iletin.
2. Sözleşmeyi ve faturayı size gönderelim.
3. Başlangıç toplantısını yapalım.

Bu teklif {valid} tarihine kadar geçerlidir.

{sender}
{company}''',
  ),
  'followUps': ToolText(
    name: 'Takip hatırlatıcıları',
    description: 'Kimseye dönüş yapmayı unutmayın.',
    itemLabel: 'Takip',
    stages: {
      'Due': 'Zamanı geldi',
      'Waiting': 'Yanıt bekleniyor',
      'Done': 'Tamamlandı',
    },
    fields: {
      'date': FieldText('Ne zaman', example: 'Cuma'),
      'note': FieldText('Not', example: 'Fiyat listesini gönder'),
    },
    samples: [
      SampleText('Priya: demo kaydını gönder', {
        'date': 'Bugün',
        'note': 'Fiyatlandırma sayfasının bağlantısını da ekle',
      }),
      SampleText('Maya: ortaklar toplantısının notları', {
        'date': 'Per',
        'note': 'Geri dönüş bekleniyor',
      }),
      SampleText('Hanna: kurulum sonrası kontrol görüşmesi', {
        'date': 'Pzt',
        'note': 'Her şey yolunda',
      }),
    ],
  ),
  'feedback': ToolText(
    name: 'Müşteri geri bildirimleri',
    description: 'İstekleri toplayın, müşterilerinize dönüş yapın.',
    itemLabel: 'Geri bildirim',
    stages: {
      'New': 'Yeni',
      'Planned': 'Planlandı',
      'Done': 'Tamamlandı',
      'Won\'t do': 'Yapılmayacak',
    },
    fields: {
      'from': FieldText('Kimden', example: 'Müşteri'),
      'votes': FieldText('Kaç kez istendi'),
    },
    samples: [
      SampleText('CSV olarak dışa aktarma'),
      SampleText('Koyu tema'),
      SampleText('Daha hızlı fiş tarama', {'from': 'Beta grubu'}),
    ],
  ),
};

const _fr = <String, ToolText>{
  'crm': ToolText(
    name: 'Mini CRM',
    description: 'Vos prospects, du premier contact au gagné ou perdu.',
    itemLabel: 'Prospect',
    stages: {
      'Lead': 'Prospect',
      'Contacted': 'Contacté',
      'Demo': 'Démo',
      'Won': 'Gagné',
      'Lost': 'Perdu',
    },
    fields: {
      'company': FieldText('Entreprise'),
      'value': FieldText('Valeur de l’affaire'),
      'next': FieldText('Prochaine étape', example: 'Caler une démo'),
    },
    samples: [
      SampleText('Priya Patel', {'next': 'Démo mardi 10 h'}),
      SampleText('Marco Rossi', {
        'company': 'Freelance',
        'next': 'Relancer vendredi',
      }),
      SampleText('Hanna Berg', {'next': 'Appel de prise en main'}),
    ],
  ),
  'proposal': ToolText(
    name: 'Modèle de proposition commerciale',
    description: 'Une offre claire avec périmètre, prix et prochaines étapes.',
    fields: {
      'company': FieldText('Nom de l’entreprise'),
      'client': FieldText('Client'),
      'need': FieldText(
        'Besoin du client',
        example:
            'Studio North veut que ses 12 freelances arrêtent de perdre leurs reçus.',
      ),
      'scope': FieldText(
        'Périmètre',
        example:
            '12 licences équipe Nimbly pour un an\nAtelier de prise en main\nSupport prioritaire',
      ),
      'price': FieldText('Prix'),
      'timeline': FieldText(
        'Calendrier',
        example: 'Opérationnel dans la semaine suivant la signature',
      ),
      'valid': FieldText('Valable jusqu’au', example: '30 nov. 2026'),
      'sender': FieldText('Votre nom'),
    },
    template: r'''PROPOSITION
{company} pour {client}

LE BESOIN
{need}

CE QUE NOUS LIVRERONS
{scope|bullets}

INVESTISSEMENT
{price|money}

CALENDRIER
{timeline}

PROCHAINES ÉTAPES
1. Répondez pour confirmer.
2. Nous envoyons le contrat et la facture.
3. Réunion de lancement.

Cette offre est valable jusqu’au {valid}.

{sender}
{company}''',
  ),
  'followUps': ToolText(
    name: 'Rappels de relance',
    description: 'N’oubliez plus jamais de revenir vers quelqu’un.',
    itemLabel: 'Relance',
    stages: {'Due': 'À faire', 'Waiting': 'En attente', 'Done': 'Fait'},
    fields: {
      'date': FieldText('Quand', example: 'Vendredi'),
      'note': FieldText('Note', example: 'Envoyer les tarifs'),
    },
    samples: [
      SampleText('Priya : envoyer l’enregistrement de la démo', {
        'date': 'Aujourd’hui',
        'note': 'Joindre la page tarifs',
      }),
      SampleText('Maya : notes de la réunion des associés', {
        'date': 'Jeu.',
        'note': 'En attente de retour',
      }),
      SampleText('Hanna : point de prise en main', {
        'date': 'Lun.',
        'note': 'Tout va bien',
      }),
    ],
  ),
  'feedback': ToolText(
    name: 'Retours clients',
    description: 'Collectez les demandes et bouclez la boucle.',
    itemLabel: 'Retour',
    stages: {
      'New': 'Nouveau',
      'Planned': 'Prévu',
      'Done': 'Fait',
      'Won\'t do': 'Ne sera pas fait',
    },
    fields: {
      'from': FieldText('De', example: 'Client'),
      'votes': FieldText('Mentions'),
    },
    samples: [
      SampleText('Export CSV'),
      SampleText('Mode sombre'),
      SampleText('Scan des reçus plus rapide', {'from': 'Groupe bêta'}),
    ],
  ),
};

const _es = <String, ToolText>{
  'crm': ToolText(
    name: 'Mini CRM',
    description: 'Leads desde el primer contacto hasta ganados o perdidos.',
    itemLabel: 'Lead',
    stages: {
      'Lead': 'Lead',
      'Contacted': 'Contactado',
      'Demo': 'Demo',
      'Won': 'Ganado',
      'Lost': 'Perdido',
    },
    fields: {
      'company': FieldText('Empresa'),
      'value': FieldText('Valor del trato'),
      'next': FieldText('Siguiente paso', example: 'Agendar demo'),
    },
    samples: [
      SampleText('Priya Patel', {'next': 'Demo el martes a las 10:00'}),
      SampleText('Marco Rossi', {
        'company': 'Freelance',
        'next': 'Hacer seguimiento el viernes',
      }),
      SampleText('Hanna Berg', {'next': 'Llamada de bienvenida'}),
    ],
  ),
  'proposal': ToolText(
    name: 'Plantilla de propuesta',
    description: 'Una oferta clara con alcance, precio y próximos pasos.',
    fields: {
      'company': FieldText('Nombre de la empresa'),
      'client': FieldText('Cliente'),
      'need': FieldText(
        'Necesidad del cliente',
        example:
            'Studio North quiere que sus 12 freelancers dejen de perder recibos.',
      ),
      'scope': FieldText(
        'Alcance',
        example:
            '12 licencias de equipo de Nimbly durante un año\nTaller de puesta en marcha\nSoporte prioritario',
      ),
      'price': FieldText('Precio'),
      'timeline': FieldText(
        'Plazos',
        example: 'En marcha en la semana siguiente a la firma',
      ),
      'valid': FieldText('Válida hasta', example: '30 nov 2026'),
      'sender': FieldText('Tu nombre'),
    },
    template: r'''PROPUESTA
{company} para {client}

LA NECESIDAD
{need}

QUÉ ENTREGAREMOS
{scope|bullets}

INVERSIÓN
{price|money}

PLAZOS
{timeline}

PRÓXIMOS PASOS
1. Responde para confirmar.
2. Enviamos el contrato y la factura.
3. Reunión de arranque.

Esta oferta es válida hasta el {valid}.

{sender}
{company}''',
  ),
  'followUps': ToolText(
    name: 'Recordatorios de seguimiento',
    description: 'No vuelvas a olvidarte de responder a nadie.',
    itemLabel: 'Seguimiento',
    stages: {'Due': 'Pendiente', 'Waiting': 'En espera', 'Done': 'Hecho'},
    fields: {
      'date': FieldText('Cuándo', example: 'Viernes'),
      'note': FieldText('Nota', example: 'Enviar precios'),
    },
    samples: [
      SampleText('Priya: enviar la grabación de la demo', {
        'date': 'Hoy',
        'note': 'Incluir la página de precios',
      }),
      SampleText('Maya: notas de la reunión de socios', {
        'date': 'Jue',
        'note': 'Esperando comentarios',
      }),
      SampleText('Hanna: revisión de la puesta en marcha', {
        'date': 'Lun',
        'note': 'Todo bien',
      }),
    ],
  ),
  'feedback': ToolText(
    name: 'Opiniones de clientes',
    description: 'Recoge peticiones y cierra el círculo.',
    itemLabel: 'Opinión',
    stages: {
      'New': 'Nueva',
      'Planned': 'Planificada',
      'Done': 'Hecha',
      'Won\'t do': 'No se hará',
    },
    fields: {
      'from': FieldText('De', example: 'Cliente'),
      'votes': FieldText('Menciones'),
    },
    samples: [
      SampleText('Exportar a CSV'),
      SampleText('Modo oscuro'),
      SampleText('Escaneo de recibos más rápido', {'from': 'Grupo beta'}),
    ],
  ),
};

const _de = <String, ToolText>{
  'crm': ToolText(
    name: 'Mini-CRM',
    description: 'Leads vom ersten Kontakt bis gewonnen oder verloren.',
    itemLabel: 'Lead',
    stages: {
      'Lead': 'Lead',
      'Contacted': 'Kontaktiert',
      'Demo': 'Demo',
      'Won': 'Gewonnen',
      'Lost': 'Verloren',
    },
    fields: {
      'company': FieldText('Firma'),
      'value': FieldText('Auftragswert'),
      'next': FieldText('Nächster Schritt', example: 'Demo vereinbaren'),
    },
    samples: [
      SampleText('Priya Patel', {'next': 'Demo Di 10:00'}),
      SampleText('Marco Rossi', {
        'company': 'Freiberuflich',
        'next': 'Freitag nachfassen',
      }),
      SampleText('Hanna Berg', {'next': 'Onboarding-Call'}),
    ],
  ),
  'proposal': ToolText(
    name: 'Angebotsvorlage',
    description: 'Ein klares Angebot mit Umfang, Preis und nächsten Schritten.',
    fields: {
      'company': FieldText('Firmenname'),
      'client': FieldText('Kunde'),
      'need': FieldText(
        'Bedarf des Kunden',
        example:
            'Studio North möchte, dass seine 12 Freelancer keine Belege mehr verlieren.',
      ),
      'scope': FieldText(
        'Umfang',
        example:
            '12 Nimbly-Team-Lizenzen für ein Jahr\nOnboarding-Workshop\nPriorisierter Support',
      ),
      'price': FieldText('Preis'),
      'timeline': FieldText(
        'Zeitplan',
        example: 'Live innerhalb einer Woche nach Unterschrift',
      ),
      'valid': FieldText('Gültig bis', example: '30. Nov. 2026'),
      'sender': FieldText('Dein Name'),
    },
    template: r'''ANGEBOT
{company} für {client}

DER BEDARF
{need}

WAS WIR LIEFERN
{scope|bullets}

INVESTITION
{price|money}

ZEITPLAN
{timeline}

NÄCHSTE SCHRITTE
1. Zur Bestätigung antworten.
2. Wir senden Vertrag und Rechnung.
3. Kick-off-Termin.

Dieses Angebot ist gültig bis {valid}.

{sender}
{company}''',
  ),
  'followUps': ToolText(
    name: 'Nachfass-Erinnerungen',
    description: 'Nie mehr vergessen, dich bei jemandem zu melden.',
    itemLabel: 'Nachfassen',
    stages: {'Due': 'Fällig', 'Waiting': 'Wartet', 'Done': 'Erledigt'},
    fields: {
      'date': FieldText('Wann', example: 'Freitag'),
      'note': FieldText('Notiz', example: 'Preise senden'),
    },
    samples: [
      SampleText('Priya: Demo-Aufzeichnung senden', {
        'date': 'Heute',
        'note': 'Preisseite mitschicken',
      }),
      SampleText('Maya: Notizen zum Partner-Meeting', {
        'date': 'Do',
        'note': 'Warte auf Feedback',
      }),
      SampleText('Hanna: Onboarding-Check-in', {
        'date': 'Mo',
        'note': 'Alles gut',
      }),
    ],
  ),
  'feedback': ToolText(
    name: 'Kundenfeedback',
    description: 'Wünsche sammeln und den Kreis schließen.',
    itemLabel: 'Feedback',
    stages: {
      'New': 'Neu',
      'Planned': 'Geplant',
      'Done': 'Erledigt',
      'Won\'t do': 'Wird nicht gemacht',
    },
    fields: {
      'from': FieldText('Von', example: 'Kunde'),
      'votes': FieldText('Erwähnungen'),
    },
    samples: [
      SampleText('CSV-Export'),
      SampleText('Dunkelmodus'),
      SampleText('Schnellerer Belegscan', {'from': 'Beta-Gruppe'}),
    ],
  ),
};
