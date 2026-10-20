import 'tool_text.dart';

/// Team & HR tools (`catalog/team.dart`) per language.
const teamText = <String, Map<String, ToolText>>{
  'tr': _tr,
  'fr': _fr,
  'es': _es,
  'de': _de,
};

const _tr = <String, ToolText>{
  'jobPost': ToolText(
    name: 'İş ilanı',
    description: 'Adayların gerçekten sonuna kadar okuduğu bir iş ilanı.',
    fields: {
      'company': FieldText('Şirket adı'),
      'oneLiner': FieldText(
        'Tek cümlelik tanım',
        example: 'serbest çalışanlar için kendi kendine işleyen muhasebe',
      ),
      'title': FieldText(
        'Pozisyon',
        example: 'Mobil Yazılım Mühendisi (kurucu ekip)',
      ),
      'location': FieldText(
        'Çalışma şekli',
        example: 'Uzaktan (Türkiye saati)',
      ),
      'salary': FieldText(
        'Maaş aralığı',
        example: r'Yıllık $60 bin–$80 bin + %0,5–1 hisse opsiyonu',
      ),
      'responsibilities': FieldText(
        'Sorumluluklar',
        example:
            'Flutter uygulamasının tasarımdan yayına kadar sorumluluğunu üstlenmek\nKurucularla birlikte her hafta yeni sürüm çıkarmak\nMühendislik kültürümüzü birlikte şekillendirmek',
      ),
      'requirements': FieldText(
        'Aranan nitelikler',
        example:
            'En az 3 yıl mobil uygulama geliştirme deneyimi\nApp Store’da yayınlanmış en az bir uygulama\nBelirsizliğin olduğu ortamlarda rahat çalışabilmek',
      ),
      'benefits': FieldText(
        'Yan haklar',
        example:
            'Özel sağlık sigortası\nEv ofisi donanım desteği\nYılda 4 hafta ücretli izin',
      ),
      'email': FieldText('İletişim e-postası'),
    },
    template: r'''{title} · {company}
{location} · {salary}

HAKKIMIZDA
{company} ne yapıyor? {oneLiner|cap}. Hızlı ürün çıkaran ve her hafta müşterileriyle konuşan küçük bir ekibiz.

NE YAPACAKSINIZ?
{responsibilities|bullets}

NE ARIYORUZ?
{requirements|bullets}

NE SUNUYORUZ?
{benefits|bullets}

NASIL BAŞVURULUR?
Kısa bir not ve geliştirdiğiniz bir işin bağlantısını {email} adresine gönderin. Ön yazıya gerek yok.

Her geçmişten ve kimlikten adayların başvurularını memnuniyetle bekliyoruz.''',
  ),
  'interviewLibrary': ToolText(
    name: 'Mülakat soru bankası',
    description: 'Pozisyona göre hazırlanmış yapılandırılmış mülakat soruları.',
    options: {
      'General': 'Genel',
      'Engineering': 'Yazılım',
      'Design': 'Tasarım',
      'Sales': 'Satış',
    },
    fields: {
      'role': FieldText('Alan'),
      'company': FieldText('Şirket adı'),
      'title': FieldText(
        'Pozisyon',
        example: 'Mobil Yazılım Mühendisi (kurucu ekip)',
      ),
    },
    templates: {
      'General': r'''MÜLAKAT: {title} · {company}

Motivasyon
1. Neden {company} ve neden şimdi?
2. Ne tür işler size enerji veriyor?

Geçmiş deneyimler
3. Gurur duyduğunuz bir projeyi anlatır mısınız? Sizin katkınız neydi?
4. Bir ekip arkadaşınızla fikir ayrılığına düştüğünüz bir durumu anlatın. Nasıl sonuçlandı?
5. İş hayatınızda yaptığınız bir hatayı ve sonrasında neyi değiştirdiğinizi anlatın.

Girişime uyum
6. Kimse size ne yapacağınızı söylemediğinde neyle uğraşacağınıza nasıl karar verirsiniz?
7. Bir işi ilk yılınızda bırakmanıza ne sebep olurdu?

Değerlendirme: Her cevabı mülakattan hemen sonra, başkalarıyla konuşmadan önce 1 ile 4 arasında puanlayın.''',
      'Engineering': r'''YAZILIM MÜLAKATI: {title} · {company}

1. Geliştirdiğiniz bir sistemin mimarisini anlatır mısınız? Bugün olsa neyi değiştirirdiniz?
2. Çözdüğünüz en zor hatayı anlatın. Nasıl buldunuz?
3. Hızlı çıkarmak ile sağlam kurmak arasında nasıl karar verirsiniz?
4. Kodunuzu nasıl test edersiniz? Neleri test etmezsiniz?
5. Performansı iyileştirdiğiniz bir durumu anlatın. İyileşmeyi nasıl ölçtünüz?
6. Pratik görev: İnternetsiz çalışıp bağlantı gelince eşitlenen bir gider takip uygulamasının veri modelini tasarlayın.
7. Başkasının yazdığı kodu nasıl incelersiniz?

Değerlendirme: Problem çözme, iletişim ve sorumluluk alma becerilerini 1 ile 4 arasında puanlayın.''',
      'Design': r'''TASARIM MÜLAKATI: {title} · {company}

1. Problemden yayına alınan tasarıma kadar bir proje sürecinizi anlatır mısınız?
2. Tasarımın işe yaradığını nasıl anladınız? Neyi ölçtünüz?
3. Kullanıcı araştırmasının fikrinizi değiştirdiği bir durumu anlatın.
4. Zaman darken yazılımcılarla nasıl çalışırsınız?
5. Her gün kullandığınız bir uygulamayı eleştirir misiniz?
6. Pratik görev: Bir muhasebe uygulamasının ilk kullanım deneyimi için taslak çizin.

Değerlendirme: Tasarım becerisi, ürün bakış açısı ve iş birliğini 1 ile 4 arasında puanlayın.''',
      'Sales': r'''SATIŞ MÜLAKATI: {title} · {company}

1. En başarılı satışınızı ilk temastan anlaşmaya kadar anlatır mısınız?
2. Kaybettiğiniz bir satışı anlatın. Neyi farklı yapardınız?
3. Sıfırdan bir satış hunisini nasıl oluşturursunuz?
4. Bir müşteri adayının size uygun olup olmadığını nasıl değerlendirirsiniz? Hangi soruları sorarsınız?
5. Rol çalışması: {company} ürününü şüpheci bir serbest çalışana iki dakikada anlatın.
6. Satış rakamlarınızı haftadan haftaya nasıl takip edersiniz?

Değerlendirme: Müşteri bulma, ihtiyaç analizi, satışı kapatma ve öğrenmeye açıklığı 1 ile 4 arasında puanlayın.''',
    },
  ),
  'meetingNotes': ToolText(
    name: 'Toplantı notları ve aksiyonlar',
    description: 'Alınan kararlar ve gerçekten tamamlanan aksiyonlar.',
    itemLabel: 'Aksiyon',
    stages: {'Open': 'Açık', 'Done': 'Tamamlandı'},
    fields: {
      'owner': FieldText('Sorumlu'),
      'due': FieldText('Teslim', example: 'Cuma'),
      'meeting': FieldText('Toplantı', example: 'Haftalık toplantı'),
    },
    samples: [
      SampleText('Yatırımcı bilgilendirmesini gönder', {
        'due': 'Cum',
        'meeting': 'Haftalık toplantı',
      }),
      SampleText('Karşılama adımlarındaki kullanıcı kaybını azalt', {
        'due': 'Çar',
        'meeting': 'Ürün değerlendirme toplantısı',
      }),
      SampleText('Bordro hizmeti sağlayıcısını seç', {
        'due': 'Pzt',
        'meeting': 'Haftalık toplantı',
      }),
    ],
  ),
  'onboardingChecklist': ToolText(
    name: 'İşe alışma kontrol listesi',
    description: 'Yeni ekip arkadaşınızın ilk haftaları için hazır adımlar.',
    itemLabel: 'Adım',
    stages: {'To do': 'Yapılacak', 'Done': 'Tamamlandı'},
    fields: {'when': FieldText('Ne zaman', example: '1. gün')},
    samples: [
      SampleText('İş teklifi mektubunu ve sözleşmeyi gönder', {
        'when': 'İlk günden önce',
      }),
      SampleText('E-posta ve araç hesaplarını aç', {'when': 'İlk günden önce'}),
      SampleText('Bilgisayarı ve ekipmanı gönder', {'when': 'İlk günden önce'}),
      SampleText('Hoş geldin görüşmesi ve ekiple tanışma', {'when': '1. gün'}),
      SampleText('Misyonu, değerleri ve yol haritasını paylaş', {
        'when': '1. gün',
      }),
      SampleText('Bir oryantasyon arkadaşı (buddy) belirle', {
        'when': '1. gün',
      }),
      SampleText('İlk küçük görevi tamamla', {'when': '1. hafta'}),
      SampleText('Beş müşteriyle tanış ya da görüşme kayıtlarını dinle', {
        'when': '2. hafta',
      }),
      SampleText('30. gün değerlendirme görüşmesi', {'when': '30. gün'}),
    ],
  ),
};

const _fr = <String, ToolText>{
  'jobPost': ToolText(
    name: 'Offre d’emploi',
    description: 'Une fiche de poste que les candidats lisent vraiment.',
    fields: {
      'company': FieldText('Nom de l’entreprise'),
      'oneLiner': FieldText(
        'Description en une phrase',
        example:
            'une comptabilité qui se fait toute seule, pour les freelances',
      ),
      'title': FieldText(
        'Intitulé du poste',
        example: 'Ingénieur mobile fondateur',
      ),
      'location': FieldText(
        'Lieu',
        example: 'Télétravail (fuseaux horaires européens)',
      ),
      'salary': FieldText(
        'Fourchette de salaire',
        example: r'70 k$–90 k$ + 0,5–1 % de BSPCE',
      ),
      'responsibilities': FieldText(
        'Responsabilités',
        example:
            'Porter l’app Flutter de la conception à la mise en ligne\nLivrer chaque semaine avec les fondateurs\nFaçonner notre culture tech',
      ),
      'requirements': FieldText(
        'Profil recherché',
        example:
            'Plus de 3 ans de développement d’apps mobiles\nAvoir publié une app sur l’App Store\nÀ l’aise avec l’incertitude',
      ),
      'benefits': FieldText(
        'Avantages',
        example:
            'Mutuelle\nBudget équipement télétravail\n5 semaines de congés payés',
      ),
      'email': FieldText('E-mail de contact'),
    },
    template: r'''{title} chez {company}
{location} · {salary}

QUI SOMMES-NOUS
{company} construit {oneLiner}. Nous sommes une petite équipe qui livre vite et parle à ses clients chaque semaine.

CE QUE VOUS FEREZ
{responsibilities|bullets}

CE QUE NOUS RECHERCHONS
{requirements|bullets}

CE QUE NOUS OFFRONS
{benefits|bullets}

COMMENT POSTULER
Envoyez un court message et un lien vers quelque chose que vous avez construit à {email}. Pas besoin de lettre de motivation.

Nous accueillons les candidatures de tous horizons et de toutes identités.''',
  ),
  'interviewLibrary': ToolText(
    name: 'Banque de questions d’entretien',
    description: 'Des questions structurées par poste.',
    options: {
      'General': 'Général',
      'Engineering': 'Tech',
      'Design': 'Design',
      'Sales': 'Vente',
    },
    fields: {
      'role': FieldText('Poste'),
      'company': FieldText('Nom de l’entreprise'),
      'title': FieldText(
        'Intitulé du poste',
        example: 'Ingénieur mobile fondateur',
      ),
    },
    templates: {
      'General': r'''ENTRETIEN : {title} chez {company}

Motivation
1. Pourquoi {company}, et pourquoi maintenant ?
2. Quel type de travail vous donne de l’énergie ?

Expériences passées
3. Parlez-moi d’un projet dont vous êtes fier. Quel a été votre rôle ?
4. Racontez un désaccord avec un collègue. Que s’est-il passé ?
5. Parlez-moi d’une erreur au travail et de ce que vous avez changé ensuite.

Adéquation startup
6. Comment décidez-vous sur quoi travailler quand personne ne vous le dit ?
7. Qu’est-ce qui vous ferait quitter un poste la première année ?

Notation : notez chaque réponse de 1 à 4 juste après l’entretien, avant d’en discuter avec les autres.''',
      'Engineering': r'''ENTRETIEN TECH : {title} chez {company}

1. Présentez-moi l’architecture d’un projet que vous avez construit. Que changeriez-vous ?
2. Parlez-moi du bug le plus difficile que vous ayez corrigé. Comment l’avez-vous trouvé ?
3. Comment arbitrez-vous entre livrer vite et bien construire ?
4. Comment testez-vous votre code ? Que ne testez-vous pas ?
5. Racontez une amélioration de performance. Comment l’avez-vous mesurée ?
6. Cas pratique : concevez le modèle de données d’un suivi de dépenses avec synchronisation hors ligne.
7. Comment relisez-vous le code de quelqu’un d’autre ?

Notation : notez résolution de problèmes, communication et sens des responsabilités de 1 à 4.''',
      'Design': r'''ENTRETIEN DESIGN : {title} chez {company}

1. Présentez une étude de cas, du problème au design livré.
2. Comment avez-vous su que le design fonctionnait ? Qu’avez-vous mesuré ?
3. Racontez une fois où la recherche vous a fait changer d’avis.
4. Comment travaillez-vous avec les développeurs quand le temps manque ?
5. Critiquez une app que vous utilisez tous les jours.
6. Cas pratique : esquissez la première utilisation d’une app de comptabilité.

Notation : notez savoir-faire, vision produit et collaboration de 1 à 4.''',
      'Sales': r'''ENTRETIEN VENTE : {title} chez {company}

1. Racontez votre plus belle vente, du premier contact à la signature.
2. Parlez-moi d’une affaire perdue. Que feriez-vous autrement ?
3. Comment construisez-vous un pipeline en partant de zéro ?
4. Comment qualifiez-vous un prospect ? Quelles questions posez-vous ?
5. Jeu de rôle : présentez {company} à un freelance sceptique en deux minutes.
6. Comment suivez-vous vos chiffres semaine après semaine ?

Notation : notez prospection, découverte, closing et capacité à progresser de 1 à 4.''',
    },
  ),
  'meetingNotes': ToolText(
    name: 'Comptes rendus et actions',
    description: 'Des décisions et des actions qui sont vraiment faites.',
    itemLabel: 'Action',
    stages: {'Open': 'Ouverte', 'Done': 'Faite'},
    fields: {
      'owner': FieldText('Responsable'),
      'due': FieldText('Échéance', example: 'Vendredi'),
      'meeting': FieldText('Réunion', example: 'Point hebdo'),
    },
    samples: [
      SampleText('Envoyer le point investisseurs', {
        'due': 'Ven.',
        'meeting': 'Point hebdo',
      }),
      SampleText('Corriger l’abandon pendant l’accueil', {
        'due': 'Mer.',
        'meeting': 'Revue produit',
      }),
      SampleText('Choisir le prestataire de paie', {
        'due': 'Lun.',
        'meeting': 'Point hebdo',
      }),
    ],
  ),
  'onboardingChecklist': ToolText(
    name: 'Checklist d’intégration',
    description:
        'Les étapes toutes prêtes pour les premières semaines d’une recrue.',
    itemLabel: 'Étape',
    stages: {'To do': 'À faire', 'Done': 'Fait'},
    fields: {'when': FieldText('Quand', example: 'Jour 1')},
    samples: [
      SampleText('Envoyer la promesse d’embauche et le contrat', {
        'when': 'Avant le jour 1',
      }),
      SampleText('Créer les comptes e-mail et outils', {
        'when': 'Avant le jour 1',
      }),
      SampleText('Envoyer l’ordinateur et le matériel', {
        'when': 'Avant le jour 1',
      }),
      SampleText('Appel de bienvenue et présentation à l’équipe', {
        'when': 'Jour 1',
      }),
      SampleText('Partager la mission, les valeurs et la feuille de route', {
        'when': 'Jour 1',
      }),
      SampleText('Désigner un parrain d’intégration', {'when': 'Jour 1'}),
      SampleText('Première petite tâche livrée', {'when': 'Semaine 1'}),
      SampleText('Rencontrer cinq clients ou écouter des appels', {
        'when': 'Semaine 2',
      }),
      SampleText('Point des 30 jours', {'when': 'Jour 30'}),
    ],
  ),
};

const _es = <String, ToolText>{
  'jobPost': ToolText(
    name: 'Oferta de empleo',
    description: 'Una descripción de puesto que los candidatos sí leen.',
    fields: {
      'company': FieldText('Nombre de la empresa'),
      'oneLiner': FieldText(
        'Descripción en una frase',
        example: 'contabilidad que se hace sola, para freelancers',
      ),
      'title': FieldText('Puesto', example: 'Ingeniero/a móvil fundador/a'),
      'location': FieldText(
        'Ubicación',
        example: 'Remoto (zonas horarias europeas)',
      ),
      'salary': FieldText(
        'Rango salarial',
        example: r'60 k$–80 k$ + 0,5–1 % de participación',
      ),
      'responsibilities': FieldText(
        'Responsabilidades',
        example:
            'Llevar la app de Flutter del diseño al lanzamiento\nPublicar cada semana con los fundadores\nDar forma a nuestra cultura de ingeniería',
      ),
      'requirements': FieldText(
        'Requisitos',
        example:
            'Más de 3 años creando apps móviles\nHaber publicado una app en la App Store\nComodidad con la incertidumbre',
      ),
      'benefits': FieldText(
        'Beneficios',
        example:
            'Seguro médico\nPresupuesto para teletrabajo\n4 semanas de vacaciones pagadas',
      ),
      'email': FieldText('Correo de contacto'),
    },
    template: r'''{title} en {company}
{location} · {salary}

SOBRE NOSOTROS
{company} crea {oneLiner}. Somos un equipo pequeño que publica rápido y habla con clientes cada semana.

QUÉ HARÁS
{responsibilities|bullets}

QUÉ BUSCAMOS
{requirements|bullets}

QUÉ OFRECEMOS
{benefits|bullets}

CÓMO PRESENTARTE
Envía una nota breve y un enlace a algo que hayas construido a {email}. No hace falta carta de presentación.

Damos la bienvenida a candidaturas de cualquier origen e identidad.''',
  ),
  'interviewLibrary': ToolText(
    name: 'Banco de preguntas de entrevista',
    description: 'Preguntas estructuradas por puesto.',
    options: {
      'General': 'General',
      'Engineering': 'Ingeniería',
      'Design': 'Diseño',
      'Sales': 'Ventas',
    },
    fields: {
      'role': FieldText('Puesto'),
      'company': FieldText('Nombre de la empresa'),
      'title': FieldText(
        'Título del puesto',
        example: 'Ingeniero/a móvil fundador/a',
      ),
    },
    templates: {
      'General': r'''ENTREVISTA: {title} en {company}

Motivación
1. ¿Por qué {company} y por qué ahora?
2. ¿Qué tipo de trabajo te da energía?

Experiencia
3. Háblame de un proyecto del que estés orgulloso. ¿Cuál fue tu papel?
4. Cuéntame una vez que no estuviste de acuerdo con un compañero. ¿Qué pasó?
5. Háblame de un error en el trabajo y de lo que cambiaste después.

Encaje con una startup
6. ¿Cómo decides en qué trabajar cuando nadie te lo dice?
7. ¿Qué te haría dejar un trabajo en el primer año?

Puntuación: puntúa cada respuesta de 1 a 4 justo después de la entrevista, antes de comentarla con otros.''',
      'Engineering': r'''ENTREVISTA DE INGENIERÍA: {title} en {company}

1. Explícame la arquitectura de algo que hayas construido. ¿Qué cambiarías?
2. Cuéntame el bug más difícil que hayas corregido. ¿Cómo lo encontraste?
3. ¿Cómo decides entre publicar rápido y construirlo bien?
4. ¿Cómo pruebas tu código? ¿Qué no pruebas?
5. Describe una vez que mejoraste el rendimiento. ¿Cómo lo mediste?
6. Práctica: diseña el modelo de datos de un control de gastos con sincronización sin conexión.
7. ¿Cómo revisas el código de otra persona?

Puntuación: puntúa resolución de problemas, comunicación y responsabilidad de 1 a 4.''',
      'Design': r'''ENTREVISTA DE DISEÑO: {title} en {company}

1. Explícame un caso de estudio, del problema al diseño publicado.
2. ¿Cómo supiste que el diseño funcionaba? ¿Qué mediste?
3. Cuéntame una vez que la investigación te hizo cambiar de opinión.
4. ¿Cómo trabajas con ingeniería cuando hay poco tiempo?
5. Critica una app que uses todos los días.
6. Práctica: boceta la primera experiencia de uso de una app de contabilidad.

Puntuación: puntúa oficio, visión de producto y colaboración de 1 a 4.''',
      'Sales': r'''ENTREVISTA DE VENTAS: {title} en {company}

1. Explícame tu mejor venta, del primer contacto al cierre.
2. Háblame de una venta que perdiste. ¿Qué harías distinto?
3. ¿Cómo construyes un pipeline desde cero?
4. ¿Cómo cualificas un lead? ¿Qué preguntas haces?
5. Role play: presenta {company} a un freelancer escéptico en dos minutos.
6. ¿Cómo sigues tus números semana a semana?

Puntuación: puntúa prospección, descubrimiento, cierre y capacidad de aprender de 1 a 4.''',
    },
  ),
  'meetingNotes': ToolText(
    name: 'Actas y acciones',
    description: 'Decisiones y tareas que sí se cumplen.',
    itemLabel: 'Acción',
    stages: {'Open': 'Abierta', 'Done': 'Hecha'},
    fields: {
      'owner': FieldText('Responsable'),
      'due': FieldText('Fecha límite', example: 'Viernes'),
      'meeting': FieldText('Reunión', example: 'Reunión semanal'),
    },
    samples: [
      SampleText('Enviar el informe a inversores', {
        'due': 'Vie',
        'meeting': 'Reunión semanal',
      }),
      SampleText('Corregir el abandono en la bienvenida', {
        'due': 'Mié',
        'meeting': 'Revisión de producto',
      }),
      SampleText('Elegir proveedor de nóminas', {
        'due': 'Lun',
        'meeting': 'Reunión semanal',
      }),
    ],
  ),
  'onboardingChecklist': ToolText(
    name: 'Checklist de incorporación',
    description:
        'Pasos listos para las primeras semanas de una nueva incorporación.',
    itemLabel: 'Paso',
    stages: {'To do': 'Por hacer', 'Done': 'Hecho'},
    fields: {'when': FieldText('Cuándo', example: 'Día 1')},
    samples: [
      SampleText('Enviar la carta de oferta y el contrato', {
        'when': 'Antes del día 1',
      }),
      SampleText('Crear las cuentas de correo y herramientas', {
        'when': 'Antes del día 1',
      }),
      SampleText('Enviar el portátil y el equipo', {'when': 'Antes del día 1'}),
      SampleText('Llamada de bienvenida y presentación al equipo', {
        'when': 'Día 1',
      }),
      SampleText('Compartir misión, valores y hoja de ruta', {'when': 'Día 1'}),
      SampleText('Asignar un compañero de acogida', {'when': 'Día 1'}),
      SampleText('Primera tarea pequeña publicada', {'when': 'Semana 1'}),
      SampleText('Conocer a cinco clientes o escuchar llamadas', {
        'when': 'Semana 2',
      }),
      SampleText('Revisión de los 30 días', {'when': 'Día 30'}),
    ],
  ),
};

const _de = <String, ToolText>{
  'jobPost': ToolText(
    name: 'Stellenanzeige',
    description: 'Eine Stellenbeschreibung, die Kandidaten wirklich lesen.',
    fields: {
      'company': FieldText('Firmenname'),
      'oneLiner': FieldText(
        'Beschreibung in einem Satz',
        example: 'Buchhaltung, die sich selbst erledigt, für Freelancer',
      ),
      'title': FieldText(
        'Stellentitel',
        example: 'Founding Mobile Engineer (m/w/d)',
      ),
      'location': FieldText('Ort', example: 'Remote (europäische Zeitzonen)'),
      'salary': FieldText(
        'Gehaltsspanne',
        example: r'70.000–90.000 $ + 0,5–1 % VSOP',
      ),
      'responsibilities': FieldText(
        'Aufgaben',
        example:
            'Die Flutter-App vom Design bis zum Release verantworten\nJede Woche mit den Gründern ausliefern\nUnsere Engineering-Kultur prägen',
      ),
      'requirements': FieldText(
        'Anforderungen',
        example:
            'Über 3 Jahre Erfahrung mit mobilen Apps\nMindestens eine App im App Store veröffentlicht\nSouverän im Umgang mit Unklarheit',
      ),
      'benefits': FieldText(
        'Benefits',
        example:
            'Zuschuss zur Krankenversicherung\nHomeoffice-Budget\n30 Tage Urlaub',
      ),
      'email': FieldText('Kontakt-E-Mail'),
    },
    template: r'''{title} bei {company}
{location} · {salary}

ÜBER UNS
{company} baut {oneLiner}. Wir sind ein kleines Team, das schnell ausliefert und jede Woche mit Kunden spricht.

DEINE AUFGABEN
{responsibilities|bullets}

WAS WIR SUCHEN
{requirements|bullets}

WAS WIR BIETEN
{benefits|bullets}

SO BEWIRBST DU DICH
Schick eine kurze Nachricht und einen Link zu etwas, das du gebaut hast, an {email}. Kein Anschreiben nötig.

Wir freuen uns über Bewerbungen unabhängig von Herkunft und Identität.''',
  ),
  'interviewLibrary': ToolText(
    name: 'Interviewfragen-Bibliothek',
    description: 'Strukturierte Fragen je Rolle.',
    options: {
      'General': 'Allgemein',
      'Engineering': 'Engineering',
      'Design': 'Design',
      'Sales': 'Vertrieb',
    },
    fields: {
      'role': FieldText('Rolle'),
      'company': FieldText('Firmenname'),
      'title': FieldText(
        'Stellentitel',
        example: 'Founding Mobile Engineer (m/w/d)',
      ),
    },
    templates: {
      'General': r'''INTERVIEW: {title} bei {company}

Motivation
1. Warum {company}, und warum jetzt?
2. Welche Art von Arbeit gibt dir Energie?

Bisheriges Verhalten
3. Erzähl von einem Projekt, auf das du stolz bist. Was war dein Anteil?
4. Beschreib eine Situation, in der du mit jemandem im Team nicht einig warst. Was ist passiert?
5. Erzähl von einem Fehler im Job und was du danach geändert hast.

Startup-Fit
6. Wie entscheidest du, woran du arbeitest, wenn es dir niemand sagt?
7. Was würde dich dazu bringen, einen Job im ersten Jahr zu verlassen?

Bewertung: jede Antwort direkt nach dem Interview mit 1–4 bewerten, bevor du dich mit anderen austauschst.''',
      'Engineering': r'''ENGINEERING-INTERVIEW: {title} bei {company}

1. Erklär mir die Architektur von etwas, das du gebaut hast. Was würdest du ändern?
2. Erzähl vom schwierigsten Bug, den du behoben hast. Wie hast du ihn gefunden?
3. Wie entscheidest du zwischen schnell ausliefern und sauber bauen?
4. Wie testest du deinen Code? Was testest du nicht?
5. Beschreib eine Performance-Verbesserung. Wie hast du sie gemessen?
6. Praxis: Entwirf das Datenmodell für einen Ausgaben-Tracker mit Offline-Sync.
7. Wie reviewst du den Code anderer?

Bewertung: Problemlösung, Kommunikation und Verantwortung mit 1–4 bewerten.''',
      'Design': r'''DESIGN-INTERVIEW: {title} bei {company}

1. Führ mich durch eine Fallstudie vom Problem bis zum ausgelieferten Design.
2. Woran hast du gemerkt, dass das Design funktioniert? Was hast du gemessen?
3. Erzähl von einem Moment, in dem Research deine Meinung geändert hat.
4. Wie arbeitest du mit Engineers, wenn die Zeit knapp ist?
5. Kritisiere eine App, die du jeden Tag nutzt.
6. Praxis: Skizziere den ersten Start einer Buchhaltungs-App.

Bewertung: Handwerk, Produktdenken und Zusammenarbeit mit 1–4 bewerten.''',
      'Sales': r'''VERTRIEBSINTERVIEW: {title} bei {company}

1. Erzähl von deinem besten Deal, vom ersten Kontakt bis zum Abschluss.
2. Erzähl von einem verlorenen Deal. Was würdest du anders machen?
3. Wie baust du eine Pipeline von null auf?
4. Wie qualifizierst du einen Lead? Welche Fragen stellst du?
5. Rollenspiel: Pitch {company} in zwei Minuten einem skeptischen Freelancer.
6. Wie verfolgst du deine Zahlen von Woche zu Woche?

Bewertung: Akquise, Bedarfsanalyse, Abschluss und Lernbereitschaft mit 1–4 bewerten.''',
    },
  ),
  'meetingNotes': ToolText(
    name: 'Meeting-Notizen & To-dos',
    description: 'Entscheidungen und Aufgaben, die wirklich erledigt werden.',
    itemLabel: 'Aufgabe',
    stages: {'Open': 'Offen', 'Done': 'Erledigt'},
    fields: {
      'owner': FieldText('Verantwortlich'),
      'due': FieldText('Fällig', example: 'Freitag'),
      'meeting': FieldText('Meeting', example: 'Wöchentliches Sync'),
    },
    samples: [
      SampleText('Investoren-Update senden', {
        'due': 'Fr',
        'meeting': 'Wöchentliches Sync',
      }),
      SampleText('Abbrüche im Onboarding beheben', {
        'due': 'Mi',
        'meeting': 'Produkt-Review',
      }),
      SampleText('Lohnabrechnungsanbieter auswählen', {
        'due': 'Mo',
        'meeting': 'Wöchentliches Sync',
      }),
    ],
  ),
  'onboardingChecklist': ToolText(
    name: 'Onboarding-Checkliste',
    description: 'Fertige Schritte für die ersten Wochen neuer Teammitglieder.',
    itemLabel: 'Schritt',
    stages: {'To do': 'Zu tun', 'Done': 'Erledigt'},
    fields: {'when': FieldText('Wann', example: 'Tag 1')},
    samples: [
      SampleText('Angebotsschreiben und Vertrag senden', {'when': 'Vor Tag 1'}),
      SampleText('E-Mail- und Tool-Konten anlegen', {'when': 'Vor Tag 1'}),
      SampleText('Laptop und Ausstattung verschicken', {'when': 'Vor Tag 1'}),
      SampleText('Willkommens-Call und Vorstellung im Team', {'when': 'Tag 1'}),
      SampleText('Mission, Werte und Roadmap teilen', {'when': 'Tag 1'}),
      SampleText('Eine Onboarding-Patin oder einen Paten zuweisen', {
        'when': 'Tag 1',
      }),
      SampleText('Erste kleine Aufgabe ausgeliefert', {'when': 'Woche 1'}),
      SampleText('Fünf Kunden treffen oder Calls anhören', {'when': 'Woche 2'}),
      SampleText('Check-in nach 30 Tagen', {'when': 'Tag 30'}),
    ],
  ),
};
