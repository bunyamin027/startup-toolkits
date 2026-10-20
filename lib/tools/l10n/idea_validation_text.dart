import 'tool_text.dart';

/// Idea & validation tools (`catalog/idea_validation.dart`) per language.
const ideaValidationText = <String, Map<String, ToolText>>{
  'tr': _tr,
  'fr': _fr,
  'es': _es,
  'de': _de,
};

const _tr = <String, ToolText>{
  'leanCanvas': ToolText(
    name: 'Lean Canvas',
    description: 'İş modeliniz tek sayfada.',
    fields: {
      'company': FieldText('Girişim adı'),
      'problem': FieldText(
        'Problem',
        example:
            'Serbest çalışanlar ayda 5+ saatini muhasebeye harcıyor.\n'
            'Vergi indirimlerini kaçırıyorlar.\n'
            'Üç aylık vergi tahminleri tahminden öteye geçmiyor.',
      ),
      'solution': FieldText(
        'Çözüm',
        example:
            'Otomatik gider kategorili banka senkronizasyonu.\n'
            'Tek ekranda üç aylık vergi tahmini.\n'
            'Fotoğrafla fiş kaydı.',
      ),
      'uvp': FieldText(
        'Benzersiz değer önerisi',
        example:
            'Kendi kendini yapan muhasebe; serbest çalışanlar kazandıklarının daha fazlasını cebinde tutar.',
      ),
      'segment': FieldText(
        'Müşteri segmenti',
        example: 'Türkiye’deki serbest tasarımcılar ve yazılımcılar',
      ),
      'channels': FieldText(
        'Kanallar',
        example:
            'Serbest çalışan toplulukları\nYouTube eğitimleri\nMali müşavir tavsiyeleri',
      ),
      'revenue': FieldText(
        'Gelir akışları',
        example: r'Abonelik: aylık $12 veya yıllık $99',
      ),
      'costs': FieldText(
        'Maliyet yapısı',
        example: 'Banka veri API’si\nBulut barındırma\nÜcretli müşteri edinimi',
      ),
      'metrics': FieldText(
        'Temel metrikler',
        example:
            'Haftalık aktif kullanıcı\nDenemeden ücretliye dönüşüm\nAylık kayıp oranı',
      ),
      'advantage': FieldText(
        'Haksız avantaj',
        example:
            'Kurucu ekipte 8 yıl vergi yazılımı geliştirmiş bir mali müşavir var.',
      ),
    },
    template: r'''LEAN CANVAS: {company}

1. PROBLEM
{problem|bullets}

2. MÜŞTERİ SEGMENTİ
{segment}

3. BENZERSİZ DEĞER ÖNERİSİ
{uvp}

4. ÇÖZÜM
{solution|bullets}

5. KANALLAR
{channels|bullets}

6. GELİR AKIŞLARI
{revenue|bullets}

7. MALİYET YAPISI
{costs|bullets}

8. TEMEL METRİKLER
{metrics|bullets}

9. HAKSIZ AVANTAJ
{advantage}''',
  ),
  'swot': ToolText(
    name: 'SWOT analizi',
    description: 'Güçlü yönler, zayıf yönler, fırsatlar ve tehditler.',
    fields: {
      'company': FieldText('Girişim adı'),
      'strengths': FieldText(
        'Güçlü yönler',
        example: 'Ekipte vergi uzmanlığı\nSade, odaklı ürün\nDüşük fiyat',
      ),
      'weaknesses': FieldText(
        'Zayıf yönler',
        example:
            'Küçük pazarlama bütçesi\nYalnızca tek pazar\nHenüz mobil uygulama yok',
      ),
      'opportunities': FieldText(
        'Fırsatlar',
        example:
            'Serbest çalışan sayısı artmaya devam ediyor\nMali müşavirler sade araçlar önermek istiyor\nYeni e-fatura kuralları',
      ),
      'threats': FieldText(
        'Tehditler',
        example:
            'Büyük muhasebe paketleri serbest çalışan planları ekliyor\nBanka API fiyat artışları',
      ),
    },
    template: r'''SWOT ANALİZİ: {company}

GÜÇLÜ YÖNLER (iç, yararlı)
{strengths|bullets}

ZAYIF YÖNLER (iç, zararlı)
{weaknesses|bullets}

FIRSATLAR (dış, yararlı)
{opportunities|bullets}

TEHDİTLER (dış, zararlı)
{threats|bullets}

SONRAKİ ADIMLAR
• Güçlü yönleri şu fırsat için kullanın: {opportunities|first}…
• Büyümeyi en çok engelleyen zayıflığı giderin.
• En büyük tehdit gelmeden ona karşı bir plan yapın.''',
  ),
  'competitors': ToolText(
    name: 'Rakip takibi',
    description: 'Bu problemi başka kim, nasıl çözüyor.',
    itemLabel: 'Rakip',
    stages: {'Direct': 'Doğrudan', 'Indirect': 'Dolaylı', 'Watch': 'İzlenen'},
    fields: {
      'price': FieldText('Fiyat', example: r'$15/ay'),
      'strength': FieldText('Güçlü yönü', example: 'Marka'),
      'weakness': FieldText('Zayıf yönü', example: 'Karmaşık'),
    },
    samples: [
      SampleText('LedgerPro', {
        'price': r'$25/ay',
        'strength': 'Eksiksiz muhasebe paketi',
        'weakness': 'Tek başına çalışanlar için fazla karmaşık',
      }),
      SampleText('Tablolar', {
        'price': 'Ücretsiz',
        'strength': 'Esnek, zaten biliniyor',
        'weakness': 'Elle yapılıyor, hataya açık',
      }),
      SampleText('TaxBot', {
        'price': r'$8/ay',
        'strength': 'Ucuz',
        'weakness': 'Banka senkronizasyonu yok',
      }),
    ],
  ),
  'persona': ToolText(
    name: 'Persona oluşturucu',
    description: 'Ürün geliştirdiğiniz müşterinin net bir resmi.',
    fields: {
      'name': FieldText('Persona adı', example: 'Tasarımcı Defne'),
      'role': FieldText('Rol', example: 'Serbest arayüz tasarımcısı'),
      'age': FieldText('Yaş'),
      'location': FieldText('Konum', example: 'İzmir'),
      'goals': FieldText(
        'Hedefler',
        example:
            'Gelirini iki katına çıkarmak\nZamanını evrak işine değil tasarıma ayırmak',
      ),
      'pains': FieldText(
        'En büyük problem',
        example:
            'Muhasebeden nefret ediyor ve geciken vergi ödemeleri için ceza ödüyor',
      ),
      'tools': FieldText(
        'Bugün kullandığı araçlar',
        example: 'Figma\nNotion\nGiderler için bir tablo',
      ),
      'quote': FieldText(
        'Alıntı',
        example:
            'Serbest çalışmaya muhasebe yapmak için değil, tasarım yapmak için başladım.',
      ),
      'channels': FieldText(
        'Onlara nereden ulaşılır',
        example:
            'Dribbble\nTasarım toplulukları\nSerbest çalışan Slack grupları',
      ),
    },
    template: r'''PERSONA: {name}

{role}, {age}, {location}

"{quote}"

HEDEFLER
{goals|bullets}

SIKINTILAR
{pains|bullets}

MEVCUT ARAÇLAR
{tools|bullets}

ONLARA NEREDEN ULAŞILIR
{channels|bullets}

Nasıl yardım ediyoruz: {name|first} ilk haftada ne kadar zaman ve para kazandığını görsün.''',
  ),
  'interviewQuestions': ToolText(
    name: 'Görüşme ve anket soruları',
    description:
        'Yönlendirici sorulardan kaçınan müşteri görüşmesi senaryoları.',
    options: {
      'Problem discovery': 'Problem keşfi',
      'Solution validation': 'Çözüm doğrulama',
      'Pricing': 'Fiyatlandırma',
    },
    fields: {
      'stage': FieldText('Görüşme türü'),
      'segment': FieldText('Hedef müşteri', example: 'Serbest tasarımcılar'),
      'problemArea': FieldText(
        'Problem alanı',
        example: 'muhasebe ve vergiler',
      ),
      'product': FieldText('Ürün adı'),
    },
    templates: {
      'Problem discovery': r'''PROBLEM KEŞFİ GÖRÜŞMESİ
Hedef kitle: {segment}

Isınma
1. Bana işinizden bahseder misiniz? Tipik bir haftanız nasıl geçiyor?
2. Ne zamandır bu işi yapıyorsunuz?

Problem
3. Bu konuyla en son uğraştığınız zamanı adım adım anlatır mısınız: {problemArea}?
4. En zor kısmı neydi?
5. Bu ne sıklıkla oluyor?
6. Bugün bunun için ne yapıyorsunuz? Hangi araçlar ya da kişiler yardımcı oluyor?
7. Size zaman ya da para olarak maliyeti ne?
8. Başka bir yolla çözmeyi denediniz mi? Neden bıraktınız?

Kapanış
9. Sihirli bir değneğiniz olsaydı ne değişirdi?
10. Bu konuda başka kiminle konuşmalıyım?

İpuçları: geleceğe dair fikirleri değil, geçmişteki davranışları sorun. Ürününüzü anlatmayın.''',
      'Solution validation': r'''ÇÖZÜM DOĞRULAMA GÖRÜŞMESİ
Hedef kitle: {segment}
Ürün: {product}

1. Bugün bu konuyu nasıl yönettiğinizi tekrar anlatır mısınız: {problemArea}?
2. (Prototipi gösterin.) Sizce bu ne yapıyor?
3. Bu görevi tamamlamayı deneyin. İlerlerken sesli düşünün.
4. Ne kafa karıştırıcı ya da yavaştı?
5. Bugün kullandığınız şeyin yerini alması için ne eksik?
6. En çok hangi kısmı kullanırdınız?
7. {product} yarın ortadan kalksa ne hissederdiniz?
8. İlk beta grubumuzda yer almak ister misiniz?

İpuçları: sessizliğe izin verin. Yalnızca söylediklerine değil, yaptıklarına bakın.''',
      'Pricing': r'''FİYATLANDIRMA GÖRÜŞMESİ (Van Westendorp)
Hedef kitle: {segment}
Ürün: {product}

1. {product} aylık hangi fiyatta kalitesinden şüphe edeceğiniz kadar ucuz olurdu?
2. Hangi fiyatta kaçırılmayacak bir fırsat, parasına değer bir alım olur?
3. Hangi fiyatta pahalı gelmeye başlar ama yine de düşünürsünüz?
4. Hangi fiyatta düşünülemeyecek kadar pahalı olur?
5. Bugün bu alanla ilgili araçlara ne ödüyorsunuz: {problemArea}?
6. Bu satın almayı kim onaylıyor?
7. Aylık mı yıllık mı faturalandırmayı tercih edersiniz? Neden?

İpucu: kabul edilebilir fiyat aralığını bulmak için 1–4 arası cevapları grafiğe dökün.''',
    },
  ),
  'ideaScore': ToolText(
    name: 'Fikir puanlama matrisi',
    description: 'Geliştirmeden önce bir fikri altı ölçüte göre puanlayın.',
    fields: {
      'problemPain': FieldText(
        'Problemin acısı',
        hint: 'Bugün ne kadar canını yakıyor',
      ),
      'marketSize': FieldText('Pazar büyüklüğü'),
      'willingnessToPay': FieldText('Ödeme isteği'),
      'competition': FieldText(
        'Rekabete karşı alan',
        hint: '5 = az sayıda güçlü rakip',
      ),
      'feasibility': FieldText(
        'Yapılabilirlik',
        hint: 'Ekibiniz bunu geliştirebilir mi?',
      ),
      'founderFit': FieldText('Kurucu uyumu'),
    },
  ),
};

const _fr = <String, ToolText>{
  'leanCanvas': ToolText(
    name: 'Lean Canvas',
    description: 'Votre modèle économique sur une page.',
    fields: {
      'company': FieldText('Nom de la startup'),
      'problem': FieldText(
        'Problème',
        example:
            'Les freelances perdent plus de 5 heures par mois en comptabilité.\n'
            'Ils passent à côté de déductions fiscales.\n'
            'Les estimations d’impôt trimestrielles sont approximatives.',
      ),
      'solution': FieldText(
        'Solution',
        example:
            'Synchronisation bancaire avec catégories de dépenses automatiques.\n'
            'Estimation d’impôt trimestrielle sur un seul écran.\n'
            'Capture des reçus en photo.',
      ),
      'uvp': FieldText(
        'Proposition de valeur unique',
        example:
            'Une comptabilité qui se fait toute seule, pour que les freelances gardent davantage de ce qu’ils gagnent.',
      ),
      'segment': FieldText(
        'Segment de clientèle',
        example: 'Designers et développeurs freelances en France',
      ),
      'channels': FieldText(
        'Canaux',
        example:
            'Communautés de freelances\nTutoriels YouTube\nRecommandations d’experts-comptables',
      ),
      'revenue': FieldText(
        'Sources de revenus',
        example: r'Abonnement : 12 $/mois ou 99 $/an',
      ),
      'costs': FieldText(
        'Structure de coûts',
        example:
            'API de données bancaires\nHébergement cloud\nAcquisition payante',
      ),
      'metrics': FieldText(
        'Indicateurs clés',
        example:
            'Utilisateurs actifs hebdomadaires\nConversion essai → payant\nChurn mensuel',
      ),
      'advantage': FieldText(
        'Avantage déloyal',
        example:
            'L’équipe fondatrice compte un expert-comptable qui a conçu des logiciels fiscaux pendant 8 ans.',
      ),
    },
    template: r'''LEAN CANVAS : {company}

1. PROBLÈME
{problem|bullets}

2. SEGMENT DE CLIENTÈLE
{segment}

3. PROPOSITION DE VALEUR UNIQUE
{uvp}

4. SOLUTION
{solution|bullets}

5. CANAUX
{channels|bullets}

6. SOURCES DE REVENUS
{revenue|bullets}

7. STRUCTURE DE COÛTS
{costs|bullets}

8. INDICATEURS CLÉS
{metrics|bullets}

9. AVANTAGE DÉLOYAL
{advantage}''',
  ),
  'swot': ToolText(
    name: 'Analyse SWOT',
    description: 'Forces, faiblesses, opportunités et menaces.',
    fields: {
      'company': FieldText('Nom de la startup'),
      'strengths': FieldText(
        'Forces',
        example:
            'Expertise fiscale dans l’équipe\nProduit simple et ciblé\nPrix bas',
      ),
      'weaknesses': FieldText(
        'Faiblesses',
        example:
            'Petit budget marketing\nUn seul marché\nPas encore d’app mobile',
      ),
      'opportunities': FieldText(
        'Opportunités',
        example:
            'Le nombre de freelances ne cesse de croître\nLes experts-comptables veulent recommander des outils simples\nNouvelles règles de facturation électronique',
      ),
      'threats': FieldText(
        'Menaces',
        example:
            'Les grandes suites comptables ajoutent des offres pour freelances\nHausse des prix des API bancaires',
      ),
    },
    template: r'''ANALYSE SWOT : {company}

FORCES (internes, favorables)
{strengths|bullets}

FAIBLESSES (internes, défavorables)
{weaknesses|bullets}

OPPORTUNITÉS (externes, favorables)
{opportunities|bullets}

MENACES (externes, défavorables)
{threats|bullets}

PROCHAINES ÉTAPES
• Utiliser les forces pour saisir : {opportunities|first}…
• Corriger la faiblesse qui freine le plus la croissance.
• Préparer une réponse à la plus grande menace avant qu’elle n’arrive.''',
  ),
  'competitors': ToolText(
    name: 'Suivi des concurrents',
    description: 'Qui d’autre résout ce problème, et comment.',
    itemLabel: 'Concurrent',
    stages: {
      'Direct': 'Direct',
      'Indirect': 'Indirect',
      'Watch': 'À surveiller',
    },
    fields: {
      'price': FieldText('Prix', example: r'15 $/mois'),
      'strength': FieldText('Force', example: 'Marque'),
      'weakness': FieldText('Faiblesse', example: 'Complexe'),
    },
    samples: [
      SampleText('LedgerPro', {
        'price': r'25 $/mois',
        'strength': 'Suite comptable complète',
        'weakness': 'Trop complexe pour les freelances solo',
      }),
      SampleText('Tableurs', {
        'price': 'Gratuit',
        'strength': 'Flexible, déjà connu',
        'weakness': 'Manuel, source d’erreurs',
      }),
      SampleText('TaxBot', {
        'price': r'8 $/mois',
        'strength': 'Bon marché',
        'weakness': 'Pas de synchronisation bancaire',
      }),
    ],
  ),
  'persona': ToolText(
    name: 'Créateur de persona',
    description: 'Un portrait clair du client pour qui vous construisez.',
    fields: {
      'name': FieldText('Nom du persona', example: 'Delphine la designer'),
      'role': FieldText('Rôle', example: 'Designer UI freelance'),
      'age': FieldText('Âge'),
      'location': FieldText('Lieu', example: 'Lyon'),
      'goals': FieldText(
        'Objectifs',
        example:
            'Doubler ses revenus\nPasser son temps sur le design, pas sur l’administratif',
      ),
      'pains': FieldText(
        'Plus gros problème',
        example:
            'Déteste la comptabilité et paie des pénalités pour ses acomptes d’impôt en retard',
      ),
      'tools': FieldText(
        'Outils utilisés aujourd’hui',
        example: 'Figma\nNotion\nUn tableur pour les dépenses',
      ),
      'quote': FieldText(
        'Citation',
        example:
            'Je suis devenue freelance pour faire du design, pas de la comptabilité.',
      ),
      'channels': FieldText(
        'Où les toucher',
        example: 'Dribbble\nCommunautés design\nGroupes Slack de freelances',
      ),
    },
    template: r'''PERSONA : {name}

{role}, {age} ans, {location}

« {quote} »

OBJECTIFS
{goals|bullets}

DIFFICULTÉS
{pains|bullets}

OUTILS ACTUELS
{tools|bullets}

OÙ LES TOUCHER
{channels|bullets}

Comment nous aidons : montrer à {name|first} combien de temps et d’argent elle récupère dès la première semaine.''',
  ),
  'interviewQuestions': ToolText(
    name: 'Questions d’entretien et d’enquête',
    description: 'Des guides d’entretien client sans questions orientées.',
    options: {
      'Problem discovery': 'Découverte du problème',
      'Solution validation': 'Validation de la solution',
      'Pricing': 'Prix',
    },
    fields: {
      'stage': FieldText('Type d’entretien'),
      'segment': FieldText('Client cible', example: 'Designers freelances'),
      'problemArea': FieldText(
        'Domaine du problème',
        example: 'la comptabilité et les impôts',
      ),
      'product': FieldText('Nom du produit'),
    },
    templates: {
      'Problem discovery': r'''ENTRETIEN DE DÉCOUVERTE DU PROBLÈME
Public : {segment}

Mise en route
1. Parlez-moi de votre travail. À quoi ressemble une semaine type ?
2. Depuis combien de temps faites-vous cela ?

Le problème
3. Racontez-moi la dernière fois que vous avez dû gérer {problemArea}.
4. Quelle a été la partie la plus difficile ?
5. À quelle fréquence cela arrive-t-il ?
6. Que faites-vous aujourd’hui pour y remédier ? Quels outils ou quelles personnes vous aident ?
7. Combien cela vous coûte-t-il, en temps ou en argent ?
8. Avez-vous essayé de le résoudre autrement ? Pourquoi avez-vous arrêté ?

Conclusion
9. Si vous aviez une baguette magique, que changeriez-vous ?
10. À qui d’autre devrais-je en parler ?

Conseils : interrogez sur les comportements passés, pas sur des opinions futures. Ne vendez pas.''',
      'Solution validation': r'''ENTRETIEN DE VALIDATION DE LA SOLUTION
Public : {segment}
Produit : {product}

1. Rappelez-moi comment vous gérez aujourd’hui {problemArea}.
2. (Montrez le prototype.) À votre avis, que fait ceci ?
3. Essayez de réaliser cette tâche. Pensez à voix haute.
4. Qu’est-ce qui était déroutant ou lent ?
5. Que manque-t-il pour remplacer ce que vous utilisez aujourd’hui ?
6. Quelle partie utiliseriez-vous le plus ?
7. Si {product} disparaissait demain, que ressentiriez-vous ?
8. Aimeriez-vous faire partie de notre premier groupe bêta ?

Conseils : laissez place au silence. Observez ce qu’ils font, pas seulement ce qu’ils disent.''',
      'Pricing': r'''ENTRETIEN SUR LE PRIX (Van Westendorp)
Public : {segment}
Produit : {product}

1. À quel prix mensuel {product} serait-il si bon marché que vous douteriez de sa qualité ?
2. À quel prix serait-ce une bonne affaire, un excellent rapport qualité-prix ?
3. À quel prix commence-t-il à sembler cher, tout en restant envisageable ?
4. À quel prix est-il trop cher pour être envisagé ?
5. Combien payez-vous aujourd’hui pour des outils liés à {problemArea} ?
6. Qui valide cet achat ?
7. Préférez-vous une facturation mensuelle ou annuelle ? Pourquoi ?

Conseil : reportez les réponses 1 à 4 sur un graphique pour trouver la fourchette de prix acceptable.''',
    },
  ),
  'ideaScore': ToolText(
    name: 'Matrice de notation d’idée',
    description: 'Notez une idée sur six critères avant de construire.',
    fields: {
      'problemPain': FieldText(
        'Douleur du problème',
        hint: 'À quel point il fait mal aujourd’hui',
      ),
      'marketSize': FieldText('Taille du marché'),
      'willingnessToPay': FieldText('Disposition à payer'),
      'competition': FieldText(
        'Espace face à la concurrence',
        hint: '5 = peu de rivaux solides',
      ),
      'feasibility': FieldText(
        'Faisabilité',
        hint: 'Votre équipe peut-elle le construire ?',
      ),
      'founderFit': FieldText('Adéquation fondateur'),
    },
  ),
};

const _es = <String, ToolText>{
  'leanCanvas': ToolText(
    name: 'Lean Canvas',
    description: 'Tu modelo de negocio en una página.',
    fields: {
      'company': FieldText('Nombre de la startup'),
      'problem': FieldText(
        'Problema',
        example:
            'Los freelancers pierden más de 5 horas al mes en contabilidad.\n'
            'Se les escapan deducciones fiscales.\n'
            'Las estimaciones trimestrales de impuestos son a ojo.',
      ),
      'solution': FieldText(
        'Solución',
        example:
            'Sincronización bancaria con categorías de gasto automáticas.\n'
            'Estimación trimestral de impuestos en una sola pantalla.\n'
            'Captura de recibos con una foto.',
      ),
      'uvp': FieldText(
        'Propuesta de valor única',
        example:
            'Contabilidad que se hace sola, para que los freelancers se queden con más de lo que ganan.',
      ),
      'segment': FieldText(
        'Segmento de clientes',
        example: 'Diseñadores y desarrolladores freelance en España',
      ),
      'channels': FieldText(
        'Canales',
        example:
            'Comunidades de freelancers\nTutoriales en YouTube\nRecomendaciones de gestores',
      ),
      'revenue': FieldText(
        'Fuentes de ingresos',
        example: r'Suscripción: 12 $/mes o 99 $/año',
      ),
      'costs': FieldText(
        'Estructura de costes',
        example:
            'API de datos bancarios\nAlojamiento en la nube\nAdquisición de pago',
      ),
      'metrics': FieldText(
        'Métricas clave',
        example:
            'Usuarios activos semanales\nConversión de prueba a pago\nChurn mensual',
      ),
      'advantage': FieldText(
        'Ventaja injusta',
        example:
            'El equipo fundador incluye a un asesor fiscal que creó software de impuestos durante 8 años.',
      ),
    },
    template: r'''LEAN CANVAS: {company}

1. PROBLEMA
{problem|bullets}

2. SEGMENTO DE CLIENTES
{segment}

3. PROPUESTA DE VALOR ÚNICA
{uvp}

4. SOLUCIÓN
{solution|bullets}

5. CANALES
{channels|bullets}

6. FUENTES DE INGRESOS
{revenue|bullets}

7. ESTRUCTURA DE COSTES
{costs|bullets}

8. MÉTRICAS CLAVE
{metrics|bullets}

9. VENTAJA INJUSTA
{advantage}''',
  ),
  'swot': ToolText(
    name: 'Análisis DAFO',
    description: 'Fortalezas, debilidades, oportunidades y amenazas.',
    fields: {
      'company': FieldText('Nombre de la startup'),
      'strengths': FieldText(
        'Fortalezas',
        example:
            'Experiencia fiscal en el equipo\nProducto sencillo y enfocado\nPrecio bajo',
      ),
      'weaknesses': FieldText(
        'Debilidades',
        example:
            'Presupuesto de marketing pequeño\nUn solo mercado\nAún sin app móvil',
      ),
      'opportunities': FieldText(
        'Oportunidades',
        example:
            'El número de freelancers sigue creciendo\nLos gestores quieren recomendar herramientas sencillas\nNuevas normas de facturación electrónica',
      ),
      'threats': FieldText(
        'Amenazas',
        example:
            'Las grandes suites contables añaden planes para freelancers\nSubidas de precio de las API bancarias',
      ),
    },
    template: r'''ANÁLISIS DAFO: {company}

FORTALEZAS (internas, a favor)
{strengths|bullets}

DEBILIDADES (internas, en contra)
{weaknesses|bullets}

OPORTUNIDADES (externas, a favor)
{opportunities|bullets}

AMENAZAS (externas, en contra)
{threats|bullets}

PRÓXIMOS PASOS
• Usa las fortalezas para aprovechar: {opportunities|first}…
• Corrige la debilidad que más frena el crecimiento.
• Prepara una respuesta a la mayor amenaza antes de que llegue.''',
  ),
  'competitors': ToolText(
    name: 'Seguimiento de competidores',
    description: 'Quién más resuelve este problema y cómo.',
    itemLabel: 'Competidor',
    stages: {'Direct': 'Directo', 'Indirect': 'Indirecto', 'Watch': 'Vigilar'},
    fields: {
      'price': FieldText('Precio', example: r'15 $/mes'),
      'strength': FieldText('Fortaleza', example: 'Marca'),
      'weakness': FieldText('Debilidad', example: 'Complejo'),
    },
    samples: [
      SampleText('LedgerPro', {
        'price': r'25 $/mes',
        'strength': 'Suite contable completa',
        'weakness': 'Demasiado complejo para freelancers en solitario',
      }),
      SampleText('Hojas de cálculo', {
        'price': 'Gratis',
        'strength': 'Flexibles y ya conocidas',
        'weakness': 'Manuales y propensas a errores',
      }),
      SampleText('TaxBot', {
        'price': r'8 $/mes',
        'strength': 'Barato',
        'weakness': 'Sin sincronización bancaria',
      }),
    ],
  ),
  'persona': ToolText(
    name: 'Creador de buyer persona',
    description: 'Una imagen clara del cliente para el que construyes.',
    fields: {
      'name': FieldText('Nombre del persona', example: 'Diana la diseñadora'),
      'role': FieldText('Rol', example: 'Diseñadora UI freelance'),
      'age': FieldText('Edad'),
      'location': FieldText('Ubicación', example: 'Valencia'),
      'goals': FieldText(
        'Objetivos',
        example:
            'Duplicar sus ingresos\nDedicar su tiempo al diseño, no al papeleo',
      ),
      'pains': FieldText(
        'Mayor problema',
        example:
            'Odia la contabilidad y paga recargos por presentar tarde los impuestos',
      ),
      'tools': FieldText(
        'Herramientas que usa hoy',
        example: 'Figma\nNotion\nUna hoja de cálculo para los gastos',
      ),
      'quote': FieldText(
        'Cita',
        example:
            'Me hice freelance para diseñar, no para llevar la contabilidad.',
      ),
      'channels': FieldText(
        'Dónde encontrarlos',
        example:
            'Dribbble\nComunidades de diseño\nGrupos de Slack de freelancers',
      ),
    },
    template: r'''BUYER PERSONA: {name}

{role}, {age} años, {location}

«{quote}»

OBJETIVOS
{goals|bullets}

PROBLEMAS
{pains|bullets}

HERRAMIENTAS ACTUALES
{tools|bullets}

DÓNDE ENCONTRARLOS
{channels|bullets}

Cómo ayudamos: mostrar a {name|first} cuánto tiempo y dinero recupera en la primera semana.''',
  ),
  'interviewQuestions': ToolText(
    name: 'Preguntas de entrevista y encuesta',
    description: 'Guiones de entrevista con clientes sin preguntas sesgadas.',
    options: {
      'Problem discovery': 'Descubrir el problema',
      'Solution validation': 'Validar la solución',
      'Pricing': 'Precios',
    },
    fields: {
      'stage': FieldText('Tipo de entrevista'),
      'segment': FieldText(
        'Cliente objetivo',
        example: 'Diseñadores freelance',
      ),
      'problemArea': FieldText(
        'Área del problema',
        example: 'la contabilidad y los impuestos',
      ),
      'product': FieldText('Nombre del producto'),
    },
    templates: {
      'Problem discovery': r'''ENTREVISTA PARA DESCUBRIR EL PROBLEMA
Público: {segment}

Para empezar
1. Háblame de tu trabajo. ¿Cómo es una semana normal?
2. ¿Cuánto tiempo llevas haciéndolo?

El problema
3. Cuéntame paso a paso la última vez que tuviste que lidiar con {problemArea}.
4. ¿Qué fue lo más difícil?
5. ¿Con qué frecuencia ocurre?
6. ¿Qué haces hoy al respecto? ¿Qué herramientas o personas te ayudan?
7. ¿Cuánto te cuesta, en tiempo o en dinero?
8. ¿Has intentado resolverlo de otra forma? ¿Por qué lo dejaste?

Cierre
9. Si tuvieras una varita mágica, ¿qué cambiarías?
10. ¿Con quién más debería hablar de esto?

Consejos: pregunta por comportamientos pasados, no por opiniones sobre el futuro. No vendas.''',
      'Solution validation': r'''ENTREVISTA PARA VALIDAR LA SOLUCIÓN
Público: {segment}
Producto: {product}

1. Recuérdame cómo gestionas hoy {problemArea}.
2. (Muestra el prototipo.) ¿Qué crees que hace esto?
3. Intenta completar esta tarea. Piensa en voz alta mientras lo haces.
4. ¿Qué resultó confuso o lento?
5. ¿Qué falta para que sustituya a lo que usas hoy?
6. ¿Qué parte usarías más?
7. Si {product} desapareciera mañana, ¿cómo te sentirías?
8. ¿Te gustaría formar parte de nuestro primer grupo beta?

Consejos: deja que haya silencios. Observa lo que hacen, no solo lo que dicen.''',
      'Pricing': r'''ENTREVISTA DE PRECIOS (Van Westendorp)
Público: {segment}
Producto: {product}

1. ¿A qué precio mensual {product} sería tan barato que dudarías de su calidad?
2. ¿A qué precio sería una ganga, una gran compra por lo que cuesta?
3. ¿A qué precio empieza a parecer caro, aunque todavía lo considerarías?
4. ¿A qué precio es demasiado caro para considerarlo?
5. ¿Cuánto pagas hoy por herramientas relacionadas con {problemArea}?
6. ¿Quién aprueba esta compra?
7. ¿Prefieres facturación mensual o anual? ¿Por qué?

Consejo: representa las respuestas 1–4 en un gráfico para encontrar el rango de precio aceptable.''',
    },
  ),
  'ideaScore': ToolText(
    name: 'Matriz de puntuación de ideas',
    description: 'Puntúa una idea en seis criterios antes de construir.',
    fields: {
      'problemPain': FieldText('Dolor del problema', hint: 'Cuánto duele hoy'),
      'marketSize': FieldText('Tamaño de mercado'),
      'willingnessToPay': FieldText('Disposición a pagar'),
      'competition': FieldText(
        'Espacio frente a la competencia',
        hint: '5 = pocos rivales fuertes',
      ),
      'feasibility': FieldText(
        'Viabilidad',
        hint: '¿Puede tu equipo construirlo?',
      ),
      'founderFit': FieldText('Encaje del fundador'),
    },
  ),
};

const _de = <String, ToolText>{
  'leanCanvas': ToolText(
    name: 'Lean Canvas',
    description: 'Dein Geschäftsmodell auf einer Seite.',
    fields: {
      'company': FieldText('Name des Startups'),
      'problem': FieldText(
        'Problem',
        example:
            'Freelancer verlieren über 5 Stunden im Monat mit Buchhaltung.\n'
            'Sie verpassen Steuerabzüge.\n'
            'Quartalsweise Steuervorauszahlungen sind reines Raten.',
      ),
      'solution': FieldText(
        'Lösung',
        example:
            'Bankabgleich mit automatischen Ausgabenkategorien.\n'
            'Steuerschätzung pro Quartal auf einem Bildschirm.\n'
            'Belege per Foto erfassen.',
      ),
      'uvp': FieldText(
        'Alleinstellungsmerkmal',
        example:
            'Buchhaltung, die sich selbst erledigt, damit Freelancer mehr von ihrem Verdienst behalten.',
      ),
      'segment': FieldText(
        'Kundensegment',
        example: 'Freiberufliche Designer und Entwickler in Deutschland',
      ),
      'channels': FieldText(
        'Kanäle',
        example:
            'Freelancer-Communities\nYouTube-Tutorials\nEmpfehlungen von Steuerberatern',
      ),
      'revenue': FieldText(
        'Einnahmequellen',
        example: r'Abo: 12 $/Monat oder 99 $/Jahr',
      ),
      'costs': FieldText(
        'Kostenstruktur',
        example: 'Bankdaten-API\nCloud-Hosting\nBezahlte Kundengewinnung',
      ),
      'metrics': FieldText(
        'Kennzahlen',
        example:
            'Wöchentlich aktive Nutzer\nConversion vom Test zum Abo\nMonatlicher Churn',
      ),
      'advantage': FieldText(
        'Unfairer Vorteil',
        example:
            'Zum Gründerteam gehört ein Steuerberater, der 8 Jahre lang Steuersoftware entwickelt hat.',
      ),
    },
    template: r'''LEAN CANVAS: {company}

1. PROBLEM
{problem|bullets}

2. KUNDENSEGMENT
{segment}

3. ALLEINSTELLUNGSMERKMAL
{uvp}

4. LÖSUNG
{solution|bullets}

5. KANÄLE
{channels|bullets}

6. EINNAHMEQUELLEN
{revenue|bullets}

7. KOSTENSTRUKTUR
{costs|bullets}

8. KENNZAHLEN
{metrics|bullets}

9. UNFAIRER VORTEIL
{advantage}''',
  ),
  'swot': ToolText(
    name: 'SWOT-Analyse',
    description: 'Stärken, Schwächen, Chancen und Risiken.',
    fields: {
      'company': FieldText('Name des Startups'),
      'strengths': FieldText(
        'Stärken',
        example:
            'Steuerexpertise im Team\nEinfaches, fokussiertes Produkt\nNiedriger Preis',
      ),
      'weaknesses': FieldText(
        'Schwächen',
        example:
            'Kleines Marketingbudget\nNur ein Markt\nNoch keine mobile App',
      ),
      'opportunities': FieldText(
        'Chancen',
        example:
            'Die Zahl der Freelancer wächst weiter\nSteuerberater möchten einfache Tools empfehlen\nNeue E-Rechnungs-Pflicht',
      ),
      'threats': FieldText(
        'Risiken',
        example:
            'Große Buchhaltungssuiten führen Freelancer-Tarife ein\nPreiserhöhungen bei Bank-APIs',
      ),
    },
    template: r'''SWOT-ANALYSE: {company}

STÄRKEN (intern, hilfreich)
{strengths|bullets}

SCHWÄCHEN (intern, hinderlich)
{weaknesses|bullets}

CHANCEN (extern, hilfreich)
{opportunities|bullets}

RISIKEN (extern, hinderlich)
{threats|bullets}

NÄCHSTE SCHRITTE
• Stärken nutzen, um diese Chance zu ergreifen: {opportunities|first}…
• Die Schwäche beheben, die das Wachstum am meisten bremst.
• Eine Antwort auf das größte Risiko planen, bevor es eintritt.''',
  ),
  'competitors': ToolText(
    name: 'Wettbewerber-Tracker',
    description: 'Wer dieses Problem sonst noch löst, und wie.',
    itemLabel: 'Wettbewerber',
    stages: {'Direct': 'Direkt', 'Indirect': 'Indirekt', 'Watch': 'Beobachten'},
    fields: {
      'price': FieldText('Preis', example: r'15 $/Monat'),
      'strength': FieldText('Stärke', example: 'Marke'),
      'weakness': FieldText('Schwäche', example: 'Komplex'),
    },
    samples: [
      SampleText('LedgerPro', {
        'price': r'25 $/Monat',
        'strength': 'Komplette Buchhaltungssuite',
        'weakness': 'Zu komplex für Solo-Freelancer',
      }),
      SampleText('Tabellen', {
        'price': 'Kostenlos',
        'strength': 'Flexibel, schon bekannt',
        'weakness': 'Manuell, fehleranfällig',
      }),
      SampleText('TaxBot', {
        'price': r'8 $/Monat',
        'strength': 'Günstig',
        'weakness': 'Kein Bankabgleich',
      }),
    ],
  ),
  'persona': ToolText(
    name: 'Persona-Builder',
    description: 'Ein klares Bild des Kunden, für den du baust.',
    fields: {
      'name': FieldText('Name der Persona', example: 'Designerin Dana'),
      'role': FieldText('Rolle', example: 'Freiberufliche UI-Designerin'),
      'age': FieldText('Alter'),
      'location': FieldText('Ort', example: 'Hamburg'),
      'goals': FieldText(
        'Ziele',
        example:
            'Das Einkommen verdoppeln\nZeit ins Design stecken, nicht in Verwaltung',
      ),
      'pains': FieldText(
        'Größtes Problem',
        example:
            'Hasst Buchhaltung und zahlt Säumniszuschläge für verspätete Steuervorauszahlungen',
      ),
      'tools': FieldText(
        'Heute genutzte Tools',
        example: 'Figma\nNotion\nEine Tabelle für Ausgaben',
      ),
      'quote': FieldText(
        'Zitat',
        example:
            'Ich bin Freelancerin geworden, um zu gestalten, nicht um Buchhaltung zu machen.',
      ),
      'channels': FieldText(
        'Wo man sie erreicht',
        example: 'Dribbble\nDesign-Communities\nFreelancer-Slack-Gruppen',
      ),
    },
    template: r'''PERSONA: {name}

{role}, {age}, {location}

„{quote}“

ZIELE
{goals|bullets}

SCHMERZPUNKTE
{pains|bullets}

AKTUELLE TOOLS
{tools|bullets}

WO MAN SIE ERREICHT
{channels|bullets}

So helfen wir: {name|first} zeigen, wie viel Zeit und Geld sie in der ersten Woche zurückbekommt.''',
  ),
  'interviewQuestions': ToolText(
    name: 'Interview- und Umfragefragen',
    description: 'Leitfäden für Kundeninterviews ohne Suggestivfragen.',
    options: {
      'Problem discovery': 'Problem verstehen',
      'Solution validation': 'Lösung validieren',
      'Pricing': 'Preisgestaltung',
    },
    fields: {
      'stage': FieldText('Art des Interviews'),
      'segment': FieldText('Zielkunde', example: 'Freiberufliche Designer'),
      'problemArea': FieldText(
        'Problembereich',
        example: 'Buchhaltung und Steuern',
      ),
      'product': FieldText('Produktname'),
    },
    templates: {
      'Problem discovery': r'''INTERVIEW ZUM PROBLEMVERSTÄNDNIS
Zielgruppe: {segment}

Einstieg
1. Erzähl mir von deiner Arbeit. Wie sieht eine typische Woche aus?
2. Wie lange machst du das schon?

Das Problem
3. Beschreib mir das letzte Mal, als du dich um dieses Thema kümmern musstest: {problemArea}.
4. Was war dabei am schwierigsten?
5. Wie oft kommt das vor?
6. Was tust du heute dagegen? Welche Tools oder Personen helfen dir?
7. Was kostet es dich an Zeit oder Geld?
8. Hast du versucht, es anders zu lösen? Warum hast du aufgehört?

Abschluss
9. Wenn du zaubern könntest, was würdest du ändern?
10. Mit wem sollte ich sonst noch darüber sprechen?

Tipps: Frag nach vergangenem Verhalten, nicht nach Meinungen über die Zukunft. Verkaufe nichts.''',
      'Solution validation': r'''INTERVIEW ZUR LÖSUNGSVALIDIERUNG
Zielgruppe: {segment}
Produkt: {product}

1. Erinnere mich daran, wie du dieses Thema heute angehst: {problemArea}.
2. (Prototyp zeigen.) Was glaubst du, was das hier macht?
3. Versuch, diese Aufgabe zu erledigen. Denk dabei laut.
4. Was war verwirrend oder langsam?
5. Was fehlt, damit es ersetzt, was du heute nutzt?
6. Welchen Teil würdest du am meisten nutzen?
7. Wenn {product} morgen verschwinden würde, wie würdest du dich fühlen?
8. Möchtest du Teil unserer ersten Beta-Gruppe sein?

Tipps: Lass Stille zu. Achte darauf, was sie tun, nicht nur, was sie sagen.''',
      'Pricing': r'''INTERVIEW ZUR PREISGESTALTUNG (Van Westendorp)
Zielgruppe: {segment}
Produkt: {product}

1. Bei welchem Monatspreis wäre {product} so billig, dass du an der Qualität zweifeln würdest?
2. Bei welchem Preis wäre es ein Schnäppchen, ein richtig guter Kauf?
3. Ab welchem Preis wirkt es teuer, du würdest es aber noch in Betracht ziehen?
4. Ab welchem Preis ist es zu teuer, um es in Betracht zu ziehen?
5. Was zahlst du heute für Tools rund um dieses Thema: {problemArea}?
6. Wer genehmigt diesen Kauf?
7. Bevorzugst du monatliche oder jährliche Abrechnung? Warum?

Tipp: Trag die Antworten auf 1–4 in ein Diagramm ein, um die akzeptable Preisspanne zu finden.''',
    },
  ),
  'ideaScore': ToolText(
    name: 'Ideen-Bewertungsmatrix',
    description: 'Bewerte eine Idee nach sechs Kriterien, bevor du baust.',
    fields: {
      'problemPain': FieldText(
        'Leidensdruck',
        hint: 'Wie sehr es heute schmerzt',
      ),
      'marketSize': FieldText('Marktgröße'),
      'willingnessToPay': FieldText('Zahlungsbereitschaft'),
      'competition': FieldText(
        'Raum neben der Konkurrenz',
        hint: '5 = wenige starke Rivalen',
      ),
      'feasibility': FieldText('Machbarkeit', hint: 'Kann euer Team es bauen?'),
      'founderFit': FieldText('Gründer-Fit'),
    },
  ),
};
