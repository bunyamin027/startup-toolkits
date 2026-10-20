import 'tool_text.dart';

/// Marketing & content tools (`catalog/marketing.dart`) per language.
const marketingText = <String, Map<String, ToolText>>{
  'tr': _tr,
  'fr': _fr,
  'es': _es,
  'de': _de,
};

const _tr = <String, ToolText>{
  'brandName': ToolText(
    name: 'Marka adı ve slogan',
    description: 'Birkaç anahtar kelimeden ad fikirleri ve sloganlar.',
    fields: {
      'keyword': FieldText(
        'Ana anahtar kelime',
        example: 'defter',
        hint: 'Ürünü anlatan tek kelime',
      ),
      'keyword2': FieldText('İkinci anahtar kelime', example: 'kolay'),
      'benefit': FieldText(
        'Ana fayda',
        example: 'kazandığınızın daha fazlası cebinizde',
      ),
      'audience': FieldText('Hedef kitle', example: 'serbest çalışanlar'),
    },
    template: r'''AD FİKİRLERİ
• {keyword|cap}im
• {keyword2|cap}
• {keyword|cap}Go
• {keyword|cap}Hane
• {keyword2|cap}{keyword|cap}
• {keyword|cap}ify
• Hey{keyword|cap}
• {keyword|cap}Merkez
• {keyword2|cap}App
• {keyword2|cap}io

SLOGANLAR
• {benefit|cap}.
• {audience|cap} için yapıldı. Dakikalar içinde hazır.
• Siz çalışırken çalışan {keyword|lower}.
• Daha az evrak. Daha çok iş.
• Tasarımı gereği {keyword2|lower}.

Seçmeden önce: alan adını ve uygulama mağazasındaki adları kontrol edin, marka tescillerini arayın ve adı beş kişiye yüksek sesle söyleyin.''',
  ),
  'colorPalette': ToolText(
    name: 'Renk paleti ve logo fikri',
    description: 'Marka havasına göre başlangıç paleti ve logo yönü.',
    options: {
      'Trustworthy': 'Güven veren',
      'Bold': 'Cesur',
      'Calm': 'Sakin',
      'Playful': 'Eğlenceli',
      'Premium': 'Premium',
    },
    fields: {
      'company': FieldText('Girişim adı'),
      'mood': FieldText('Marka havası'),
    },
    templates: {
      'Trustworthy': r'''PALET: GÜVEN VEREN ({company})
Ana renk     #1F4FD8  koyu mavi
İkincil      #14B8A6  camgöbeği
Vurgu        #F59E0B  kehribar, eylem çağrıları için
Nötr         #0F172A / #F8FAFC
Başlıklar ve düğmeler için maviyi, kehribarı yalnızca istediğiniz tek eylem için kullanın.

LOGO FİKRİ
Geometrik bir sans yazı tipiyle sade bir "{company}" yazısı; ilk harfe katlanmış küçük bir onay işareti ya da kalkan.''',
      'Bold': r'''PALET: CESUR ({company})
Ana renk     #E11D48  kızıl
İkincil      #111827  siyaha yakın
Vurgu        #FACC15  sarı
Nötr         #F9FAFB
Yüksek kontrast; kırmızı öne çıksın diye geniş alanları siyah ya da beyaz bırakın.

LOGO FİKRİ
Kalın, dar "{company|upper}" yazısı; harflerden biri çapraz kesilmiş.''',
      'Calm': r'''PALET: SAKİN ({company})
Ana renk     #4F8A8B  adaçayı yeşili
İkincil      #A7C4BC  sis
Vurgu        #F4A261  yumuşak turuncu
Nötr         #FBFAF7 / #2B2D42
Bol boşluk, yuvarlak biçimler.

LOGO FİKRİ
Yuvarlak bir sans yazı tipiyle küçük harfli "{company|lower}"; yanında yumuşak bir daire ya da yaprak simgesi.''',
      'Playful': r'''PALET: EĞLENCELİ ({company})
Ana renk     #7C3AED  mor
İkincil      #22D3EE  turkuaz
Vurgu        #FB7185  mercan
Nötr         #FFFFFF / #1E1B4B
İllüstrasyonlarda renkleri özgürce karıştırın; metni açık zemin üzerinde koyu tutun.

LOGO FİKRİ
Yuvarlak, hafif zıplayan bir yazı tipiyle "{company}" ve yanında sevimli bir maskot ya da damla biçimi.''',
      'Premium': r'''PALET: PREMIUM ({company})
Ana renk     #0B1020  gece mavisi
İkincil      #C9A227  mat altın
Vurgu        #E5E7EB  gümüş
Nötr         #FAFAF9
Altını idareli kullanın: çizgiler, simgeler, ekran başına tek vurgu.

LOGO FİKRİ
Yüksek kontrastlı serif bir yazı tipiyle aralıklı büyük harflerle "{company|upper}" ya da ince bir çerçeve içinde ilk harften bir monogram.''',
    },
  ),
  'contentCalendar': ToolText(
    name: 'İçerik takvimi',
    description: 'Gönderileri fikirden yayına kadar planlayın.',
    itemLabel: 'Gönderi',
    stages: {
      'Idea': 'Fikir',
      'Drafting': 'Taslak',
      'Scheduled': 'Planlandı',
      'Published': 'Yayınlandı',
    },
    fields: {
      'channel': FieldText('Kanal'),
      'date': FieldText('Tarih', example: 'Pzt'),
    },
    samples: [
      SampleText('Serbest çalışanların unuttuğu 5 vergi indirimi', {
        'date': '22 Eki',
      }),
      SampleText('Perde arkası: banka senkronizasyonu', {'date': '24 Eki'}),
      SampleText('Üç aylık vergi son tarihi hatırlatması', {'date': '10 Oca'}),
    ],
  ),
  'landingPage': ToolText(
    name: 'Açılış sayfası metni',
    description: 'Ana başlık, faydalar, sosyal kanıt ve eylem çağrısı.',
    fields: {
      'company': FieldText('Ürün adı'),
      'audience': FieldText('Hedef kitle', example: 'serbest çalışanlar'),
      'outcome': FieldText(
        'Ana sonuç',
        example: 'Kendi kendini yapan muhasebe',
      ),
      'problem': FieldText(
        'Problem',
        example:
            'Serbest çalışmaya harika işler çıkarmak için başladınız, fiş kovalamak için değil.',
      ),
      'features': FieldText(
        'En önemli 3 özellik',
        example:
            'Banka senkronizasyonu her gideri sınıflandırır\nÜç aylık vergi tahmini, her zaman güncel\nFişleri bir saniyede çekin',
      ),
      'proof': FieldText(
        'Sosyal kanıt',
        example: '1.200 serbest çalışan güveniyor',
      ),
      'cta': FieldText('Eylem çağrısı', example: 'Ücretsiz başla'),
    },
    template: r'''ANA BÖLÜM
{outcome}.
{company}, {audience} için yapıldı.
→ {cta}

PROBLEM
{problem}

{company|upper} NASIL YARDIM EDER
{features|bullets}

SOSYAL KANIT
{proof}

SSS
• Kurulum ne kadar sürer? Yaklaşık iki dakika.
• İstediğim zaman iptal edebilir miyim? Evet, tek dokunuşla.
• Verilerim güvende mi? Banka düzeyinde şifreleme; verileri asla satmayız.

SON EYLEM ÇAĞRISI
Zamanınızı geri almaya hazır mısınız? → {cta}''',
  ),
  'emailTemplates': ToolText(
    name: 'E-posta şablonları',
    description: 'Soğuk erişim, takip, yatırımcı güncellemesi, teşekkür.',
    options: {
      'Cold outreach': 'Soğuk erişim',
      'Follow-up': 'Takip',
      'Investor update': 'Yatırımcı güncellemesi',
      'Thank you': 'Teşekkür',
    },
    fields: {
      'type': FieldText('E-posta türü'),
      'recipient': FieldText('Alıcının adı'),
      'sender': FieldText('Adınız'),
      'company': FieldText('Girişim adı'),
      'oneLiner': FieldText(
        'Tek cümlelik tanım',
        example: 'serbest çalışanlar için kendi kendini yapan muhasebe',
      ),
      'hook': FieldText(
        'Kişisel bağlantı',
        example: 'SaaStr’daki tek kurucular konuşmanız',
      ),
      'traction': FieldText(
        'Çekiş',
        example: r'3,5 bin $ MRR, bu ay %18 artış',
      ),
      'ask': FieldText(
        'Talep',
        example: 'önümüzdeki hafta 20 dakikalık bir görüşme',
      ),
    },
    templates: {
      'Cold outreach': r'''Konu: Kısa bir soru, {recipient}

Merhaba {recipient},

{hook} beni çok etkiledi. Ben {sender}, {company} kurucusuyum: {oneLiner}.

Şu an {traction} seviyesindeyiz ve bir sonraki adımımız hakkında keskin bir görüşünüz olacağını düşünüyorum.

{ask} için müsait olur musunuz?

Teşekkürler,
{sender}''',
      'Follow-up': r'''Konu: Ynt: Kısa bir soru, {recipient}

Merhaba {recipient},

Gözden kaçmış olabilir diye tekrar yazıyorum. Son mesajımdan bu yana: {traction}.

{ask} konusunda hâlâ çok istekliyim. Şu an uygun değilse söylemeniz yeterli, bir sonraki çeyrekte tekrar yazarım.

Sevgiler,
{sender}''',
      'Investor update': r'''Konu: {company} güncellemesi: {traction}

Merhaba {recipient},

Öne çıkanlar
• {traction}

Zorluklar
• Bu ay neyin işe yaramadığı ve ne öğrendiğimiz.

Talepler
• {ask}

Desteğiniz için teşekkürler,
{sender}''',
      'Thank you': r'''Konu: Teşekkürler, {recipient}

Merhaba {recipient},

Bugün zaman ayırdığınız için teşekkür ederim. {hook} hakkındaki görüşünüz özellikle çok faydalı oldu.

Söz verdiğim gibi, sonraki adımları cuma gününe kadar ileteceğim.

Sevgiler,
{sender}
{company}''',
    },
  ),
  'seoKeywords': ToolText(
    name: 'SEO anahtar kelime fikirleri',
    description: 'Müşterilerinizin aradığı terimler.',
    fields: {
      'topic': FieldText('Konu', example: 'muhasebe'),
      'audience': FieldText('Hedef kitle', example: 'serbest çalışanlar'),
      'alternative': FieldText(
        'Bilinen rakip ya da alternatif',
        example: 'excel tabloları',
      ),
      'location': FieldText('Konum', example: 'Türkiye'),
    },
    template: r'''YÜKSEK NİYET (satın almaya hazır)
• {audience} için en iyi {topic} uygulaması
• {audience} için {topic} yazılımı
• {topic} programı fiyatları
• {topic} için {alternative} alternatifi

PROBLEM (yardım arıyor)
• serbest çalışan olarak {topic} nasıl yapılır
• {audience} için {topic} ipuçları
• kaçınılması gereken {topic} hataları
• {audience} için {topic} kontrol listesi

YEREL
• {location} {audience} için {topic}
• {location} {topic} kuralları {audience}

UZUN KUYRUK BLOG FİKİRLERİ
• {audience|cap} için {topic}: yeni başlayanlar rehberi
• {alternative|cap} mı, {topic} uygulamaları mı: hangisi daha iyi?
• {topic|cap} her ay ne kadar zaman alıyor?

Sonraki adım: hacim ve zorluğu bir anahtar kelime aracında kontrol edin, ardından her yüksek niyetli terim için bir sayfa yazın.''',
  ),
};

const _fr = <String, ToolText>{
  'brandName': ToolText(
    name: 'Nom de marque et slogan',
    description:
        'Des idées de nom et d’accroche à partir de quelques mots-clés.',
    fields: {
      'keyword': FieldText(
        'Mot-clé principal',
        example: 'compta',
        hint: 'Un mot qui décrit le produit',
      ),
      'keyword2': FieldText('Deuxième mot-clé', example: 'agile'),
      'benefit': FieldText(
        'Bénéfice principal',
        example: 'gardez davantage de ce que vous gagnez',
      ),
      'audience': FieldText('Public', example: 'freelances'),
    },
    template: r'''IDÉES DE NOM
• {keyword|cap}ly
• {keyword2|cap}
• Ma{keyword|cap}
• {keyword|cap}Hub
• {keyword2|cap}{keyword|cap}
• {keyword|cap}ify
• Hey{keyword|cap}
• {keyword|cap}Base
• {keyword2|cap}App
• {keyword2|cap}io

SLOGANS
• {benefit|cap}.
• Conçu pour les {audience}. Prêt en quelques minutes.
• La {keyword|lower} qui travaille pendant que vous travaillez.
• Moins d’administratif. Plus de travail qui compte.
• {keyword2|cap} par nature.

Avant de choisir : vérifiez le nom de domaine et les noms sur les stores, recherchez les marques déposées et prononcez-le à voix haute devant cinq personnes.''',
  ),
  'colorPalette': ToolText(
    name: 'Palette de couleurs et idée de logo',
    description:
        'Une palette de départ et une piste de logo selon l’ambiance de marque.',
    options: {
      'Trustworthy': 'Digne de confiance',
      'Bold': 'Audacieuse',
      'Calm': 'Apaisante',
      'Playful': 'Ludique',
      'Premium': 'Premium',
    },
    fields: {
      'company': FieldText('Nom de la startup'),
      'mood': FieldText('Ambiance de marque'),
    },
    templates: {
      'Trustworthy': r'''PALETTE : DIGNE DE CONFIANCE ({company})
Principale  #1F4FD8  bleu profond
Secondaire  #14B8A6  sarcelle
Accent      #F59E0B  ambre, pour les appels à l’action
Neutres     #0F172A / #F8FAFC
Le bleu pour les titres et boutons, l’ambre uniquement pour l’action que vous voulez.

IDÉE DE LOGO
Un logotype simple « {company} » en linéale géométrique, avec une petite coche ou un bouclier intégré à la première lettre.''',
      'Bold': r'''PALETTE : AUDACIEUSE ({company})
Principale  #E11D48  cramoisi
Secondaire  #111827  quasi noir
Accent      #FACC15  jaune
Neutre      #F9FAFB
Contraste fort ; gardez de grandes zones noires ou blanches pour que le rouge reste percutant.

IDÉE DE LOGO
Logotype épais et condensé « {company|upper} » avec une lettre coupée en diagonale.''',
      'Calm': r'''PALETTE : APAISANTE ({company})
Principale  #4F8A8B  vert sauge
Secondaire  #A7C4BC  brume
Accent      #F4A261  orange doux
Neutres     #FBFAF7 / #2B2D42
Beaucoup d’espace blanc, des formes arrondies.

IDÉE DE LOGO
« {company|lower} » en minuscules dans une linéale arrondie, avec un cercle doux ou une feuille.''',
      'Playful': r'''PALETTE : LUDIQUE ({company})
Principale  #7C3AED  violet
Secondaire  #22D3EE  cyan
Accent      #FB7185  corail
Neutres     #FFFFFF / #1E1B4B
Mélangez librement les couleurs dans les illustrations ; gardez le texte foncé sur fond clair.

IDÉE DE LOGO
Une mascotte sympathique ou une forme organique à côté de « {company} » dans une police arrondie et un peu bondissante.''',
      'Premium': r'''PALETTE : PREMIUM ({company})
Principale  #0B1020  minuit
Secondaire  #C9A227  or mat
Accent      #E5E7EB  argent
Neutre      #FAFAF9
Utilisez l’or avec parcimonie : filets, icônes, un seul accent par écran.

IDÉE DE LOGO
Capitales espacées « {company|upper} » dans un empattement très contrasté, ou un monogramme de la première lettre dans un cadre fin.''',
    },
  ),
  'contentCalendar': ToolText(
    name: 'Calendrier éditorial',
    description: 'Planifiez vos publications de l’idée à la mise en ligne.',
    itemLabel: 'Publication',
    stages: {
      'Idea': 'Idée',
      'Drafting': 'Rédaction',
      'Scheduled': 'Programmée',
      'Published': 'Publiée',
    },
    fields: {
      'channel': FieldText('Canal'),
      'date': FieldText('Date', example: 'Lun.'),
    },
    samples: [
      SampleText('5 déductions que les freelances oublient', {
        'date': '22 oct.',
      }),
      SampleText('Dans les coulisses : la synchro bancaire', {
        'date': '24 oct.',
      }),
      SampleText('Rappel de l’échéance fiscale trimestrielle', {
        'date': '10 janv.',
      }),
    ],
  ),
  'landingPage': ToolText(
    name: 'Textes de landing page',
    description: 'Accroche, bénéfices, preuve sociale et appel à l’action.',
    fields: {
      'company': FieldText('Nom du produit'),
      'audience': FieldText('Public cible', example: 'les freelances'),
      'outcome': FieldText(
        'Résultat principal',
        example: 'Une comptabilité qui se fait toute seule',
      ),
      'problem': FieldText(
        'Problème',
        example:
            'Vous êtes devenu freelance pour faire du bon travail, pas pour courir après les reçus.',
      ),
      'features': FieldText(
        'Les 3 fonctionnalités clés',
        example:
            'La synchro bancaire classe chaque dépense\nEstimation d’impôt trimestrielle toujours à jour\nPhotographiez vos reçus en une seconde',
      ),
      'proof': FieldText(
        'Preuve sociale',
        example: 'Déjà adopté par 1 200 freelances',
      ),
      'cta': FieldText('Appel à l’action', example: 'Commencer gratuitement'),
    },
    template: r'''ACCROCHE
{outcome}.
{company} est conçu pour {audience}.
→ {cta}

PROBLÈME
{problem}

COMMENT {company|upper} VOUS AIDE
{features|bullets}

PREUVE SOCIALE
{proof}

FAQ
• Combien de temps prend la configuration ? Environ deux minutes.
• Puis-je résilier à tout moment ? Oui, en un geste.
• Mes données sont-elles en sécurité ? Chiffrement de niveau bancaire, et nous ne vendons jamais de données.

DERNIER APPEL À L’ACTION
Prêt à récupérer votre temps ? → {cta}''',
  ),
  'emailTemplates': ToolText(
    name: 'Modèles d’e-mails',
    description: 'Prospection, relance, point investisseurs, remerciement.',
    options: {
      'Cold outreach': 'Prospection',
      'Follow-up': 'Relance',
      'Investor update': 'Point investisseurs',
      'Thank you': 'Remerciement',
    },
    fields: {
      'type': FieldText('Type d’e-mail'),
      'recipient': FieldText('Prénom du destinataire'),
      'sender': FieldText('Votre nom'),
      'company': FieldText('Nom de la startup'),
      'oneLiner': FieldText(
        'Description en une phrase',
        example:
            'une comptabilité qui se fait toute seule, pour les freelances',
      ),
      'hook': FieldText(
        'Accroche personnelle',
        example: 'votre talk sur les fondateurs solo à SaaStr',
      ),
      'traction': FieldText(
        'Traction',
        example: r'3,5 k$ de MRR, +18 % ce mois-ci',
      ),
      'ask': FieldText(
        'Demande',
        example: 'un appel de 20 minutes la semaine prochaine',
      ),
    },
    templates: {
      'Cold outreach': r'''Objet : Petite question, {recipient}

Bonjour {recipient},

J’ai adoré {hook}. Je suis {sender}, fondatrice de {company} : {oneLiner}.

Nous en sommes à {traction}, et je pense que votre regard sur la suite serait précieux.

Seriez-vous partant pour {ask} ?

Merci,
{sender}''',
      'Follow-up': r'''Objet : Re : Petite question, {recipient}

Bonjour {recipient},

Je remonte ce message au cas où il serait passé inaperçu. Depuis mon dernier mot : {traction}.

Toujours partante pour {ask}. Si ce n’est pas le bon moment, dites-le-moi simplement et je reviendrai vers vous le trimestre prochain.

Bien à vous,
{sender}''',
      'Investor update': r'''Objet : Point {company} : {traction}

Bonjour {recipient},

Temps forts
• {traction}

Points faibles
• Ce qui n’a pas marché ce mois-ci et ce que nous en avons appris.

Demandes
• {ask}

Merci pour votre soutien,
{sender}''',
      'Thank you': r'''Objet : Merci, {recipient}

Bonjour {recipient},

Merci pour le temps que vous m’avez accordé aujourd’hui. Votre remarque sur {hook} m’a particulièrement aidée.

Comme promis, je reviens vers vous avec les prochaines étapes d’ici vendredi.

Bien à vous,
{sender}
{company}''',
    },
  ),
  'seoKeywords': ToolText(
    name: 'Idées de mots-clés SEO',
    description: 'Les termes que vos clients tapent.',
    fields: {
      'topic': FieldText('Sujet', example: 'comptabilité'),
      'audience': FieldText('Public', example: 'freelances'),
      'alternative': FieldText(
        'Concurrent ou alternative connue',
        example: 'tableur',
      ),
      'location': FieldText('Lieu', example: 'France'),
    },
    template: r'''FORTE INTENTION (prêts à acheter)
• meilleure app de {topic} pour {audience}
• logiciel de {topic} pour {audience}
• prix outil de {topic}
• alternative au {alternative} pour la {topic}

PROBLÈME (cherchent de l’aide)
• comment gérer sa {topic} en freelance
• conseils de {topic} pour {audience}
• erreurs de {topic} à éviter
• checklist {topic} pour {audience}

LOCAL
• {topic} {audience} {location}
• règles {topic} {location} {audience}

IDÉES D’ARTICLES LONGUE TRAÎNE
• {topic|cap} pour {audience} : le guide du débutant
• {alternative|cap} ou app de {topic} : que choisir ?
• Combien de temps prend la {topic} chaque mois ?

Ensuite : vérifiez le volume et la difficulté dans un outil de mots-clés, puis rédigez une page par terme à forte intention.''',
  ),
};

const _es = <String, ToolText>{
  'brandName': ToolText(
    name: 'Nombre de marca y eslogan',
    description: 'Ideas de nombre y eslóganes a partir de unas palabras clave.',
    fields: {
      'keyword': FieldText(
        'Palabra clave principal',
        example: 'cuenta',
        hint: 'Una palabra que describa el producto',
      ),
      'keyword2': FieldText('Segunda palabra clave', example: 'ágil'),
      'benefit': FieldText(
        'Beneficio principal',
        example: 'quédate con más de lo que ganas',
      ),
      'audience': FieldText('Público', example: 'freelancers'),
    },
    template: r'''IDEAS DE NOMBRE
• {keyword|cap}ly
• {keyword2|cap}
• Mi{keyword|cap}
• {keyword|cap}Hub
• {keyword2|cap}{keyword|cap}
• {keyword|cap}ify
• Hola{keyword|cap}
• {keyword|cap}Base
• {keyword2|cap}App
• {keyword2|cap}io

ESLÓGANES
• {benefit|cap}.
• Hecho para {audience}. Listo en minutos.
• La {keyword|lower} que trabaja mientras tú trabajas.
• Menos papeleo. Más trabajo que importa.
• {keyword2|cap} por diseño.

Antes de elegir: comprueba el dominio y los nombres en las tiendas de apps, busca marcas registradas y dilo en voz alta a cinco personas.''',
  ),
  'colorPalette': ToolText(
    name: 'Paleta de colores e idea de logo',
    description:
        'Una paleta inicial y una dirección de logo según el estilo de marca.',
    options: {
      'Trustworthy': 'Confiable',
      'Bold': 'Audaz',
      'Calm': 'Tranquila',
      'Playful': 'Divertida',
      'Premium': 'Premium',
    },
    fields: {
      'company': FieldText('Nombre de la startup'),
      'mood': FieldText('Estilo de marca'),
    },
    templates: {
      'Trustworthy': r'''PALETA: CONFIABLE ({company})
Principal   #1F4FD8  azul intenso
Secundario  #14B8A6  verde azulado
Acento      #F59E0B  ámbar, para las llamadas a la acción
Neutros     #0F172A / #F8FAFC
Azul para títulos y botones; ámbar solo para la acción que más te importa.

IDEA DE LOGO
Un logotipo sencillo «{company}» en una sans geométrica, con una pequeña marca de verificación o un escudo integrado en la primera letra.''',
      'Bold': r'''PALETA: AUDAZ ({company})
Principal   #E11D48  carmesí
Secundario  #111827  casi negro
Acento      #FACC15  amarillo
Neutro      #F9FAFB
Contraste alto; deja grandes zonas en negro o blanco para que el rojo destaque.

IDEA DE LOGO
Logotipo grueso y condensado «{company|upper}» con una letra cortada en diagonal.''',
      'Calm': r'''PALETA: TRANQUILA ({company})
Principal   #4F8A8B  verde salvia
Secundario  #A7C4BC  bruma
Acento      #F4A261  naranja suave
Neutros     #FBFAF7 / #2B2D42
Mucho espacio en blanco, formas redondeadas.

IDEA DE LOGO
«{company|lower}» en minúsculas con una sans redondeada y un círculo suave o una hoja.''',
      'Playful': r'''PALETA: DIVERTIDA ({company})
Principal   #7C3AED  violeta
Secundario  #22D3EE  cian
Acento      #FB7185  coral
Neutros     #FFFFFF / #1E1B4B
Mezcla los colores con libertad en las ilustraciones; mantén el texto oscuro sobre fondo claro.

IDEA DE LOGO
Una mascota simpática o una forma orgánica junto a «{company}» en una fuente redondeada y algo saltarina.''',
      'Premium': r'''PALETA: PREMIUM ({company})
Principal   #0B1020  medianoche
Secundario  #C9A227  oro mate
Acento      #E5E7EB  plata
Neutro      #FAFAF9
Usa el oro con moderación: líneas, iconos, un solo detalle por pantalla.

IDEA DE LOGO
Mayúsculas espaciadas «{company|upper}» en una serif de alto contraste, o un monograma de la primera letra dentro de un marco fino.''',
    },
  ),
  'contentCalendar': ToolText(
    name: 'Calendario de contenidos',
    description: 'Planifica publicaciones desde la idea hasta su publicación.',
    itemLabel: 'Publicación',
    stages: {
      'Idea': 'Idea',
      'Drafting': 'Borrador',
      'Scheduled': 'Programada',
      'Published': 'Publicada',
    },
    fields: {
      'channel': FieldText('Canal'),
      'date': FieldText('Fecha', example: 'Lun'),
    },
    samples: [
      SampleText('5 deducciones que los freelancers olvidan', {
        'date': '22 oct',
      }),
      SampleText('Así lo construimos: la sincronización bancaria', {
        'date': '24 oct',
      }),
      SampleText('Recordatorio del plazo trimestral de impuestos', {
        'date': '10 ene',
      }),
    ],
  ),
  'landingPage': ToolText(
    name: 'Textos de landing page',
    description: 'Titular, beneficios, prueba social y llamada a la acción.',
    fields: {
      'company': FieldText('Nombre del producto'),
      'audience': FieldText('Público objetivo', example: 'freelancers'),
      'outcome': FieldText(
        'Resultado principal',
        example: 'Contabilidad que se hace sola',
      ),
      'problem': FieldText(
        'Problema',
        example:
            'Te hiciste freelance para hacer un gran trabajo, no para perseguir recibos.',
      ),
      'features': FieldText(
        'Las 3 funciones principales',
        example:
            'La sincronización bancaria clasifica cada gasto\nEstimación trimestral de impuestos, siempre al día\nFotografía recibos en un segundo',
      ),
      'proof': FieldText(
        'Prueba social',
        example: 'Más de 1200 freelancers confían en nosotros',
      ),
      'cta': FieldText('Llamada a la acción', example: 'Empieza gratis'),
    },
    template: r'''TITULAR
{outcome}.
{company} está hecho para {audience}.
→ {cta}

PROBLEMA
{problem}

CÓMO TE AYUDA {company|upper}
{features|bullets}

PRUEBA SOCIAL
{proof}

PREGUNTAS FRECUENTES
• ¿Cuánto se tarda en configurarlo? Unos dos minutos.
• ¿Puedo cancelar cuando quiera? Sí, con un toque.
• ¿Mis datos están seguros? Cifrado de nivel bancario, y nunca vendemos datos.

LLAMADA A LA ACCIÓN FINAL
¿Listo para recuperar tu tiempo? → {cta}''',
  ),
  'emailTemplates': ToolText(
    name: 'Plantillas de correo',
    description:
        'Contacto en frío, seguimiento, informe a inversores, agradecimiento.',
    options: {
      'Cold outreach': 'Contacto en frío',
      'Follow-up': 'Seguimiento',
      'Investor update': 'Informe a inversores',
      'Thank you': 'Agradecimiento',
    },
    fields: {
      'type': FieldText('Tipo de correo'),
      'recipient': FieldText('Nombre del destinatario'),
      'sender': FieldText('Tu nombre'),
      'company': FieldText('Nombre de la startup'),
      'oneLiner': FieldText(
        'Descripción en una frase',
        example: 'contabilidad que se hace sola, para freelancers',
      ),
      'hook': FieldText(
        'Gancho personal',
        example: 'tu charla sobre fundadores en solitario en SaaStr',
      ),
      'traction': FieldText(
        'Tracción',
        example: r'3,5 k$ de MRR, un 18 % más este mes',
      ),
      'ask': FieldText(
        'Petición',
        example: 'una llamada de 20 minutos la semana que viene',
      ),
    },
    templates: {
      'Cold outreach': r'''Asunto: Una pregunta rápida, {recipient}

Hola, {recipient}:

Me encantó {hook}. Soy {sender}, fundadora de {company}: {oneLiner}.

Estamos en {traction} y creo que tendrías una visión muy clara de hacia dónde ir ahora.

¿Te vendría bien {ask}?

Gracias,
{sender}''',
      'Follow-up': r'''Asunto: RE: Una pregunta rápida, {recipient}

Hola, {recipient}:

Te vuelvo a escribir por si se te pasó. Desde mi último mensaje: {traction}.

Sigo con muchas ganas de {ask}. Si ahora no es buen momento, dímelo y te escribo el próximo trimestre.

Un saludo,
{sender}''',
      'Investor update': r'''Asunto: Novedades de {company}: {traction}

Hola, {recipient}:

Lo mejor
• {traction}

Lo peor
• Qué no funcionó este mes y qué aprendimos.

Peticiones
• {ask}

Gracias por el apoyo,
{sender}''',
      'Thank you': r'''Asunto: Gracias, {recipient}

Hola, {recipient}:

Gracias por tu tiempo hoy. Lo que comentaste sobre {hook} me resultó especialmente útil.

Como te prometí, te enviaré los próximos pasos antes del viernes.

Un saludo,
{sender}
{company}''',
    },
  ),
  'seoKeywords': ToolText(
    name: 'Ideas de palabras clave SEO',
    description: 'Los términos que buscan tus clientes.',
    fields: {
      'topic': FieldText('Tema', example: 'contabilidad'),
      'audience': FieldText('Público', example: 'freelancers'),
      'alternative': FieldText(
        'Competidor o alternativa conocida',
        example: 'excel',
      ),
      'location': FieldText('Ubicación', example: 'España'),
    },
    template: r'''ALTA INTENCIÓN (listos para comprar)
• mejor app de {topic} para {audience}
• software de {topic} para {audience}
• precio herramienta de {topic}
• alternativa a {alternative} para {topic}

PROBLEMA (buscan ayuda)
• cómo llevar la {topic} siendo freelance
• consejos de {topic} para {audience}
• errores de {topic} que evitar
• checklist de {topic} para {audience}

LOCAL
• {topic} para {audience} en {location}
• normas de {topic} {location} {audience}

IDEAS DE BLOG DE COLA LARGA
• {topic|cap} para {audience}: guía para principiantes
• {alternative|cap} o apps de {topic}: ¿qué es mejor?
• ¿Cuánto tiempo lleva la {topic} cada mes?

Siguiente paso: comprueba el volumen y la dificultad en una herramienta de palabras clave y escribe una página por cada término de alta intención.''',
  ),
};

const _de = <String, ToolText>{
  'brandName': ToolText(
    name: 'Markenname & Slogan',
    description: 'Namensideen und Slogans aus ein paar Schlüsselwörtern.',
    fields: {
      'keyword': FieldText(
        'Hauptschlüsselwort',
        example: 'beleg',
        hint: 'Ein Wort, das das Produkt beschreibt',
      ),
      'keyword2': FieldText('Zweites Schlüsselwort', example: 'flink'),
      'benefit': FieldText(
        'Hauptnutzen',
        example: 'behalte mehr von dem, was du verdienst',
      ),
      'audience': FieldText('Zielgruppe', example: 'Freelancer'),
    },
    template: r'''NAMENSIDEEN
• {keyword|cap}ly
• {keyword2|cap}
• Mein{keyword|cap}
• {keyword|cap}Hub
• {keyword2|cap}{keyword|cap}
• {keyword|cap}ify
• Hey{keyword|cap}
• {keyword|cap}Werk
• {keyword2|cap}App
• {keyword2|cap}io

SLOGANS
• {benefit|cap}.
• Gemacht für {audience}. In Minuten startklar.
• Der {keyword|cap}-Helfer, der arbeitet, während du arbeitest.
• Weniger Verwaltung. Mehr echte Arbeit.
• {keyword2|cap} aus Prinzip.

Bevor du dich entscheidest: Domain und Namen in den App-Stores prüfen, Marken recherchieren und den Namen fünf Leuten laut vorsagen.''',
  ),
  'colorPalette': ToolText(
    name: 'Farbpalette & Logo-Idee',
    description:
        'Eine Startpalette und eine Logo-Richtung je nach Markenstimmung.',
    options: {
      'Trustworthy': 'Vertrauenswürdig',
      'Bold': 'Kräftig',
      'Calm': 'Ruhig',
      'Playful': 'Verspielt',
      'Premium': 'Premium',
    },
    fields: {
      'company': FieldText('Name des Startups'),
      'mood': FieldText('Markenstimmung'),
    },
    templates: {
      'Trustworthy': r'''PALETTE: VERTRAUENSWÜRDIG ({company})
Primär     #1F4FD8  tiefes Blau
Sekundär   #14B8A6  Petrol
Akzent     #F59E0B  Bernstein, für Handlungsaufforderungen
Neutral    #0F172A / #F8FAFC
Blau für Überschriften und Buttons, Bernstein nur für die eine Aktion, die zählt.

LOGO-IDEE
Eine schlichte Wortmarke „{company}“ in einer geometrischen Grotesk, mit einem kleinen Häkchen oder Schild im ersten Buchstaben.''',
      'Bold': r'''PALETTE: KRÄFTIG ({company})
Primär     #E11D48  Karmesin
Sekundär   #111827  fast Schwarz
Akzent     #FACC15  Gelb
Neutral    #F9FAFB
Hoher Kontrast; große Flächen schwarz oder weiß halten, damit das Rot laut bleibt.

LOGO-IDEE
Fette, schmale Wortmarke „{company|upper}“, ein Buchstabe diagonal angeschnitten.''',
      'Calm': r'''PALETTE: RUHIG ({company})
Primär     #4F8A8B  Salbeigrün
Sekundär   #A7C4BC  Nebel
Akzent     #F4A261  sanftes Orange
Neutral    #FBFAF7 / #2B2D42
Viel Weißraum, runde Formen.

LOGO-IDEE
„{company|lower}“ in Kleinbuchstaben in einer runden Grotesk, mit einem weichen Kreis oder Blatt.''',
      'Playful': r'''PALETTE: VERSPIELT ({company})
Primär     #7C3AED  Violett
Sekundär   #22D3EE  Cyan
Akzent     #FB7185  Koralle
Neutral    #FFFFFF / #1E1B4B
Farben in Illustrationen frei mischen; Text dunkel auf hellem Grund halten.

LOGO-IDEE
Ein freundliches Maskottchen oder eine Blob-Form neben „{company}“ in einer runden, leicht hüpfenden Schrift.''',
      'Premium': r'''PALETTE: PREMIUM ({company})
Primär     #0B1020  Mitternacht
Sekundär   #C9A227  mattes Gold
Akzent     #E5E7EB  Silber
Neutral    #FAFAF9
Gold sparsam einsetzen: Linien, Icons, ein Highlight pro Screen.

LOGO-IDEE
Gesperrte Versalien „{company|upper}“ in einer kontrastreichen Serifenschrift, oder ein Monogramm des ersten Buchstabens in einem feinen Rahmen.''',
    },
  ),
  'contentCalendar': ToolText(
    name: 'Redaktionskalender',
    description: 'Beiträge von der Idee bis zur Veröffentlichung planen.',
    itemLabel: 'Beitrag',
    stages: {
      'Idea': 'Idee',
      'Drafting': 'Entwurf',
      'Scheduled': 'Geplant',
      'Published': 'Veröffentlicht',
    },
    fields: {
      'channel': FieldText('Kanal'),
      'date': FieldText('Datum', example: 'Mo'),
    },
    samples: [
      SampleText('5 Steuerabzüge, die Freelancer vergessen', {
        'date': '22. Okt.',
      }),
      SampleText('Hinter den Kulissen: Bankabgleich', {'date': '24. Okt.'}),
      SampleText('Erinnerung an die Steuerfrist im Quartal', {
        'date': '10. Jan.',
      }),
    ],
  ),
  'landingPage': ToolText(
    name: 'Landingpage-Texte',
    description: 'Hero, Vorteile, Social Proof und Call to Action.',
    fields: {
      'company': FieldText('Produktname'),
      'audience': FieldText('Zielgruppe', example: 'Freelancer'),
      'outcome': FieldText(
        'Wichtigstes Ergebnis',
        example: 'Buchhaltung, die sich selbst erledigt',
      ),
      'problem': FieldText(
        'Problem',
        example:
            'Du bist Freelancer geworden, um großartige Arbeit zu machen, nicht um Belegen hinterherzujagen.',
      ),
      'features': FieldText(
        'Die 3 wichtigsten Funktionen',
        example:
            'Der Bankabgleich sortiert jede Ausgabe\nSteuerschätzung pro Quartal, immer aktuell\nBelege in einer Sekunde fotografieren',
      ),
      'proof': FieldText(
        'Social Proof',
        example: '1.200 Freelancer vertrauen uns',
      ),
      'cta': FieldText('Call to Action', example: 'Kostenlos starten'),
    },
    template: r'''HERO
{outcome}.
{company} ist gemacht für {audience}.
→ {cta}

PROBLEM
{problem}

SO HILFT {company|upper}
{features|bullets}

SOCIAL PROOF
{proof}

FAQ
• Wie lange dauert die Einrichtung? Etwa zwei Minuten.
• Kann ich jederzeit kündigen? Ja, mit einem Tippen.
• Sind meine Daten sicher? Verschlüsselung auf Bankniveau, und wir verkaufen nie Daten.

LETZTER CALL TO ACTION
Bereit, deine Zeit zurückzubekommen? → {cta}''',
  ),
  'emailTemplates': ToolText(
    name: 'E-Mail-Vorlagen',
    description: 'Kaltakquise, Nachfassen, Investoren-Update, Dankeschön.',
    options: {
      'Cold outreach': 'Kaltakquise',
      'Follow-up': 'Nachfassen',
      'Investor update': 'Investoren-Update',
      'Thank you': 'Dankeschön',
    },
    fields: {
      'type': FieldText('Art der E-Mail'),
      'recipient': FieldText('Vorname der Empfängerin / des Empfängers'),
      'sender': FieldText('Dein Name'),
      'company': FieldText('Name des Startups'),
      'oneLiner': FieldText(
        'Beschreibung in einem Satz',
        example: 'Buchhaltung, die sich selbst erledigt, für Freelancer',
      ),
      'hook': FieldText(
        'Persönlicher Aufhänger',
        example: 'Dein Vortrag über Solo-Gründer auf der SaaStr',
      ),
      'traction': FieldText(
        'Traktion',
        example: r'3,5 Tsd. $ MRR, diesen Monat +18 %',
      ),
      'ask': FieldText(
        'Bitte',
        example: 'ein 20-minütiges Gespräch nächste Woche',
      ),
    },
    templates: {
      'Cold outreach': r'''Betreff: Kurze Frage, {recipient}

Hallo {recipient},

{hook} hat mir sehr gefallen. Ich bin {sender}, Gründerin von {company}: {oneLiner}.

Wir stehen bei {traction}, und ich glaube, du hättest einen klaren Blick darauf, wohin es als Nächstes geht.

Hättest du Lust auf {ask}?

Danke,
{sender}''',
      'Follow-up': r'''Betreff: AW: Kurze Frage, {recipient}

Hallo {recipient},

ich hole das hier noch einmal nach oben, falls es untergegangen ist. Seit meiner letzten Nachricht: {traction}.

Ich würde mich weiterhin sehr über {ask} freuen. Wenn es gerade nicht passt, sag einfach Bescheid, dann melde ich mich nächstes Quartal wieder.

Viele Grüße,
{sender}''',
      'Investor update': r'''Betreff: {company}-Update: {traction}

Hallo {recipient},

Highlights
• {traction}

Lowlights
• Was diesen Monat nicht funktioniert hat und was wir gelernt haben.

Bitten
• {ask}

Danke für die Unterstützung,
{sender}''',
      'Thank you': r'''Betreff: Danke, {recipient}

Hallo {recipient},

danke, dass du dir heute Zeit genommen hast. Dein Gedanke zu diesem Punkt war besonders hilfreich: {hook}.

Wie versprochen melde ich mich bis Freitag mit den nächsten Schritten.

Viele Grüße,
{sender}
{company}''',
    },
  ),
  'seoKeywords': ToolText(
    name: 'SEO-Keyword-Ideen',
    description: 'Suchbegriffe, die deine Kunden eintippen.',
    fields: {
      'topic': FieldText('Thema', example: 'Buchhaltung'),
      'audience': FieldText('Zielgruppe', example: 'Freelancer'),
      'alternative': FieldText(
        'Bekannter Wettbewerber oder Alternative',
        example: 'Excel',
      ),
      'location': FieldText('Ort', example: 'Deutschland'),
    },
    template: r'''HOHE KAUFABSICHT (bereit zu kaufen)
• beste {topic} App für {audience}
• {topic} Software für {audience}
• {topic} Tool Preise
• {alternative} Alternative für {topic}

PROBLEM (suchen Hilfe)
• {topic} als Freelancer selbst machen
• {topic} Tipps für {audience}
• {topic} Fehler vermeiden
• {topic} Checkliste für {audience}

LOKAL
• {topic} für {audience} in {location}
• {topic} Regeln {location} {audience}

LONG-TAIL-BLOGIDEEN
• {topic|cap} für {audience}: ein Leitfaden für Einsteiger
• {alternative|cap} oder {topic}-Apps: was ist besser?
• Wie viel Zeit kostet die {topic} jeden Monat?

Als Nächstes: Suchvolumen und Schwierigkeit in einem Keyword-Tool prüfen, dann eine Seite pro Begriff mit hoher Kaufabsicht schreiben.''',
  ),
};
