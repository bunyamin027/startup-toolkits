import 'tool_text.dart';

/// Product & project tools (`catalog/product.dart`) per language.
const productText = <String, Map<String, ToolText>>{
  'tr': _tr,
  'fr': _fr,
  'es': _es,
  'de': _de,
};

const _tr = <String, ToolText>{
  'kanban': ToolText(
    name: 'Kanban',
    description: 'Yapılacak, yapılıyor, tamamlandı.',
    itemLabel: 'Görev',
    stages: {'To do': 'Yapılacak', 'Doing': 'Yapılıyor', 'Done': 'Tamamlandı'},
    fields: {
      'owner': FieldText('Sorumlu'),
      'due': FieldText('Teslim', example: 'Cuma'),
    },
    samples: [
      SampleText('Karşılama ekranlarını tasarla', {'due': 'Çar'}),
      SampleText('Banka entegrasyonunda hata yönetimi', {'due': 'Cum'}),
      SampleText('Analitik altyapısını kur', {'due': 'Pzt'}),
    ],
  ),
  'okr': ToolText(
    name: 'OKR takibi',
    description: 'Bu çeyreğin amaçları ve anahtar sonuçları.',
    itemLabel: 'Anahtar sonuç',
    stages: {
      'Not started': 'Başlanmadı',
      'On track': 'Yolunda',
      'At risk': 'Risk altında',
      'Done': 'Tamamlandı',
    },
    fields: {
      'objective': FieldText('Amaç', example: 'Ürün-pazar uyumunu yakala'),
      'progress': FieldText('İlerleme'),
    },
    samples: [
      SampleText('Haftalık 2.000 aktif kullanıcıya ulaş', {
        'objective': 'Ürün-pazar uyumunu yakala',
      }),
      SampleText('Denemeden ücretliye geçişi %8’in üzerine çıkar', {
        'objective': 'Ürün-pazar uyumunu yakala',
      }),
      SampleText('Pre-seed yatırım turunu tamamla', {
        'objective': 'Önümüzdeki 18 ayın finansmanını sağla',
      }),
    ],
  ),
  'roadmap': ToolText(
    name: 'Yol haritası',
    description: 'Şimdi, sıradaki, ileride.',
    itemLabel: 'Özellik',
    stages: {'Now': 'Şimdi', 'Next': 'Sıradaki', 'Later': 'İleride'},
    fields: {
      'why': FieldText('Neden önemli', example: 'En çok istenen özellik'),
    },
    samples: [
      SampleText('Fişleri fotoğrafla kaydetme', {
        'why': 'Görüşmelerde en çok istenen özellik',
      }),
      SampleText('Android uygulaması', {
        'why': 'Bekleme listesindekilerin %40’ı Android kullanıyor',
      }),
      SampleText('Mali müşavirle paylaşım', {
        'why': 'Yeni bir yönlendirme kanalı açar',
      }),
    ],
  ),
  'userStory': ToolText(
    name: 'Kullanıcı hikâyesi ve PRD',
    description:
        'Kabul kriterleriyle bir kullanıcı hikâyesi ve kısa bir ürün gereksinim belgesi (PRD).',
    fields: {
      'feature': FieldText('Özellik adı', example: 'Fiş kaydı'),
      'user': FieldText('Kullanıcı (… olarak)', example: 'serbest çalışan'),
      'want': FieldText(
        'İstek (… istiyorum)',
        example: 'bir fişin fotoğrafını çekmek',
      ),
      'benefit': FieldText(
        'Fayda (böylece…)',
        example: 'gider elle yazılmadan kaydedilsin',
      ),
      'criteria': FieldText(
        'Kabul kriterleri',
        example:
            'Fotoğraf 5 saniye içinde okunur\nTutar, tarih ve satıcı otomatik doldurulur\nKullanıcı her alanı düzeltebilir\nİnternetsiz çalışır, bağlantı gelince eşitlenir',
      ),
      'outOfScope': FieldText(
        'Kapsam dışı',
        example: 'Çok sayfalı faturalar\nDöviz kuru dönüşümü',
      ),
      'metric': FieldText(
        'Başarı ölçütü',
        example: '30 gün içinde giderlerin %50’si fotoğrafla eklenir',
      ),
    },
    template: r'''PRD: {feature}

KULLANICI HİKÂYESİ
Bir {user} olarak {want} istiyorum; böylece {benefit}.

KABUL KRİTERLERİ
{criteria|bullets}

KAPSAM DIŞI
{outOfScope|bullets}

BAŞARI ÖLÇÜTÜ
{metric}

AÇIK SORULAR
• Hangi uç durumlar için tasarım gerekiyor?
• Başarı ölçütünü takip etmek için hangi verilere ihtiyacımız var?''',
  ),
  'standup': ToolText(
    name: 'Günlük stand-up notları',
    description: 'Dün, bugün, engeller.',
    itemLabel: 'Not',
    stages: {'Yesterday': 'Dün', 'Today': 'Bugün', 'Blocker': 'Engel'},
    fields: {'who': FieldText('Kim')},
    samples: [
      SampleText('Fiş kaydının beta sürümü yayınlandı'),
      SampleText('3 kullanıcı görüşmesi yapılacak'),
      SampleText('Banka API anahtarları bekleniyor'),
    ],
  ),
};

const _fr = <String, ToolText>{
  'kanban': ToolText(
    name: 'Kanban',
    description: 'À faire, en cours, terminé.',
    itemLabel: 'Tâche',
    stages: {'To do': 'À faire', 'Doing': 'En cours', 'Done': 'Terminé'},
    fields: {
      'owner': FieldText('Responsable'),
      'due': FieldText('Échéance', example: 'Vendredi'),
    },
    samples: [
      SampleText('Concevoir les écrans d’accueil', {'due': 'Mer.'}),
      SampleText('Gestion des erreurs de synchro bancaire', {'due': 'Ven.'}),
      SampleText('Mettre en place l’analytics', {'due': 'Lun.'}),
    ],
  ),
  'okr': ToolText(
    name: 'Suivi des OKR',
    description: 'Objectifs et résultats clés du trimestre.',
    itemLabel: 'Résultat clé',
    stages: {
      'Not started': 'Pas commencé',
      'On track': 'En bonne voie',
      'At risk': 'À risque',
      'Done': 'Terminé',
    },
    fields: {
      'objective': FieldText(
        'Objectif',
        example: 'Trouver le product-market fit',
      ),
      'progress': FieldText('Avancement'),
    },
    samples: [
      SampleText('Atteindre 2 000 utilisateurs actifs par semaine', {
        'objective': 'Trouver le product-market fit',
      }),
      SampleText('Conversion essai → payant au-dessus de 8 %', {
        'objective': 'Trouver le product-market fit',
      }),
      SampleText('Boucler la levée pre-seed', {
        'objective': 'Financer les 18 prochains mois',
      }),
    ],
  ),
  'roadmap': ToolText(
    name: 'Feuille de route',
    description: 'Maintenant, ensuite, plus tard.',
    itemLabel: 'Fonctionnalité',
    stages: {'Now': 'Maintenant', 'Next': 'Ensuite', 'Later': 'Plus tard'},
    fields: {
      'why': FieldText('Pourquoi c’est important', example: 'La plus demandée'),
    },
    samples: [
      SampleText('Capture des reçus en photo', {
        'why': 'Demande n° 1 en entretiens',
      }),
      SampleText('App Android', {'why': '40 % de la liste d’attente'}),
      SampleText('Partage avec l’expert-comptable', {
        'why': 'Ouvre un canal de recommandation',
      }),
    ],
  ),
  'userStory': ToolText(
    name: 'User story et PRD',
    description: 'Une user story avec critères d’acceptation et un PRD court.',
    fields: {
      'feature': FieldText(
        'Nom de la fonctionnalité',
        example: 'Capture de reçus',
      ),
      'user': FieldText('En tant que…', example: 'freelance'),
      'want': FieldText('Je veux…', example: 'prendre un reçu en photo'),
      'benefit': FieldText(
        'Afin que…',
        example: 'la dépense soit enregistrée sans saisie',
      ),
      'criteria': FieldText(
        'Critères d’acceptation',
        example:
            'La photo est lue en moins de 5 secondes\nMontant, date et fournisseur sont remplis\nL’utilisateur peut corriger chaque champ\nFonctionne hors ligne et se synchronise ensuite',
      ),
      'outOfScope': FieldText(
        'Hors périmètre',
        example: 'Factures de plusieurs pages\nConversion de devises',
      ),
      'metric': FieldText(
        'Indicateur de succès',
        example: '50 % des dépenses ajoutées par photo sous 30 jours',
      ),
    },
    template: r'''PRD : {feature}

USER STORY
En tant que {user}, je veux {want}, afin que {benefit}.

CRITÈRES D’ACCEPTATION
{criteria|bullets}

HORS PÉRIMÈTRE
{outOfScope|bullets}

INDICATEUR DE SUCCÈS
{metric}

QUESTIONS OUVERTES
• Quels cas limites nécessitent du design ?
• De quelles données avons-nous besoin pour suivre l’indicateur de succès ?''',
  ),
  'standup': ToolText(
    name: 'Notes de stand-up',
    description: 'Hier, aujourd’hui, blocages.',
    itemLabel: 'Note',
    stages: {'Yesterday': 'Hier', 'Today': 'Aujourd’hui', 'Blocker': 'Blocage'},
    fields: {'who': FieldText('Qui')},
    samples: [
      SampleText('Bêta de la capture de reçus livrée'),
      SampleText('3 entretiens utilisateurs'),
      SampleText('En attente des clés de l’API bancaire'),
    ],
  ),
};

const _es = <String, ToolText>{
  'kanban': ToolText(
    name: 'Kanban',
    description: 'Por hacer, en curso, hecho.',
    itemLabel: 'Tarea',
    stages: {'To do': 'Por hacer', 'Doing': 'En curso', 'Done': 'Hecho'},
    fields: {
      'owner': FieldText('Responsable'),
      'due': FieldText('Fecha límite', example: 'Viernes'),
    },
    samples: [
      SampleText('Diseñar las pantallas de bienvenida', {'due': 'Mié'}),
      SampleText('Gestión de errores de la sincronización bancaria', {
        'due': 'Vie',
      }),
      SampleText('Configurar la analítica', {'due': 'Lun'}),
    ],
  ),
  'okr': ToolText(
    name: 'Seguimiento de OKR',
    description: 'Objetivos y resultados clave del trimestre.',
    itemLabel: 'Resultado clave',
    stages: {
      'Not started': 'Sin empezar',
      'On track': 'En buen camino',
      'At risk': 'En riesgo',
      'Done': 'Hecho',
    },
    fields: {
      'objective': FieldText(
        'Objetivo',
        example: 'Encontrar el product-market fit',
      ),
      'progress': FieldText('Progreso'),
    },
    samples: [
      SampleText('Llegar a 2000 usuarios activos semanales', {
        'objective': 'Encontrar el product-market fit',
      }),
      SampleText('Conversión de prueba a pago por encima del 8 %', {
        'objective': 'Encontrar el product-market fit',
      }),
      SampleText('Cerrar la ronda pre-seed', {
        'objective': 'Financiar los próximos 18 meses',
      }),
    ],
  ),
  'roadmap': ToolText(
    name: 'Hoja de ruta',
    description: 'Ahora, después, más adelante.',
    itemLabel: 'Funcionalidad',
    stages: {'Now': 'Ahora', 'Next': 'Después', 'Later': 'Más adelante'},
    fields: {'why': FieldText('Por qué importa', example: 'La más pedida')},
    samples: [
      SampleText('Captura de recibos con foto', {
        'why': 'Lo más pedido en las entrevistas',
      }),
      SampleText('App para Android', {'why': 'El 40 % de la lista de espera'}),
      SampleText('Compartir con el gestor', {
        'why': 'Abre un canal de recomendación',
      }),
    ],
  ),
  'userStory': ToolText(
    name: 'Historia de usuario y PRD',
    description:
        'Una historia de usuario con criterios de aceptación y un PRD breve.',
    fields: {
      'feature': FieldText(
        'Nombre de la funcionalidad',
        example: 'Captura de recibos',
      ),
      'user': FieldText('Como…', example: 'freelancer'),
      'want': FieldText('Quiero…', example: 'hacer una foto a un recibo'),
      'benefit': FieldText(
        'Para que…',
        example: 'el gasto se registre sin escribir nada',
      ),
      'criteria': FieldText(
        'Criterios de aceptación',
        example:
            'La foto se lee en menos de 5 segundos\nSe rellenan el importe, la fecha y el proveedor\nEl usuario puede corregir cualquier campo\nFunciona sin conexión y se sincroniza después',
      ),
      'outOfScope': FieldText(
        'Fuera de alcance',
        example: 'Facturas de varias páginas\nConversión de divisas',
      ),
      'metric': FieldText(
        'Métrica de éxito',
        example: 'El 50 % de los gastos se añaden con foto en 30 días',
      ),
    },
    template: r'''PRD: {feature}

HISTORIA DE USUARIO
Como {user}, quiero {want}, para que {benefit}.

CRITERIOS DE ACEPTACIÓN
{criteria|bullets}

FUERA DE ALCANCE
{outOfScope|bullets}

MÉTRICA DE ÉXITO
{metric}

PREGUNTAS ABIERTAS
• ¿Qué casos límite necesitan diseño?
• ¿Qué datos necesitamos para medir la métrica de éxito?''',
  ),
  'standup': ToolText(
    name: 'Notas del daily',
    description: 'Ayer, hoy, bloqueos.',
    itemLabel: 'Nota',
    stages: {'Yesterday': 'Ayer', 'Today': 'Hoy', 'Blocker': 'Bloqueo'},
    fields: {'who': FieldText('Quién')},
    samples: [
      SampleText('Beta de captura de recibos publicada'),
      SampleText('3 entrevistas con usuarios'),
      SampleText('Esperando las claves de la API bancaria'),
    ],
  ),
};

const _de = <String, ToolText>{
  'kanban': ToolText(
    name: 'Kanban',
    description: 'Zu tun, in Arbeit, erledigt.',
    itemLabel: 'Aufgabe',
    stages: {'To do': 'Zu tun', 'Doing': 'In Arbeit', 'Done': 'Erledigt'},
    fields: {
      'owner': FieldText('Verantwortlich'),
      'due': FieldText('Fällig', example: 'Freitag'),
    },
    samples: [
      SampleText('Onboarding-Screens gestalten', {'due': 'Mi'}),
      SampleText('Fehlerbehandlung beim Bankabgleich', {'due': 'Fr'}),
      SampleText('Analytics einrichten', {'due': 'Mo'}),
    ],
  ),
  'okr': ToolText(
    name: 'OKR-Tracker',
    description: 'Ziele und Schlüsselergebnisse für das Quartal.',
    itemLabel: 'Schlüsselergebnis',
    stages: {
      'Not started': 'Nicht begonnen',
      'On track': 'Im Plan',
      'At risk': 'Gefährdet',
      'Done': 'Erledigt',
    },
    fields: {
      'objective': FieldText('Ziel', example: 'Product-Market-Fit finden'),
      'progress': FieldText('Fortschritt'),
    },
    samples: [
      SampleText('2.000 wöchentlich aktive Nutzer erreichen', {
        'objective': 'Product-Market-Fit finden',
      }),
      SampleText('Conversion Test → Abo über 8 %', {
        'objective': 'Product-Market-Fit finden',
      }),
      SampleText('Pre-Seed-Runde abschließen', {
        'objective': 'Die nächsten 18 Monate finanzieren',
      }),
    ],
  ),
  'roadmap': ToolText(
    name: 'Roadmap',
    description: 'Jetzt, als Nächstes, später.',
    itemLabel: 'Feature',
    stages: {'Now': 'Jetzt', 'Next': 'Als Nächstes', 'Later': 'Später'},
    fields: {
      'why': FieldText(
        'Warum es wichtig ist',
        example: 'Am häufigsten gewünscht',
      ),
    },
    samples: [
      SampleText('Belege per Foto erfassen', {
        'why': 'Wunsch Nr. 1 in den Interviews',
      }),
      SampleText('Android-App', {'why': '40 % der Warteliste'}),
      SampleText('Freigabe für Steuerberater', {
        'why': 'Öffnet einen Empfehlungskanal',
      }),
    ],
  ),
  'userStory': ToolText(
    name: 'User Story & PRD',
    description: 'Eine User Story mit Akzeptanzkriterien und ein kurzes PRD.',
    fields: {
      'feature': FieldText('Name des Features', example: 'Belegerfassung'),
      'user': FieldText('Als…', example: 'Freelancer'),
      'want': FieldText('möchte ich…', example: 'einen Beleg fotografieren'),
      'benefit': FieldText(
        'damit…',
        example: 'die Ausgabe ohne Tippen erfasst wird',
      ),
      'criteria': FieldText(
        'Akzeptanzkriterien',
        example:
            'Das Foto wird in 5 Sekunden ausgelesen\nBetrag, Datum und Händler werden ausgefüllt\nJedes Feld lässt sich korrigieren\nFunktioniert offline und synchronisiert später',
      ),
      'outOfScope': FieldText(
        'Nicht im Umfang',
        example: 'Mehrseitige Rechnungen\nWährungsumrechnung',
      ),
      'metric': FieldText(
        'Erfolgskennzahl',
        example:
            '50 % der Ausgaben werden innerhalb von 30 Tagen per Foto erfasst',
      ),
    },
    template: r'''PRD: {feature}

USER STORY
Als {user} möchte ich {want}, damit {benefit}.

AKZEPTANZKRITERIEN
{criteria|bullets}

NICHT IM UMFANG
{outOfScope|bullets}

ERFOLGSKENNZAHL
{metric}

OFFENE FRAGEN
• Welche Sonderfälle brauchen Design?
• Welche Daten brauchen wir, um die Erfolgskennzahl zu messen?''',
  ),
  'standup': ToolText(
    name: 'Stand-up-Notizen',
    description: 'Gestern, heute, Blocker.',
    itemLabel: 'Notiz',
    stages: {'Yesterday': 'Gestern', 'Today': 'Heute', 'Blocker': 'Blocker'},
    fields: {'who': FieldText('Wer')},
    samples: [
      SampleText('Beta der Belegerfassung ausgeliefert'),
      SampleText('3 Nutzerinterviews'),
      SampleText('Warten auf Bank-API-Schlüssel'),
    ],
  ),
};
