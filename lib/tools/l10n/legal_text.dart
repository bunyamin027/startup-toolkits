import 'tool_text.dart';

/// Legal & documents tools (`catalog/legal.dart`) per language. Wording is
/// a plain template in each language, not jurisdiction-checked legal text;
/// DocEngine appends the "not legal advice" notice in the same language.
const legalText = <String, Map<String, ToolText>>{
  'tr': _tr,
  'fr': _fr,
  'es': _es,
  'de': _de,
};

// ---------------------------------------------------------------- Turkish

const _trPrivacy = r'''

1. BİZ KİMİZ
{company} ("biz"), {service} hizmetini sunar. İletişim: {email}.

2. TOPLADIĞIMIZ VERİLER
{data|bullets}

3. VERİLERİ NEDEN KULLANIYORUZ
{service} hizmetini sunmak ve geliştirmek, size destek olmak ve yasal yükümlülüklerimizi yerine getirmek için.

4. PAYLAŞIM
Verileri yalnızca {service} hizmetini yürütmemize yardım eden hizmet sağlayıcılarla, sözleşme kapsamında ve yasanın gerektirdiği durumlarda paylaşırız. Kişisel verileri satmayız.

5. SAKLAMA
Verileri hesabınız etkin olduğu sürece saklar, hesabınızı kapattıktan sonra {retention} içinde sileriz; yasa daha uzun bir süre öngörüyorsa o süre uygulanır.

6. GÜVENLİK
Aktarım sırasında ve depolamada şifreleme kullanır, personel erişimini sınırlarız.''';

const _trTerms = r'''

KULLANIM KOŞULLARI (ÖZET)
• Bulunduğunuz yerde sözleşme yapabilecek yaşta olmalısınız.
• {service} hizmetini kötüye kullanmayın ve güvenliğini aşmaya çalışmayın.
• Ücretli planlar, hesabınızdan ya da mağaza ayarlarından iptal edilene kadar otomatik yenilenir.
• {service} "olduğu gibi" sunulur; sorumluluğumuz son 12 ayda ödediğiniz tutarla sınırlıdır.
• Bu koşulları güncelleyebiliriz ve önemli değişiklikleri size bildiririz.

Yürürlük tarihi: {date}
Sorular: {email}''';

const _tr = <String, ToolText>{
  'nda': ToolText(
    name: 'Gizlilik sözleşmesi (karşılıklı NDA)',
    description: 'Karşılıklı bir gizlilik sözleşmesi.',
    fields: {
      'company': FieldText('Şirket adı', example: 'Nimbly A.Ş.'),
      'otherParty': FieldText('Karşı taraf', example: 'Studio North Ltd. Şti.'),
      'purpose': FieldText(
        'Amaç',
        example: 'olası bir iş birliğini değerlendirmek',
      ),
      'term': FieldText('Gizlilik süresi', example: '2 yıl'),
      'law': FieldText(
        'Uygulanacak hukuk',
        example: 'Türkiye Cumhuriyeti kanunları',
      ),
      'date': FieldText('Yürürlük tarihi', example: '19 Ekim 2026'),
    },
    template: r'''KARŞILIKLI GİZLİLİK SÖZLEŞMESİ

Bu sözleşme {date} tarihinde {company} ile {otherParty} (her biri "Taraf") arasında yapılmıştır.

1. AMAÇ
Taraflar, {purpose} amacıyla gizli bilgi paylaşmak istemektedir.

2. GİZLİ BİLGİ
Bir Tarafın diğerine herhangi bir biçimde paylaştığı, gizli olarak işaretlenmiş ya da makul olarak gizli olduğu anlaşılacak, kamuya açık olmayan her türlü ticari, teknik veya mali bilgi.

3. YÜKÜMLÜLÜKLER
Her Taraf, diğerinin gizli bilgisini yalnızca Amaç için kullanır, en az makul özenle korur ve yalnızca bilmesi gereken ve benzer yükümlülüklerle bağlı kişilerle paylaşır.

4. İSTİSNALAR
Alıcı Tarafın kusuru olmaksızın kamuya açık hale gelen, alıcı Tarafça zaten bilinen, bağımsız olarak geliştirilen veya üçüncü bir kişiden hukuka uygun olarak edinilen bilgiler.

5. SÜRE
Bu yükümlülükler, açıklama tarihinden itibaren {term} boyunca devam eder.

6. İADE VEYA İMHA
Talep halinde her Taraf, diğerinin gizli bilgisini iade eder veya imha eder.

7. LİSANS VERİLMEMESİ
Bu sözleşmedeki hiçbir hüküm, diğer Tarafın fikri mülkiyeti üzerinde hak tanımaz.

8. UYGULANACAK HUKUK
Bu sözleşme {law} hükümlerine tabidir.

İmzalar:
{company} ____________________   Tarih: ________
{otherParty} ____________________   Tarih: ________''',
  ),
  'privacyTerms': ToolText(
    name: 'Gizlilik politikası ve koşullar',
    description:
        'GDPR, CCPA, KVKK ya da küresel kullanım için gizlilik politikası ve koşullar.',
    options: {
      'Global': 'Küresel',
      'GDPR': 'GDPR',
      'CCPA': 'CCPA',
      'KVKK': 'KVKK',
    },
    fields: {
      'law': FieldText('Bölge'),
      'company': FieldText('Şirket adı', example: 'Nimbly A.Ş.'),
      'service': FieldText(
        'Hizmet',
        example: 'Nimbly uygulaması ve web sitesi',
      ),
      'email': FieldText('İletişim e-postası'),
      'data': FieldText(
        'Toplanan veriler',
        example:
            'Ad ve e-posta\nBağladığınız banka hareketleri\nYüklediğiniz fişler\nUygulama kullanım analitiği',
      ),
      'retention': FieldText('Silme süresi', example: '30 gün'),
      'date': FieldText('Yürürlük tarihi', example: '19 Ekim 2026'),
    },
    templates: {
      'Global':
          'GİZLİLİK POLİTİKASI: {company}$_trPrivacy'
          r'''

7. SEÇİMLERİNİZ
{email} adresine yazarak verilerinize istediğiniz zaman erişebilir, onları düzeltebilir veya silebilirsiniz.'''
          '$_trTerms',
      'GDPR':
          'GİZLİLİK POLİTİKASI (AB/BK GDPR): {company}$_trPrivacy'
          r'''

7. HUKUKİ DAYANAK
Sözleşme ({service} hizmetini sunmak için), meşru menfaat (güvenlik, ürün geliştirme) ve açık rıza (isteğe bağlı analitik ve pazarlama).

8. HAKLARINIZ
Erişim, düzeltme, silme, kısıtlama, taşınabilirlik ve itiraz. Rızanızı istediğiniz zaman geri alabilir ve yerel veri koruma otoritesine şikâyette bulunabilirsiniz. İletişim: {email}.

9. ULUSLARARASI AKTARIMLAR
Veriler AEA/BK dışına çıktığında Standart Sözleşme Maddelerine veya bir yeterlilik kararına dayanırız.'''
          '$_trTerms',
      'CCPA':
          'GİZLİLİK POLİTİKASI (KALİFORNİYA CCPA/CPRA): {company}$_trPrivacy'
          r'''

7. KALİFORNİYA’DAKİ HAKLARINIZ
Kişisel bilgileri öğrenme, silme ve düzeltme hakkı; satış veya paylaşımdan vazgeçme hakkı; hassas kişisel bilgilerin kullanımını sınırlama hakkı; haklarınızı kullandığınız için ayrımcılığa uğramama.

8. SATIŞ VE PAYLAŞIM
Kişisel bilgileri bağlamlar arası davranışsal reklamcılık için satmayız veya paylaşmayız.

9. HAKLARINIZI NASIL KULLANIRSINIZ
{email} adresine yazın. Talebinizi doğrular ve 45 gün içinde yanıtlarız.'''
          '$_trTerms',
      'KVKK':
          'AYDINLATMA METNİ (KVKK): {company}$_trPrivacy'
          r'''

7. HUKUKİ SEBEPLER (KVKK MADDE 5)
Sözleşmenin ifası, hukuki yükümlülükler, meşru menfaat ve gerektiğinde açık rıza.

8. HAKLARINIZ (KVKK MADDE 11)
Verilerinizin işlenip işlenmediğini öğrenme, bilgi talep etme, düzeltilmesini veya silinmesini isteme, otomatik sonuçlara itiraz etme ve zararın giderilmesini talep etme. {email} adresine başvurun; 30 gün içinde yanıtlarız.

9. YURT DIŞINA AKTARIM
Veriler yalnızca KVKK Madde 9’daki güvencelerle yurt dışına aktarılır.'''
          '$_trTerms',
    },
  ),
  'contract': ToolText(
    name: 'Serbest çalışan ve ortaklık sözleşmesi',
    description: 'Yükleniciler veya kurucu ortaklar için sade sözleşmeler.',
    options: {'Freelancer': 'Serbest çalışan', 'Partnership': 'Ortaklık'},
    fields: {
      'type': FieldText('Sözleşme türü'),
      'company': FieldText('Şirket adı', example: 'Nimbly A.Ş.'),
      'otherParty': FieldText('Karşı taraf'),
      'scope': FieldText(
        'İş kapsamı veya roller',
        example: 'iOS uygulaması MVP’sini tasarlamak ve geliştirmek',
      ),
      'fee': FieldText('Ücret veya hisse', example: r'iki aşamada $8.000'),
      'term': FieldText('Süre', example: '3 ay'),
      'law': FieldText(
        'Uygulanacak hukuk',
        example: 'Türkiye Cumhuriyeti kanunları',
      ),
      'date': FieldText('Yürürlük tarihi', example: '19 Ekim 2026'),
    },
    templates: {
      'Freelancer': r'''BAĞIMSIZ YÜKLENİCİ SÖZLEŞMESİ

{company} ("Müşteri") ile {otherParty} ("Yüklenici") arasında, {date} tarihinden itibaren geçerlidir.

1. HİZMETLER
{scope}

2. ÜCRET
{fee}. Faturalar 14 gün içinde ödenir.

3. SÜRE
{term}; taraflardan biri 14 gün önceden yazılı bildirimle daha erken sona erdirmedikçe.

4. BAĞIMSIZ YÜKLENİCİ
Yüklenici çalışan değildir; kendi vergilerinden ve araçlarından kendisi sorumludur.

5. FİKRİ MÜLKİYET
Ödeme yapıldığında, bu sözleşme kapsamında üretilen tüm çalışmalar Müşteriye devredilir.

6. GİZLİLİK
Yüklenici, bu sözleşme süresince ve sonrasında Müşterinin kamuya açık olmayan bilgilerini gizli tutar.

7. UYGULANACAK HUKUK
{law}.

İmzalar:
{company} ____________________
{otherParty} ____________________''',
      'Partnership': r'''KURUCU ORTAK / ORTAKLIK SÖZLEŞMESİ (TASLAK)

{otherParty} dahil {company} kurucuları arasında, {date} tarihinden itibaren geçerlidir.

1. ROLLER VE SORUMLULUKLAR
{scope}

2. HİSSE
{fee}. Kurucu hisseleri 1 yıllık bekleme süresiyle 4 yılda hak edilir.

3. ZAMAN TAAHHÜDÜ
{date} tarihinden itibaren tam zamanlı; ilk süre {term}, ardından gözden geçirilir.

4. KARARLAR
Günlük kararları ilgili kurucu verir; büyük kararlar (yatırım alma, üst düzey yönetici işe alma, şirketi satma) tüm kurucuların onayını gerektirir.

5. FİKRİ MÜLKİYET
Şirketle ilgili tüm çalışmalar {company} şirketine devredilir.

6. AYRILMA
Hak edilmemiş hisseler şirkete döner; hak edilmiş hisseler gerçeğe uygun değerden geri alınabilir.

7. UYUŞMAZLIKLAR
Önce iyi niyetli görüşme, ardından arabuluculuk; {law} çerçevesinde.

İmzalar:
____________________   ____________________''',
    },
  ),
};

// ----------------------------------------------------------------- French

const _frPrivacy = r'''

1. QUI SOMMES-NOUS
{company} (« nous ») fournit {service}. Contact : {email}.

2. DONNÉES COLLECTÉES
{data|bullets}

3. POURQUOI NOUS LES UTILISONS
Pour fournir et améliorer {service}, vous accompagner et respecter nos obligations légales.

4. PARTAGE
Nous ne partageons les données qu’avec les prestataires qui nous aident à faire fonctionner {service}, sous contrat, et lorsque la loi l’exige. Nous ne vendons pas de données personnelles.

5. CONSERVATION
Nous conservons les données tant que votre compte est actif et les supprimons dans un délai de {retention} après sa fermeture, sauf si la loi impose une durée plus longue.

6. SÉCURITÉ
Nous chiffrons les données en transit et au repos, et limitons l’accès du personnel.''';

const _frTerms = r'''

CONDITIONS D’UTILISATION (RÉSUMÉ)
• Vous devez avoir l’âge légal pour conclure un contrat là où vous vivez.
• N’utilisez pas {service} de manière abusive et ne tentez pas d’en contourner la sécurité.
• Les offres payantes se renouvellent automatiquement jusqu’à leur résiliation dans votre compte ou les réglages du store.
• {service} est fourni « en l’état » ; notre responsabilité est limitée au montant payé au cours des 12 derniers mois.
• Nous pouvons modifier ces conditions et vous informerons de tout changement important.

Date d’entrée en vigueur : {date}
Questions : {email}''';

const _fr = <String, ToolText>{
  'nda': ToolText(
    name: 'Accord de confidentialité (NDA mutuel)',
    description: 'Un accord de confidentialité réciproque.',
    fields: {
      'company': FieldText('Nom de l’entreprise', example: 'Nimbly SAS'),
      'otherParty': FieldText('Autre partie', example: 'Studio North SARL'),
      'purpose': FieldText(
        'Objet',
        example: 'l’étude d’un partenariat potentiel',
      ),
      'term': FieldText('Durée de confidentialité', example: '2 ans'),
      'law': FieldText('Droit applicable', example: 'droit français'),
      'date': FieldText('Date d’effet', example: '19 octobre 2026'),
    },
    template: r'''ACCORD DE CONFIDENTIALITÉ MUTUEL

Le présent accord est conclu le {date} entre {company} et {otherParty} (chacune une « Partie »).

1. OBJET
Les Parties souhaitent échanger des informations confidentielles en vue de {purpose}.

2. INFORMATIONS CONFIDENTIELLES
Toute information commerciale, technique ou financière non publique communiquée par une Partie à l’autre, sous quelque forme que ce soit, marquée comme confidentielle ou raisonnablement considérée comme telle.

3. OBLIGATIONS
Chaque Partie n’utilise les informations confidentielles de l’autre que pour l’Objet, les protège avec au moins un soin raisonnable et ne les partage qu’avec les personnes qui ont besoin de les connaître et sont tenues par des obligations similaires.

4. EXCLUSIONS
Les informations devenues publiques sans faute de la Partie destinataire, déjà connues d’elle, développées de manière indépendante ou reçues légalement d’un tiers.

5. DURÉE
Ces obligations s’appliquent pendant {term} à compter de la date de divulgation.

6. RESTITUTION OU DESTRUCTION
Sur demande, chaque Partie restitue ou détruit les informations confidentielles de l’autre.

7. AUCUNE LICENCE
Rien dans le présent accord ne confère de droits sur la propriété intellectuelle de l’autre Partie.

8. DROIT APPLICABLE
Le présent accord est régi par le {law}.

Signatures :
{company} ____________________   Date : ________
{otherParty} ____________________   Date : ________''',
  ),
  'privacyTerms': ToolText(
    name: 'Politique de confidentialité et CGU',
    description:
        'Politique de confidentialité et conditions pour le RGPD, le CCPA, la KVKK ou un usage mondial.',
    options: {
      'Global': 'Monde',
      'GDPR': 'RGPD',
      'CCPA': 'CCPA',
      'KVKK': 'KVKK',
    },
    fields: {
      'law': FieldText('Région'),
      'company': FieldText('Nom de l’entreprise', example: 'Nimbly SAS'),
      'service': FieldText(
        'Service',
        example: 'l’application et le site Nimbly',
      ),
      'email': FieldText('E-mail de contact'),
      'data': FieldText(
        'Données collectées',
        example:
            'Nom et e-mail\nTransactions bancaires que vous connectez\nReçus que vous importez\nStatistiques d’utilisation de l’app',
      ),
      'retention': FieldText('Délai de suppression', example: '30 jours'),
      'date': FieldText('Date d’entrée en vigueur', example: '19 octobre 2026'),
    },
    templates: {
      'Global':
          'POLITIQUE DE CONFIDENTIALITÉ : {company}$_frPrivacy'
          r'''

7. VOS CHOIX
Vous pouvez accéder à vos données, les corriger ou les supprimer à tout moment en écrivant à {email}.'''
          '$_frTerms',
      'GDPR':
          'POLITIQUE DE CONFIDENTIALITÉ (RGPD UE/R.-U.) : {company}$_frPrivacy'
          r'''

7. BASE LÉGALE
Le contrat (pour fournir {service}), l’intérêt légitime (sécurité, amélioration du produit) et le consentement (statistiques et marketing facultatifs).

8. VOS DROITS
Accès, rectification, effacement, limitation, portabilité et opposition. Vous pouvez retirer votre consentement à tout moment et introduire une réclamation auprès de votre autorité de protection des données (en France, la CNIL). Contact : {email}.

9. TRANSFERTS INTERNATIONAUX
Lorsque des données quittent l’EEE ou le Royaume-Uni, nous nous appuyons sur les clauses contractuelles types ou sur une décision d’adéquation.'''
          '$_frTerms',
      'CCPA':
          'POLITIQUE DE CONFIDENTIALITÉ (CALIFORNIE CCPA/CPRA) : {company}$_frPrivacy'
          r'''

7. VOS DROITS EN CALIFORNIE
Droit de savoir, de supprimer et de corriger vos informations personnelles ; droit de refuser leur vente ou leur partage ; droit de limiter l’usage des informations sensibles ; aucune discrimination pour l’exercice de vos droits.

8. VENTE ET PARTAGE
Nous ne vendons ni ne partageons d’informations personnelles à des fins de publicité comportementale inter-contextes.

9. EXERCER VOS DROITS
Écrivez à {email}. Nous vérifierons votre demande et répondrons sous 45 jours.'''
          '$_frTerms',
      'KVKK':
          'NOTICE D’INFORMATION (TURQUIE KVKK) : {company}$_frPrivacy'
          r'''

7. BASE LÉGALE (KVKK ART. 5)
L’exécution d’un contrat, les obligations légales, l’intérêt légitime et le consentement explicite lorsqu’il est requis.

8. VOS DROITS (KVKK ART. 11)
Savoir si vos données sont traitées, demander des informations, demander leur rectification ou leur suppression, contester des résultats automatisés et demander réparation. Écrivez à {email} ; nous répondons sous 30 jours.

9. TRANSFERTS À L’ÉTRANGER
Les données ne sont transférées à l’étranger qu’avec les garanties de l’article 9 de la KVKK.'''
          '$_frTerms',
    },
  ),
  'contract': ToolText(
    name: 'Contrat freelance et pacte d’associés',
    description: 'Des contrats simples pour prestataires ou cofondateurs.',
    options: {'Freelancer': 'Freelance', 'Partnership': 'Associés'},
    fields: {
      'type': FieldText('Type de contrat'),
      'company': FieldText('Nom de l’entreprise', example: 'Nimbly SAS'),
      'otherParty': FieldText('Autre partie'),
      'scope': FieldText(
        'Périmètre de la mission ou rôles',
        example: 'Concevoir et développer le MVP de l’app iOS',
      ),
      'fee': FieldText(
        'Rémunération ou parts',
        example: r'8 000 $ en deux jalons',
      ),
      'term': FieldText('Durée', example: '3 mois'),
      'law': FieldText('Droit applicable', example: 'droit français'),
      'date': FieldText('Date d’effet', example: '19 octobre 2026'),
    },
    templates: {
      'Freelancer': r'''CONTRAT DE PRESTATION INDÉPENDANTE

Entre {company} (le « Client ») et {otherParty} (le « Prestataire »), à compter du {date}.

1. PRESTATIONS
{scope}

2. RÉMUNÉRATION
{fee}. Les factures sont payables sous 14 jours.

3. DURÉE
{term}, sauf résiliation anticipée par l’une des parties moyennant un préavis écrit de 14 jours.

4. PRESTATAIRE INDÉPENDANT
Le Prestataire n’est pas salarié et reste responsable de ses impôts, cotisations et outils.

5. PROPRIÉTÉ INTELLECTUELLE
Dès paiement, l’ensemble des livrables créés au titre du présent contrat est cédé au Client.

6. CONFIDENTIALITÉ
Le Prestataire garde confidentielles les informations non publiques du Client pendant et après le présent contrat.

7. DROIT APPLICABLE
{law}.

Signatures :
{company} ____________________
{otherParty} ____________________''',
      'Partnership': r'''PACTE D’ASSOCIÉS / COFONDATEURS (TRAME)

Entre les fondateurs de {company}, dont {otherParty}, à compter du {date}.

1. RÔLES ET RESPONSABILITÉS
{scope}

2. CAPITAL
{fee}. Les parts des fondateurs sont acquises sur 4 ans avec une période minimale (cliff) d’un an.

3. ENGAGEMENT EN TEMPS
Temps plein à partir du {date} ; durée initiale de {term}, puis réexamen.

4. DÉCISIONS
Les décisions courantes sont prises par le fondateur responsable ; les décisions majeures (levée de fonds, recrutement de dirigeants, cession de la société) requièrent l’accord de tous les fondateurs.

5. PROPRIÉTÉ INTELLECTUELLE
Tout travail lié à la société est cédé à {company}.

6. DÉPART
Les parts non acquises reviennent à la société ; les parts acquises peuvent être rachetées à leur juste valeur.

7. LITIGES
D’abord une discussion de bonne foi, puis une médiation, selon le {law}.

Signatures :
____________________   ____________________''',
    },
  ),
};

// ---------------------------------------------------------------- Spanish

const _esPrivacy = r'''

1. QUIÉNES SOMOS
{company} («nosotros») ofrece {service}. Contacto: {email}.

2. DATOS QUE RECOGEMOS
{data|bullets}

3. PARA QUÉ LOS USAMOS
Para ofrecer y mejorar {service}, darte soporte y cumplir nuestras obligaciones legales.

4. COMPARTIR
Solo compartimos datos con proveedores que nos ayudan a prestar {service}, bajo contrato, y cuando la ley lo exige. No vendemos datos personales.

5. CONSERVACIÓN
Conservamos los datos mientras tu cuenta esté activa y los eliminamos en un plazo de {retention} tras cerrarla, salvo que la ley exija más tiempo.

6. SEGURIDAD
Ciframos los datos en tránsito y en reposo, y limitamos el acceso del personal.''';

const _esTerms = r'''

CONDICIONES DE USO (RESUMEN)
• Debes tener edad suficiente para firmar un contrato donde vives.
• No hagas un uso indebido de {service} ni intentes vulnerar su seguridad.
• Los planes de pago se renuevan automáticamente hasta que se cancelan en tu cuenta o en los ajustes de la tienda.
• {service} se ofrece «tal cual»; nuestra responsabilidad se limita al importe que hayas pagado en los últimos 12 meses.
• Podemos actualizar estas condiciones y te avisaremos de los cambios importantes.

Fecha de entrada en vigor: {date}
Preguntas: {email}''';

const _es = <String, ToolText>{
  'nda': ToolText(
    name: 'Acuerdo de confidencialidad (NDA mutuo)',
    description: 'Un acuerdo de confidencialidad recíproco.',
    fields: {
      'company': FieldText('Nombre de la empresa', example: 'Nimbly S.L.'),
      'otherParty': FieldText('Otra parte', example: 'Studio North S.L.'),
      'purpose': FieldText(
        'Finalidad',
        example: 'evaluar una posible colaboración',
      ),
      'term': FieldText('Periodo de confidencialidad', example: '2 años'),
      'law': FieldText(
        'Legislación aplicable',
        example: 'legislación española',
      ),
      'date': FieldText(
        'Fecha de entrada en vigor',
        example: '19 de octubre de 2026',
      ),
    },
    template: r'''ACUERDO MUTUO DE CONFIDENCIALIDAD

Este acuerdo se celebra el {date} entre {company} y {otherParty} (cada una, una «Parte»).

1. FINALIDAD
Las Partes desean compartir información confidencial para {purpose}.

2. INFORMACIÓN CONFIDENCIAL
Cualquier información comercial, técnica o financiera no pública que una Parte comparta con la otra, en cualquier formato, marcada como confidencial o que razonablemente deba entenderse como tal.

3. OBLIGACIONES
Cada Parte usará la información confidencial de la otra solo para la Finalidad, la protegerá con al menos una diligencia razonable y solo la compartirá con personas que necesiten conocerla y estén sujetas a obligaciones similares.

4. EXCLUSIONES
La información que sea pública sin culpa de la Parte receptora, que esta ya conociera, que se desarrolle de forma independiente o que se reciba legalmente de un tercero.

5. DURACIÓN
Estas obligaciones duran {term} desde la fecha de divulgación.

6. DEVOLUCIÓN O DESTRUCCIÓN
A petición, cada Parte devolverá o destruirá la información confidencial de la otra.

7. SIN LICENCIA
Nada en este acuerdo otorga derechos sobre la propiedad intelectual de la otra Parte.

8. LEGISLACIÓN APLICABLE
Este acuerdo se rige por la {law}.

Firmado:
{company} ____________________   Fecha: ________
{otherParty} ____________________   Fecha: ________''',
  ),
  'privacyTerms': ToolText(
    name: 'Política de privacidad y condiciones',
    description:
        'Política de privacidad y condiciones para RGPD, CCPA, KVKK o uso global.',
    options: {
      'Global': 'Global',
      'GDPR': 'RGPD',
      'CCPA': 'CCPA',
      'KVKK': 'KVKK',
    },
    fields: {
      'law': FieldText('Región'),
      'company': FieldText('Nombre de la empresa', example: 'Nimbly S.L.'),
      'service': FieldText('Servicio', example: 'la app y la web de Nimbly'),
      'email': FieldText('Correo de contacto'),
      'data': FieldText(
        'Datos recogidos',
        example:
            'Nombre y correo\nMovimientos bancarios que conectes\nRecibos que subas\nAnalítica de uso de la app',
      ),
      'retention': FieldText('Plazo de eliminación', example: '30 días'),
      'date': FieldText(
        'Fecha de entrada en vigor',
        example: '19 de octubre de 2026',
      ),
    },
    templates: {
      'Global':
          'POLÍTICA DE PRIVACIDAD: {company}$_esPrivacy'
          r'''

7. TUS OPCIONES
Puedes acceder a tus datos, corregirlos o eliminarlos en cualquier momento escribiendo a {email}.'''
          '$_esTerms',
      'GDPR':
          'POLÍTICA DE PRIVACIDAD (RGPD UE/R. U.): {company}$_esPrivacy'
          r'''

7. BASE JURÍDICA
El contrato (para prestar {service}), el interés legítimo (seguridad, mejora del producto) y el consentimiento (analítica y marketing opcionales).

8. TUS DERECHOS
Acceso, rectificación, supresión, limitación, portabilidad y oposición. Puedes retirar tu consentimiento en cualquier momento y reclamar ante tu autoridad de protección de datos (en España, la AEPD). Contacto: {email}.

9. TRANSFERENCIAS INTERNACIONALES
Cuando los datos salen del EEE o del Reino Unido, nos basamos en cláusulas contractuales tipo o en una decisión de adecuación.'''
          '$_esTerms',
      'CCPA':
          'POLÍTICA DE PRIVACIDAD (CALIFORNIA CCPA/CPRA): {company}$_esPrivacy'
          r'''

7. TUS DERECHOS EN CALIFORNIA
Derecho a saber, eliminar y corregir tu información personal; derecho a oponerte a su venta o cesión; derecho a limitar el uso de información sensible; sin discriminación por ejercer tus derechos.

8. VENTA Y CESIÓN
No vendemos ni cedemos información personal para publicidad comportamental entre contextos.

9. CÓMO EJERCER TUS DERECHOS
Escribe a {email}. Verificaremos tu solicitud y responderemos en un plazo de 45 días.'''
          '$_esTerms',
      'KVKK':
          'AVISO INFORMATIVO (TURQUÍA KVKK): {company}$_esPrivacy'
          r'''

7. BASE JURÍDICA (KVKK ART. 5)
La ejecución de un contrato, las obligaciones legales, el interés legítimo y el consentimiento explícito cuando sea necesario.

8. TUS DERECHOS (KVKK ART. 11)
Saber si se tratan tus datos, solicitar información, pedir su rectificación o supresión, oponerte a resultados automatizados y reclamar una indemnización. Escribe a {email}; respondemos en 30 días.

9. TRANSFERENCIAS AL EXTRANJERO
Los datos solo se transfieren al extranjero con las garantías del artículo 9 de la KVKK.'''
          '$_esTerms',
    },
  ),
  'contract': ToolText(
    name: 'Contrato freelance y pacto de socios',
    description: 'Contratos sencillos para colaboradores o cofundadores.',
    options: {'Freelancer': 'Freelance', 'Partnership': 'Socios'},
    fields: {
      'type': FieldText('Tipo de contrato'),
      'company': FieldText('Nombre de la empresa', example: 'Nimbly S.L.'),
      'otherParty': FieldText('Otra parte'),
      'scope': FieldText(
        'Alcance del trabajo o funciones',
        example: 'Diseñar y desarrollar el MVP de la app de iOS',
      ),
      'fee': FieldText(
        'Honorarios o participación',
        example: r'8000 $ en dos hitos',
      ),
      'term': FieldText('Duración', example: '3 meses'),
      'law': FieldText(
        'Legislación aplicable',
        example: 'legislación española',
      ),
      'date': FieldText(
        'Fecha de entrada en vigor',
        example: '19 de octubre de 2026',
      ),
    },
    templates: {
      'Freelancer': r'''CONTRATO DE PRESTACIÓN DE SERVICIOS INDEPENDIENTES

Entre {company} («Cliente») y {otherParty} («Profesional»), con efectos desde el {date}.

1. SERVICIOS
{scope}

2. HONORARIOS
{fee}. Las facturas se pagan en un plazo de 14 días.

3. DURACIÓN
{term}, salvo que cualquiera de las partes lo resuelva antes con un preaviso por escrito de 14 días.

4. PROFESIONAL INDEPENDIENTE
El Profesional no es empleado y es responsable de sus propios impuestos, cotizaciones y herramientas.

5. PROPIEDAD INTELECTUAL
Tras el pago, todo el trabajo creado en virtud de este contrato se cede al Cliente.

6. CONFIDENCIALIDAD
El Profesional mantendrá la confidencialidad de la información no pública del Cliente durante y después de este contrato.

7. LEGISLACIÓN APLICABLE
{law}.

Firmado:
{company} ____________________
{otherParty} ____________________''',
      'Partnership': r'''PACTO DE SOCIOS / COFUNDADORES (BORRADOR)

Entre los fundadores de {company}, incluido {otherParty}, con efectos desde el {date}.

1. FUNCIONES Y RESPONSABILIDADES
{scope}

2. PARTICIPACIÓN
{fee}. Las participaciones de los fundadores se consolidan en 4 años con un cliff de 1 año.

3. DEDICACIÓN
Dedicación completa desde el {date}; plazo inicial de {term} y después revisión.

4. DECISIONES
Las decisiones del día a día las toma el fundador responsable; las decisiones importantes (financiación, contratación de directivos, venta de la empresa) requieren a todos los fundadores.

5. PROPIEDAD INTELECTUAL
Todo el trabajo relacionado con la empresa se cede a {company}.

6. SALIDA
Las participaciones no consolidadas vuelven a la empresa; las consolidadas pueden recomprarse a valor razonable.

7. CONFLICTOS
Primero, diálogo de buena fe; después, mediación, conforme a la {law}.

Firmado:
____________________   ____________________''',
    },
  ),
};

// ----------------------------------------------------------------- German

const _dePrivacy = r'''

1. WER WIR SIND
{company} („wir“) bietet {service} an. Kontakt: {email}.

2. WELCHE DATEN WIR ERHEBEN
{data|bullets}

3. WOFÜR WIR SIE NUTZEN
Um {service} bereitzustellen und zu verbessern, dich zu unterstützen und gesetzliche Pflichten zu erfüllen.

4. WEITERGABE
Wir geben Daten nur an Dienstleister weiter, die uns beim Betrieb von {service} helfen, auf vertraglicher Grundlage und wenn das Gesetz es verlangt. Wir verkaufen keine personenbezogenen Daten.

5. SPEICHERDAUER
Wir speichern Daten, solange dein Konto aktiv ist, und löschen sie innerhalb von {retention} nach der Schließung, sofern das Gesetz keine längere Frist vorschreibt.

6. SICHERHEIT
Wir verschlüsseln Daten bei der Übertragung und im Ruhezustand und beschränken den Zugriff von Mitarbeitenden.''';

const _deTerms = r'''

NUTZUNGSBEDINGUNGEN (ZUSAMMENFASSUNG)
• Du musst an deinem Wohnort alt genug sein, um einen Vertrag zu schließen.
• Missbrauche {service} nicht und versuche nicht, die Sicherheit zu umgehen.
• Bezahlte Tarife verlängern sich automatisch, bis sie im Konto oder in den Store-Einstellungen gekündigt werden.
• {service} wird „wie besehen“ bereitgestellt; unsere Haftung ist auf den Betrag begrenzt, den du in den letzten 12 Monaten gezahlt hast.
• Wir können diese Bedingungen ändern und informieren dich über wesentliche Änderungen.

Gültig ab: {date}
Fragen: {email}''';

const _de = <String, ToolText>{
  'nda': ToolText(
    name: 'Geheimhaltungsvereinbarung (gegenseitige NDA)',
    description: 'Eine gegenseitige Vertraulichkeitsvereinbarung.',
    fields: {
      'company': FieldText('Firmenname', example: 'Nimbly GmbH'),
      'otherParty': FieldText('Andere Partei', example: 'Studio North GmbH'),
      'purpose': FieldText(
        'Zweck',
        example: 'die Prüfung einer möglichen Partnerschaft',
      ),
      'term': FieldText('Dauer der Vertraulichkeit', example: '2 Jahre'),
      'law': FieldText(
        'Anwendbares Recht',
        example: 'Recht der Bundesrepublik Deutschland',
      ),
      'date': FieldText('Gültig ab', example: '19. Oktober 2026'),
    },
    template: r'''GEGENSEITIGE GEHEIMHALTUNGSVEREINBARUNG

Diese Vereinbarung wird am {date} zwischen {company} und {otherParty} (jeweils eine „Partei“) geschlossen.

1. ZWECK
Die Parteien möchten vertrauliche Informationen austauschen für: {purpose}.

2. VERTRAULICHE INFORMATIONEN
Alle nicht öffentlichen geschäftlichen, technischen oder finanziellen Informationen, die eine Partei der anderen in beliebiger Form mitteilt und die als vertraulich gekennzeichnet sind oder vernünftigerweise als vertraulich zu verstehen sind.

3. PFLICHTEN
Jede Partei nutzt die vertraulichen Informationen der anderen nur für den Zweck, schützt sie mindestens mit angemessener Sorgfalt und gibt sie nur an Personen weiter, die sie kennen müssen und ähnlichen Pflichten unterliegen.

4. AUSNAHMEN
Informationen, die ohne Verschulden der empfangenden Partei öffentlich sind, ihr bereits bekannt waren, unabhängig entwickelt oder rechtmäßig von Dritten erhalten wurden.

5. LAUFZEIT
Diese Pflichten gelten für {term} ab dem Zeitpunkt der Offenlegung.

6. RÜCKGABE ODER VERNICHTUNG
Auf Verlangen gibt jede Partei die vertraulichen Informationen der anderen zurück oder vernichtet sie.

7. KEINE LIZENZ
Diese Vereinbarung gewährt keine Rechte am geistigen Eigentum der anderen Partei.

8. ANWENDBARES RECHT
Diese Vereinbarung unterliegt dem {law}.

Unterschriften:
{company} ____________________   Datum: ________
{otherParty} ____________________   Datum: ________''',
  ),
  'privacyTerms': ToolText(
    name: 'Datenschutzerklärung & AGB',
    description:
        'Datenschutzerklärung und Bedingungen für DSGVO, CCPA, KVKK oder weltweite Nutzung.',
    options: {
      'Global': 'Weltweit',
      'GDPR': 'DSGVO',
      'CCPA': 'CCPA',
      'KVKK': 'KVKK',
    },
    fields: {
      'law': FieldText('Region'),
      'company': FieldText('Firmenname', example: 'Nimbly GmbH'),
      'service': FieldText('Dienst', example: 'die Nimbly-App und -Website'),
      'email': FieldText('Kontakt-E-Mail'),
      'data': FieldText(
        'Erhobene Daten',
        example:
            'Name und E-Mail\nVerbundene Bankumsätze\nHochgeladene Belege\nNutzungsanalysen der App',
      ),
      'retention': FieldText('Löschfrist', example: '30 Tagen'),
      'date': FieldText('Gültig ab', example: '19. Oktober 2026'),
    },
    templates: {
      'Global':
          'DATENSCHUTZERKLÄRUNG: {company}$_dePrivacy'
          r'''

7. DEINE WAHLMÖGLICHKEITEN
Du kannst jederzeit auf deine Daten zugreifen, sie berichtigen oder löschen lassen, indem du an {email} schreibst.'''
          '$_deTerms',
      'GDPR':
          'DATENSCHUTZERKLÄRUNG (EU/UK-DSGVO): {company}$_dePrivacy'
          r'''

7. RECHTSGRUNDLAGE
Vertrag (zur Bereitstellung von {service}), berechtigtes Interesse (Sicherheit, Produktverbesserung) und Einwilligung (optionale Analysen und Marketing).

8. DEINE RECHTE
Auskunft, Berichtigung, Löschung, Einschränkung, Datenübertragbarkeit und Widerspruch. Du kannst deine Einwilligung jederzeit widerrufen und dich bei deiner Datenschutzaufsichtsbehörde beschweren. Kontakt: {email}.

9. INTERNATIONALE ÜBERMITTLUNGEN
Verlassen Daten den EWR oder das Vereinigte Königreich, stützen wir uns auf Standardvertragsklauseln oder einen Angemessenheitsbeschluss.'''
          '$_deTerms',
      'CCPA':
          'DATENSCHUTZERKLÄRUNG (KALIFORNIEN CCPA/CPRA): {company}$_dePrivacy'
          r'''

7. DEINE RECHTE IN KALIFORNIEN
Recht auf Auskunft, Löschung und Berichtigung personenbezogener Informationen; Recht, dem Verkauf oder der Weitergabe zu widersprechen; Recht, die Nutzung sensibler Informationen einzuschränken; keine Benachteiligung bei Ausübung deiner Rechte.

8. VERKAUF UND WEITERGABE
Wir verkaufen oder teilen keine personenbezogenen Informationen für kontextübergreifende verhaltensbasierte Werbung.

9. SO ÜBST DU DEINE RECHTE AUS
Schreib an {email}. Wir prüfen deine Anfrage und antworten innerhalb von 45 Tagen.'''
          '$_deTerms',
      'KVKK':
          'DATENSCHUTZHINWEIS (TÜRKEI KVKK): {company}$_dePrivacy'
          r'''

7. RECHTSGRUNDLAGE (KVKK ART. 5)
Vertragserfüllung, rechtliche Verpflichtungen, berechtigtes Interesse und, wo erforderlich, ausdrückliche Einwilligung.

8. DEINE RECHTE (KVKK ART. 11)
Erfahren, ob deine Daten verarbeitet werden, Auskunft verlangen, Berichtigung oder Löschung verlangen, automatisierten Ergebnissen widersprechen und Schadensersatz fordern. Wende dich an {email}; wir antworten innerhalb von 30 Tagen.

9. ÜBERMITTLUNG INS AUSLAND
Daten werden nur mit den Garantien nach Artikel 9 KVKK ins Ausland übermittelt.'''
          '$_deTerms',
    },
  ),
  'contract': ToolText(
    name: 'Freelancer- & Gesellschaftervertrag',
    description: 'Einfache Verträge für Auftragnehmer oder Mitgründer.',
    options: {'Freelancer': 'Freelancer', 'Partnership': 'Gesellschafter'},
    fields: {
      'type': FieldText('Vertragsart'),
      'company': FieldText('Firmenname', example: 'Nimbly GmbH'),
      'otherParty': FieldText('Andere Partei'),
      'scope': FieldText(
        'Leistungsumfang oder Rollen',
        example: 'Design und Entwicklung des MVP der iOS-App',
      ),
      'fee': FieldText(
        'Vergütung oder Anteile',
        example: r'8.000 $ in zwei Meilensteinen',
      ),
      'term': FieldText('Laufzeit', example: '3 Monate'),
      'law': FieldText(
        'Anwendbares Recht',
        example: 'Recht der Bundesrepublik Deutschland',
      ),
      'date': FieldText('Gültig ab', example: '19. Oktober 2026'),
    },
    templates: {
      'Freelancer': r'''VERTRAG ÜBER FREIE MITARBEIT

Zwischen {company} („Auftraggeber“) und {otherParty} („Auftragnehmer“), gültig ab {date}.

1. LEISTUNGEN
{scope}

2. VERGÜTUNG
{fee}. Rechnungen sind innerhalb von 14 Tagen fällig.

3. LAUFZEIT
{term}, sofern nicht eine Partei mit einer schriftlichen Frist von 14 Tagen früher kündigt.

4. SELBSTSTÄNDIGKEIT
Der Auftragnehmer ist kein Arbeitnehmer und für eigene Steuern, Abgaben und Arbeitsmittel selbst verantwortlich.

5. GEISTIGES EIGENTUM
Mit Zahlung gehen alle im Rahmen dieses Vertrags erstellten Arbeitsergebnisse auf den Auftraggeber über.

6. VERTRAULICHKEIT
Der Auftragnehmer behandelt nicht öffentliche Informationen des Auftraggebers während und nach diesem Vertrag vertraulich.

7. ANWENDBARES RECHT
{law}.

Unterschriften:
{company} ____________________
{otherParty} ____________________''',
      'Partnership': r'''MITGRÜNDER- / GESELLSCHAFTERVEREINBARUNG (ENTWURF)

Zwischen den Gründern von {company}, einschließlich {otherParty}, gültig ab {date}.

1. ROLLEN UND VERANTWORTUNG
{scope}

2. ANTEILE
{fee}. Gründeranteile werden über 4 Jahre mit einer Cliff von 1 Jahr erdient (Vesting).

3. ZEITEINSATZ
Vollzeit ab {date}; erste Laufzeit {term}, danach Überprüfung.

4. ENTSCHEIDUNGEN
Tagesentscheidungen trifft der zuständige Gründer; wichtige Entscheidungen (Finanzierung, Einstellung von Führungskräften, Verkauf des Unternehmens) brauchen alle Gründer.

5. GEISTIGES EIGENTUM
Alle unternehmensbezogenen Arbeiten gehen auf {company} über.

6. AUSSCHEIDEN
Nicht erdiente Anteile fallen an das Unternehmen zurück; erdiente Anteile können zum Verkehrswert zurückgekauft werden.

7. STREITIGKEITEN
Zuerst ein Gespräch in gutem Glauben, dann Mediation, nach dem {law}.

Unterschriften:
____________________   ____________________''',
    },
  ),
};
