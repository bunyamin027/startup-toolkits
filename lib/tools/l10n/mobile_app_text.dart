import 'tool_text.dart';

/// Mobile app founder tools (`catalog/mobile_app.dart`) per language.
const mobileAppText = <String, Map<String, ToolText>>{
  'tr': _tr,
  'fr': _fr,
  'es': _es,
  'de': _de,
};

const _tr = <String, ToolText>{
  'storeListing': ToolText(
    name: 'Mağaza sayfası yazarı',
    description: 'Uygulama mağazaları için başlık, alt başlık ve açıklama.',
    fields: {
      'app': FieldText('Uygulama adı'),
      'subtitle': FieldText(
        'Alt başlık (30 karakter)',
        example: 'Serbest çalışana muhasebe',
      ),
      'audience': FieldText('Hedef kitle', example: 'serbest çalışanlar'),
      'features': FieldText(
        'Temel özellikler',
        example:
            'Banka senkronizasyonu her gideri sınıflandırır\nÜç aylık vergi tahmini\nFişleri bir saniyede çekin\nMali müşaviriniz için dışa aktarma',
      ),
      'price': FieldText(
        'Fiyat satırı',
        example: r'14 gün ücretsiz, ardından aylık $12 veya yıllık $99.',
      ),
      'proof': FieldText(
        'Sosyal kanıt',
        example: '1.200 serbest çalışan seviyor',
      ),
    },
    template: r'''UYGULAMA ADI
{app}: {subtitle}

ALT BAŞLIK
{subtitle}

TANITIM METNİ
{proof}. Akşamlarınızı geri alın.

AÇIKLAMA
{app}, {audience} için yapılmış, kendi kendini yapan bir muhasebe uygulamasıdır.

NELER SUNAR
{features|bullets}

NEDEN {app|upper}
• İki dakikada kurulum
• Gizlilik odaklı tasarım: verilerinizi asla satmayız

FİYAT
{price}
Abonelikler, dönem bitiminden en az 24 saat önce iptal edilmezse otomatik olarak yenilenir. Hesap ayarlarınızdan yönetebilir veya iptal edebilirsiniz.

Göndermeden önce sınırları kontrol edin: ad 30 karakter, alt başlık 30, tanıtım metni 170.''',
  ),
  'asoKeywords': ToolText(
    name: 'ASO anahtar kelime aracı',
    description: 'App Store araması için anahtar kelime alanı fikirleri.',
    fields: {
      'app': FieldText('Uygulama adı'),
      'primary': FieldText('Birincil anahtar kelime', example: 'muhasebe'),
      'secondary': FieldText('İkincil anahtar kelime', example: 'gider'),
      'audience': FieldText('Hedef kitle', example: 'serbest çalışan'),
      'competitor': FieldText(
        'Rakip',
        hint: 'Anahtar kelime alanında başka marka adları kullanmayın',
      ),
    },
    template:
        r'''ANAHTAR KELİME ALANI (100 karakter, virgülle ayrılmış, boşluksuz)
{primary|lower},{secondary|lower},takip,fiş,vergi,fatura,{audience|lower},bütçe,defter,gelir,tarayıcı

BAŞLIK + ALT BAŞLIK FİKİRLERİ
• {app}: {primary|cap} ve {secondary|cap} Takibi
• {app}: {audience|cap} için {primary|cap}
• {audience|cap} için {secondary|cap} Takibi

HEDEFLENECEK UZUN KUYRUK ARAMALAR
• {audience|lower} için {primary|lower} uygulaması
• {audience|lower} {secondary|lower} takibi
• şahıs şirketi {primary|lower}

KURALLAR
• Başlıkta veya alt başlıkta zaten olan kelimeleri tekrarlamayın.
• Tekil biçimler kullanın; mağaza çoğulları eşleştirir.
• "{competitor}" gibi rakip adlarını kullanmayın.
• Her seferinde tek bir değişkeni değiştirin ve karar vermeden önce 2–4 hafta bekleyin.''',
  ),
  'reviewReply': ToolText(
    name: 'Yorum yanıtı yazarı',
    description: 'Mağaza yorumlarına sakin ve yardımsever yanıtlar.',
    options: {
      'Positive': 'Olumlu',
      'Negative': 'Olumsuz',
      'Bug report': 'Hata bildirimi',
      'Feature request': 'Özellik isteği',
    },
    fields: {
      'kind': FieldText('Yorum türü'),
      'name': FieldText('Yorum yapanın adı'),
      'app': FieldText('Uygulama adı'),
      'topic': FieldText('Bahsettiği konu', example: 'banka senkronizasyonu'),
      'email': FieldText('Destek e-postası'),
    },
    templates: {
      'Positive':
          r'''Merhaba {name}, çok teşekkür ederiz! Şu özelliğin size zaman kazandırmasına çok sevindik: {topic}. {app} uygulamasını daha da iyi yapacak fikirleriniz varsa {email} adresinden duymayı çok isteriz.''',
      'Negative':
          r'''Merhaba {name}, bu konuda sizi hayal kırıklığına uğrattığımız için üzgünüz: {topic}. Size yaşatmak istediğimiz deneyim bu değil. Lütfen birkaç ayrıntıyla {email} adresine yazın, sorunu bizzat çözelim.''',
      'Bug report':
          r'''Merhaba {name}, bu konudaki sorunu bildirdiğiniz için teşekkürler: {topic}. Ekibimiz üzerinde çalışıyor ve düzeltme bir sonraki güncellemeyle geliyor. Cihaz modelinizi {email} adresine gönderebilirseniz düzeltmeyi doğrulamamıza yardımcı olur.''',
      'Feature request':
          r'''Merhaba {name}, harika fikir! {topic|cap} listemizde ve oyunuz onu üst sıralara taşıyor. Gelişmeleri takip etmek ya da daha fazla ayrıntı paylaşmak için: {email}.''',
    },
  ),
  'appPrivacy': ToolText(
    name: 'Uygulama gizlilik politikası',
    description:
        'Mağaza gizlilik etiketleriyle uyumlu bir uygulama gizlilik politikası.',
    options: {
      'No account': 'Hesap yok',
      'Account required': 'Hesap zorunlu',
      'Optional account': 'İsteğe bağlı hesap',
      'No analytics': 'Analitik yok',
      'Anonymous analytics': 'Anonim analitik',
      'Analytics linked to user': 'Kullanıcıya bağlı analitik',
      'No ads': 'Reklam yok',
      'Ads without tracking': 'İzlemesiz reklam',
      'Ads with tracking': 'İzlemeli reklam',
    },
    fields: {
      'app': FieldText('Uygulama adı'),
      'developer': FieldText('Geliştirici', example: 'Nimbly A.Ş.'),
      'email': FieldText('Destek e-postası'),
      'account': FieldText('Hesaplar'),
      'analytics': FieldText('Analitik'),
      'ads': FieldText('Reklam'),
      'date': FieldText('Yürürlük tarihi', example: '19 Ekim 2026'),
    },
    template: r'''GİZLİLİK POLİTİKASI: {app}
Yürürlük: {date}

{app} uygulamasını {developer} ("biz") geliştirdi. Bu politika, uygulamanın hangi verileri işlediğini açıklar.

HESAPLAR
{account}. Bir hesap oluşturursanız, onu ve verilerini istediğiniz zaman uygulamanın içinden silebilirsiniz.

CİHAZINIZDA SAKLANAN VERİLER
{app} uygulamasına girdiğiniz bilgiler, senkronize etmeyi ya da paylaşmayı seçmediğiniz sürece cihazınızda saklanır.

ANALİTİK
{analytics}. Analitiği yalnızca uygulamayı geliştirmek için kullanırız; sizi reklam amacıyla tanımlamak için asla kullanmayız.

REKLAM VE İZLEME
{ads}. Uygulama sizi başka şirketlerin uygulama veya web sitelerinde izleyecek olursa önce izninizi ister.

SATIN ALIMLAR
Ödemeler App Store veya Google Play tarafından yürütülür. Kart bilgilerinizi görmeyiz.

ÇOCUKLAR
{app}, 13 yaşından küçük çocuklara yönelik değildir.

HAKLARINIZ
Verilerinizin bir kopyasını veya silinmesini {email} adresinden isteyin.

Bu politikayı App Store Connect’teki Uygulama Gizliliği bilgileri ve Google Play’deki Veri güvenliği formuyla tutarlı tutun.''',
  ),
};

const _fr = <String, ToolText>{
  'storeListing': ToolText(
    name: 'Rédacteur de fiche store',
    description: 'Titre, sous-titre et description pour les stores.',
    fields: {
      'app': FieldText('Nom de l’app'),
      'subtitle': FieldText(
        'Sous-titre (30 caractères)',
        example: 'Compta pour freelances',
      ),
      'audience': FieldText('Public', example: 'les freelances'),
      'features': FieldText(
        'Fonctionnalités clés',
        example:
            'La synchro bancaire classe chaque dépense\nEstimation d’impôt trimestrielle\nPhotographiez vos reçus en une seconde\nExport pour votre expert-comptable',
      ),
      'price': FieldText(
        'Ligne de prix',
        example: r'Gratuit pendant 14 jours, puis 12 $/mois ou 99 $/an.',
      ),
      'proof': FieldText(
        'Preuve sociale',
        example: 'Adoré par 1 200 freelances',
      ),
    },
    template: r'''NOM DE L’APP
{app} : {subtitle}

SOUS-TITRE
{subtitle}

TEXTE PROMOTIONNEL
{proof}. Retrouvez vos soirées.

DESCRIPTION
{app} est une comptabilité qui se fait toute seule, conçue pour {audience}.

CE QUE VOUS OBTENEZ
{features|bullets}

POURQUOI {app|upper}
• Configuré en deux minutes
• Confidentiel par conception : nous ne vendons jamais vos données

PRIX
{price}
Les abonnements se renouvellent automatiquement sauf résiliation au moins 24 heures avant la fin de la période. Gérez ou résiliez dans les réglages de votre compte.

Vérifiez les limites avant l’envoi : nom 30 caractères, sous-titre 30, texte promotionnel 170.''',
  ),
  'asoKeywords': ToolText(
    name: 'Outil de mots-clés ASO',
    description: 'Des idées pour le champ mots-clés de l’App Store.',
    fields: {
      'app': FieldText('Nom de l’app'),
      'primary': FieldText('Mot-clé principal', example: 'comptabilité'),
      'secondary': FieldText('Mot-clé secondaire', example: 'dépense'),
      'audience': FieldText('Public', example: 'freelance'),
      'competitor': FieldText(
        'Concurrent',
        hint: 'N’utilisez pas d’autres marques dans le champ mots-clés',
      ),
    },
    template:
        r'''CHAMP MOTS-CLÉS (100 caractères, séparés par des virgules, sans espaces)
{primary|lower},{secondary|lower},suivi,reçu,impôt,facture,{audience|lower},budget,compta,revenu,scanner

IDÉES DE TITRE + SOUS-TITRE
• {app} : {primary|cap} et {secondary|cap}s
• {app} : {primary|cap} pour {audience|cap}s
• Suivi des {secondary|lower}s pour {audience|cap}s

RECHERCHES LONGUE TRAÎNE À CIBLER
• app {primary|lower} {audience|lower}
• suivi {secondary|lower}s {audience|lower}
• {primary|lower} auto-entrepreneur

RÈGLES
• Ne répétez pas les mots déjà présents dans le titre ou le sous-titre.
• Utilisez le singulier ; le store associe les pluriels.
• N’utilisez pas de noms de concurrents comme « {competitor} ».
• Changez une seule variable à la fois et attendez 2 à 4 semaines avant de juger.''',
  ),
  'reviewReply': ToolText(
    name: 'Réponses aux avis',
    description: 'Des réponses calmes et utiles aux avis des stores.',
    options: {
      'Positive': 'Positif',
      'Negative': 'Négatif',
      'Bug report': 'Signalement de bug',
      'Feature request': 'Demande de fonctionnalité',
    },
    fields: {
      'kind': FieldText('Type d’avis'),
      'name': FieldText('Nom de l’auteur de l’avis'),
      'app': FieldText('Nom de l’app'),
      'topic': FieldText(
        'Ce qui est mentionné',
        example: 'la synchro bancaire',
      ),
      'email': FieldText('E-mail du support'),
    },
    templates: {
      'Positive':
          r'''Bonjour {name}, merci beaucoup ! Ravis que {topic} vous fasse gagner du temps. Si vous avez des idées pour améliorer encore {app}, écrivez-nous à {email}.''',
      'Negative':
          r'''Bonjour {name}, nous sommes désolés que {topic} vous ait déçu. Ce n’est pas l’expérience que nous voulons vous offrir. Écrivez-nous à {email} avec quelques détails et nous réglerons cela personnellement.''',
      'Bug report':
          r'''Bonjour {name}, merci d’avoir signalé le problème avec {topic}. Notre équipe s’en occupe et un correctif arrive dans la prochaine mise à jour. Si vous pouvez envoyer le modèle de votre appareil à {email}, cela nous aidera à confirmer la correction.''',
      'Feature request':
          r'''Bonjour {name}, excellente idée ! {topic|cap} est sur notre liste et votre vote la fait remonter. Suivez l’avancement ou partagez plus de détails à {email}.''',
    },
  ),
  'appPrivacy': ToolText(
    name: 'Politique de confidentialité d’app',
    description:
        'Une politique de confidentialité alignée sur les étiquettes des stores.',
    options: {
      'No account': 'Pas de compte',
      'Account required': 'Compte obligatoire',
      'Optional account': 'Compte facultatif',
      'No analytics': 'Pas de statistiques',
      'Anonymous analytics': 'Statistiques anonymes',
      'Analytics linked to user': 'Statistiques liées à l’utilisateur',
      'No ads': 'Pas de publicité',
      'Ads without tracking': 'Publicité sans suivi',
      'Ads with tracking': 'Publicité avec suivi',
    },
    fields: {
      'app': FieldText('Nom de l’app'),
      'developer': FieldText('Développeur', example: 'Nimbly SAS'),
      'email': FieldText('E-mail du support'),
      'account': FieldText('Comptes'),
      'analytics': FieldText('Statistiques'),
      'ads': FieldText('Publicité'),
      'date': FieldText('Date d’entrée en vigueur', example: '19 octobre 2026'),
    },
    template: r'''POLITIQUE DE CONFIDENTIALITÉ : {app}
En vigueur le {date}

{developer} (« nous ») a conçu {app}. Cette politique explique quelles données l’app traite.

COMPTES
{account}. Si vous créez un compte, vous pouvez le supprimer avec ses données depuis l’app à tout moment.

DONNÉES STOCKÉES SUR VOTRE APPAREIL
Les informations saisies dans {app} restent sur votre appareil, sauf si vous choisissez de les synchroniser ou de les partager.

STATISTIQUES
{analytics}. Nous utilisons les statistiques uniquement pour améliorer l’app, jamais pour vous identifier à des fins publicitaires.

PUBLICITÉ ET SUIVI
{ads}. Si l’app devait vous suivre dans les apps ou sites d’autres entreprises, elle vous demanderait d’abord votre autorisation.

ACHATS
Les paiements sont gérés par l’App Store ou Google Play. Nous ne voyons pas vos coordonnées bancaires.

ENFANTS
{app} ne s’adresse pas aux enfants de moins de 13 ans.

VOS DROITS
Demandez une copie de vos données ou leur suppression à {email}.

Gardez cette politique cohérente avec la section Confidentialité de l’app dans App Store Connect et le formulaire Sécurité des données de Google Play.''',
  ),
};

const _es = <String, ToolText>{
  'storeListing': ToolText(
    name: 'Redactor de ficha de tienda',
    description: 'Título, subtítulo y descripción para las tiendas de apps.',
    fields: {
      'app': FieldText('Nombre de la app'),
      'subtitle': FieldText(
        'Subtítulo (30 caracteres)',
        example: 'Contabilidad para freelance',
      ),
      'audience': FieldText('Público', example: 'freelancers'),
      'features': FieldText(
        'Funciones clave',
        example:
            'La sincronización bancaria clasifica cada gasto\nEstimación trimestral de impuestos\nFotografía recibos en un segundo\nExportación para tu gestor',
      ),
      'price': FieldText(
        'Línea de precio',
        example: r'Gratis durante 14 días; después, 12 $/mes o 99 $/año.',
      ),
      'proof': FieldText(
        'Prueba social',
        example: 'Más de 1200 freelancers ya lo adoran',
      ),
    },
    template: r'''NOMBRE DE LA APP
{app}: {subtitle}

SUBTÍTULO
{subtitle}

TEXTO PROMOCIONAL
{proof}. Recupera tus tardes.

DESCRIPCIÓN
{app} es contabilidad que se hace sola, pensada para {audience}.

QUÉ OBTIENES
{features|bullets}

POR QUÉ {app|upper}
• Configuración en dos minutos
• Privacidad desde el diseño: nunca vendemos tus datos

PRECIO
{price}
Las suscripciones se renuevan automáticamente salvo que se cancelen al menos 24 horas antes del final del periodo. Gestiona o cancela en los ajustes de tu cuenta.

Revisa los límites antes de enviarla: nombre 30 caracteres, subtítulo 30, texto promocional 170.''',
  ),
  'asoKeywords': ToolText(
    name: 'Herramienta de palabras clave ASO',
    description: 'Ideas para el campo de palabras clave de la App Store.',
    fields: {
      'app': FieldText('Nombre de la app'),
      'primary': FieldText('Palabra clave principal', example: 'contabilidad'),
      'secondary': FieldText('Palabra clave secundaria', example: 'gasto'),
      'audience': FieldText('Público', example: 'autónomo'),
      'competitor': FieldText(
        'Competidor',
        hint: 'No uses otras marcas en el campo de palabras clave',
      ),
    },
    template:
        r'''CAMPO DE PALABRAS CLAVE (100 caracteres, separadas por comas, sin espacios)
{primary|lower},{secondary|lower},control,recibo,impuestos,factura,{audience|lower},presupuesto,cuentas,ingresos,escáner

IDEAS DE TÍTULO + SUBTÍTULO
• {app}: {primary|cap} y {secondary|cap}s
• {app}: {primary|cap} para {audience|cap}s
• Control de {secondary|lower}s para {audience|cap}s

BÚSQUEDAS DE COLA LARGA
• app de {primary|lower} para {audience|lower}s
• control de {secondary|lower}s {audience|lower}
• {primary|lower} para trabajadores por cuenta propia

REGLAS
• No repitas palabras que ya estén en el título o el subtítulo.
• Usa el singular; la tienda reconoce los plurales.
• No uses nombres de competidores como «{competitor}».
• Cambia una sola variable cada vez y espera 2–4 semanas antes de valorar.''',
  ),
  'reviewReply': ToolText(
    name: 'Respuestas a reseñas',
    description: 'Respuestas tranquilas y útiles a las reseñas de las tiendas.',
    options: {
      'Positive': 'Positiva',
      'Negative': 'Negativa',
      'Bug report': 'Informe de error',
      'Feature request': 'Petición de función',
    },
    fields: {
      'kind': FieldText('Tipo de reseña'),
      'name': FieldText('Nombre de quien reseña'),
      'app': FieldText('Nombre de la app'),
      'topic': FieldText(
        'Lo que mencionó',
        example: 'la sincronización bancaria',
      ),
      'email': FieldText('Correo de soporte'),
    },
    templates: {
      'Positive':
          r'''Hola, {name}: ¡muchísimas gracias! Nos alegra que {topic} te ahorre tiempo. Si tienes ideas para mejorar aún más {app}, nos encantará leerlas en {email}.''',
      'Negative':
          r'''Hola, {name}: sentimos que {topic} te haya decepcionado. No es la experiencia que queremos para ti. Escríbenos a {email} con algunos detalles y lo solucionaremos personalmente.''',
      'Bug report':
          r'''Hola, {name}: gracias por avisarnos del problema con {topic}. El equipo ya está en ello y la solución llegará en la próxima actualización. Si puedes enviarnos el modelo de tu dispositivo a {email}, nos ayudará a confirmar el arreglo.''',
      'Feature request':
          r'''Hola, {name}: ¡gran idea! {topic|cap} está en nuestra lista y tu voto la hace subir. Sigue las novedades o cuéntanos más en {email}.''',
    },
  ),
  'appPrivacy': ToolText(
    name: 'Política de privacidad de la app',
    description:
        'Una política de privacidad alineada con las etiquetas de privacidad de las tiendas.',
    options: {
      'No account': 'Sin cuenta',
      'Account required': 'Cuenta obligatoria',
      'Optional account': 'Cuenta opcional',
      'No analytics': 'Sin analítica',
      'Anonymous analytics': 'Analítica anónima',
      'Analytics linked to user': 'Analítica vinculada al usuario',
      'No ads': 'Sin anuncios',
      'Ads without tracking': 'Anuncios sin seguimiento',
      'Ads with tracking': 'Anuncios con seguimiento',
    },
    fields: {
      'app': FieldText('Nombre de la app'),
      'developer': FieldText('Desarrollador', example: 'Nimbly S.L.'),
      'email': FieldText('Correo de soporte'),
      'account': FieldText('Cuentas'),
      'analytics': FieldText('Analítica'),
      'ads': FieldText('Publicidad'),
      'date': FieldText(
        'Fecha de entrada en vigor',
        example: '19 de octubre de 2026',
      ),
    },
    template: r'''POLÍTICA DE PRIVACIDAD: {app}
En vigor desde el {date}

{developer} («nosotros») ha creado {app}. Esta política explica qué datos trata la app.

CUENTAS
{account}. Si creas una cuenta, puedes eliminarla junto con sus datos desde la propia app en cualquier momento.

DATOS GUARDADOS EN TU DISPOSITIVO
La información que introduces en {app} se guarda en tu dispositivo, salvo que decidas sincronizarla o compartirla.

ANALÍTICA
{analytics}. Usamos la analítica solo para mejorar la app y nunca para identificarte con fines publicitarios.

PUBLICIDAD Y SEGUIMIENTO
{ads}. Si la app llegara a seguirte en apps o webs de otras empresas, te pedirá permiso antes.

COMPRAS
Los pagos los gestiona la App Store o Google Play. No vemos los datos de tu tarjeta.

MENORES
{app} no está dirigida a menores de 13 años.

TUS DERECHOS
Pide una copia de tus datos o su eliminación en {email}.

Mantén esta política coherente con los detalles de privacidad de App Store Connect y el formulario de Seguridad de los datos de Google Play.''',
  ),
};

const _de = <String, ToolText>{
  'storeListing': ToolText(
    name: 'Store-Eintrag-Texter',
    description: 'Titel, Untertitel und Beschreibung für die App-Stores.',
    fields: {
      'app': FieldText('App-Name'),
      'subtitle': FieldText(
        'Untertitel (30 Zeichen)',
        example: 'Buchhaltung für Freelancer',
      ),
      'audience': FieldText('Zielgruppe', example: 'Freelancer'),
      'features': FieldText(
        'Wichtigste Funktionen',
        example:
            'Der Bankabgleich sortiert jede Ausgabe\nSteuerschätzung pro Quartal\nBelege in einer Sekunde fotografieren\nExport für deine Steuerberatung',
      ),
      'price': FieldText(
        'Preiszeile',
        example: r'14 Tage kostenlos, danach 12 $/Monat oder 99 $/Jahr.',
      ),
      'proof': FieldText(
        'Social Proof',
        example: 'Von 1.200 Freelancern geliebt',
      ),
    },
    template: r'''APP-NAME
{app}: {subtitle}

UNTERTITEL
{subtitle}

WERBETEXT
{proof}. Hol dir deine Abende zurück.

BESCHREIBUNG
{app} ist Buchhaltung, die sich selbst erledigt, gemacht für {audience}.

DAS BEKOMMST DU
{features|bullets}

WARUM {app|upper}
• In zwei Minuten eingerichtet
• Datenschutz von Anfang an: Wir verkaufen deine Daten nie

PREISE
{price}
Abos verlängern sich automatisch, sofern sie nicht mindestens 24 Stunden vor Ende des Zeitraums gekündigt werden. Verwalten oder kündigen in deinen Kontoeinstellungen.

Prüfe die Limits vor dem Einreichen: Name 30 Zeichen, Untertitel 30, Werbetext 170.''',
  ),
  'asoKeywords': ToolText(
    name: 'ASO-Keyword-Tool',
    description: 'Ideen für das Keyword-Feld der App-Store-Suche.',
    fields: {
      'app': FieldText('App-Name'),
      'primary': FieldText('Haupt-Keyword', example: 'Buchhaltung'),
      'secondary': FieldText('Neben-Keyword', example: 'Ausgaben'),
      'audience': FieldText('Zielgruppe', example: 'Freelancer'),
      'competitor': FieldText(
        'Wettbewerber',
        hint: 'Keine fremden Markennamen im Keyword-Feld verwenden',
      ),
    },
    template:
        r'''KEYWORD-FELD (100 Zeichen, durch Kommas getrennt, ohne Leerzeichen)
{primary|lower},{secondary|lower},tracker,beleg,steuer,rechnung,{audience|lower},budget,finanzen,einnahmen,scanner

IDEEN FÜR TITEL + UNTERTITEL
• {app}: {primary|cap} & {secondary|cap}
• {app}: {primary|cap} für {audience|cap}
• {secondary|cap}-Tracker für {audience|cap}

LONG-TAIL-SUCHEN
• {primary|lower} app {audience|lower}
• {secondary|lower} tracker {audience|lower}
• {primary|lower} selbstständige

REGELN
• Keine Wörter wiederholen, die schon im Titel oder Untertitel stehen.
• Singular verwenden; der Store erkennt Pluralformen.
• Keine Namen von Wettbewerbern wie „{competitor}“ verwenden.
• Immer nur eine Variable ändern und 2–4 Wochen warten, bevor du urteilst.''',
  ),
  'reviewReply': ToolText(
    name: 'Antworten auf Bewertungen',
    description: 'Ruhige, hilfreiche Antworten auf Store-Bewertungen.',
    options: {
      'Positive': 'Positiv',
      'Negative': 'Negativ',
      'Bug report': 'Fehlermeldung',
      'Feature request': 'Funktionswunsch',
    },
    fields: {
      'kind': FieldText('Art der Bewertung'),
      'name': FieldText('Name der bewertenden Person'),
      'app': FieldText('App-Name'),
      'topic': FieldText('Was erwähnt wurde', example: 'der Bankabgleich'),
      'email': FieldText('Support-E-Mail'),
    },
    templates: {
      'Positive':
          r'''Hallo {name}, vielen herzlichen Dank! Schön, dass dir das Zeit spart: {topic}. Wenn du Ideen hast, wie wir {app} noch besser machen können, freuen wir uns über eine Nachricht an {email}.''',
      'Negative':
          r'''Hallo {name}, es tut uns leid, dass dich das enttäuscht hat: {topic}. Das ist nicht die Erfahrung, die wir dir bieten wollen. Schreib uns bitte mit ein paar Details an {email}, dann kümmern wir uns persönlich darum.''',
      'Bug report':
          r'''Hallo {name}, danke, dass du das Problem gemeldet hast: {topic}. Unser Team arbeitet daran, und die Lösung kommt mit dem nächsten Update. Wenn du uns dein Gerätemodell an {email} schickst, hilft uns das, die Lösung zu bestätigen.''',
      'Feature request':
          r'''Hallo {name}, tolle Idee! {topic|cap} steht auf unserer Liste, und deine Stimme schiebt das Thema nach oben. Bleib auf dem Laufenden oder schick uns mehr Details an {email}.''',
    },
  ),
  'appPrivacy': ToolText(
    name: 'App-Datenschutzerklärung',
    description:
        'Eine Datenschutzerklärung für Apps, passend zu den Datenschutzangaben der Stores.',
    options: {
      'No account': 'Kein Konto',
      'Account required': 'Konto erforderlich',
      'Optional account': 'Optionales Konto',
      'No analytics': 'Keine Analysen',
      'Anonymous analytics': 'Anonyme Analysen',
      'Analytics linked to user': 'Nutzerbezogene Analysen',
      'No ads': 'Keine Werbung',
      'Ads without tracking': 'Werbung ohne Tracking',
      'Ads with tracking': 'Werbung mit Tracking',
    },
    fields: {
      'app': FieldText('App-Name'),
      'developer': FieldText('Entwickler', example: 'Nimbly GmbH'),
      'email': FieldText('Support-E-Mail'),
      'account': FieldText('Konten'),
      'analytics': FieldText('Analysen'),
      'ads': FieldText('Werbung'),
      'date': FieldText('Gültig ab', example: '19. Oktober 2026'),
    },
    template: r'''DATENSCHUTZERKLÄRUNG: {app}
Gültig ab {date}

{developer} („wir“) hat {app} entwickelt. Diese Erklärung beschreibt, welche Daten die App verarbeitet.

KONTEN
{account}. Wenn du ein Konto erstellst, kannst du es samt Daten jederzeit in der App löschen.

DATEN AUF DEINEM GERÄT
Was du in {app} eingibst, bleibt auf deinem Gerät, sofern du es nicht synchronisierst oder teilst.

ANALYSEN
{analytics}. Wir nutzen Analysen nur, um die App zu verbessern, und nie, um dich für Werbung zu identifizieren.

WERBUNG UND TRACKING
{ads}. Sollte die App dich jemals über Apps oder Websites anderer Unternehmen hinweg verfolgen, fragt sie dich vorher um Erlaubnis.

KÄUFE
Zahlungen wickeln der App Store oder Google Play ab. Wir sehen deine Kartendaten nicht.

KINDER
{app} richtet sich nicht an Kinder unter 13 Jahren.

DEINE RECHTE
Fordere eine Kopie deiner Daten oder ihre Löschung unter {email} an.

Halte diese Erklärung im Einklang mit den Angaben zum App-Datenschutz in App Store Connect und dem Formular zur Datensicherheit in Google Play.''',
  ),
};
