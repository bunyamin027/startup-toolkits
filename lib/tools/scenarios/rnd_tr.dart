import '../l10n/tool_text.dart';
import 'scenario.dart';

/// R&D example (Terralab) in Turkish.
const rndTr = ScenarioText(
  fields: {
    'leanCanvas': {
      'company': 'Terralab',
      'problem':
          'Toprak nemi tahminle ölçüldüğü için tarlalar %30–40 fazla sulanıyor.\n'
          'Laboratuvar düzeyinde toprak sensörlerinin tanesi 1.000 \$’ın üzerinde.\n'
          'Su fiyatları ve kuraklık önlemleri her yıl artıyor.',
      'solution':
          'Nemi üç farklı derinlikte ölçen 90 \$’lık bir sensör.\n'
          'Ölçümleri günlük sulama planına çeviren bir makine öğrenmesi modeli.\n'
          'Telefona gelen uyarılar; ziraat mühendisine gerek kalmadan.',
      'uvp':
          'Laboratuvar kalitesinde toprak verisi, onda bir fiyatına; her tarla alışkanlıkla değil ihtiyaca göre sulanır.',
      'segment': 'Kurak bölgelerdeki orta ölçekli meyve ve sebze üreticileri',
      'channels':
          'Tarım kooperatifleri\nSulama ekipmanı bayileri\nTarla günleri ve tarım fuarları',
      'revenue':
          'Sensör satışı: tanesi 90 \$\nVeri platformu: sensör başına aylık 4 \$',
      'costs':
          'Ar-Ge ekibi ve laboratuvar testleri\nSensör üretimi\nSaha pilotları',
      'metrics':
          'Hektar başına tasarruf edilen su\nKurulan sensör sayısı\nPilottan ücretli kullanıma geçiş oranı',
      'advantage':
          'Patent başvurusu yapılmış ölçüm yöntemi ve üniversite denemelerinden 3 yıllık saha verisi.',
    },
    'swot': {
      'company': 'Terralab',
      'strengths':
          'Patent başvurusu yapılmış sensör tasarımı\nÜniversite laboratuvarı ortaklığı\n12 pilot çiftlikten saha verisi',
      'weaknesses':
          'Uzun donanım geliştirme döngüleri\nHenüz sertifikalı bir üretim hattı yok\nKüçük satış ekibi',
      'opportunities':
          'Su verimliliği için kamu hibeleri\nKurak bölgelerde sıkılaşan sulama kuralları\nToplu alım yapan kooperatifler',
      'threats':
          'Büyük sulama markalarının sensör eklemesi\nElektronik bileşen tedarikinde sıkıntılar',
    },
    'competitors': {
      'price': 'Sensör başına 1.200 \$',
      'strength': 'Hassasiyet',
      'weakness': 'Pahalı',
    },
    'persona': {
      'name': 'Çiftçi Mehmet',
      'role': '40 hektarlık meyve bahçesi sahibi',
      'age': '47',
      'location': 'Konya',
      'goals':
          'Verimi düşürmeden su maliyetini azaltmak\nYeni sulama kurallarına uymak',
      'pains':
          'Alışkanlıkla sulayıp sorunları ancak ağaçlar strese girince fark ediyor',
      'tools':
          'Bir hava durumu uygulaması\nSulama zamanlayıcısı\nKooperatifin ziraat mühendisinden tavsiyeler',
      'quote':
          'Daha fazla veriye değil, ne zaman sulayacağımı bilmeye ihtiyacım var.',
      'channels':
          'Kooperatif toplantıları\nSulama bayileri\nYerel üreticilerin WhatsApp grupları',
    },
    'interviewQuestions': {
      'segment': 'Meyve bahçesi ve sebze üreticileri',
      'problemArea': 'sulama planlaması',
      'product': 'Terralab',
    },
    'invoice': {
      'company': 'Terralab Teknoloji A.Ş.',
      'email': 'fatura@terralab.io',
      'client': 'Yeşil Vadi Tarım Kooperatifi',
      'item1': 'Toprak sensörü seti (10 sensör)',
      'item2': 'Veri platformu, çiftlik başına yıllık lisans',
    },
    'incomeExpense': {'category': 'Laboratuvar'},
    'pitchDeck': {
      'company': 'Terralab',
      'oneLiner':
          'Tarlalara tam olarak ne zaman sulama yapacağını söyleyen düşük maliyetli toprak sensörleri.',
      'problem':
          'Hassas toprak sensörleri 1.000 \$’ın üzerinde olduğu için tarlalar %30–40 fazla sulanıyor.',
      'solution':
          'Toprak ölçümlerini günlük sulama planına çeviren 90 \$’lık bir sensör ve makine öğrenmesi modeli.',
      'market':
          'Kurak bölgelerde 570 bin orta ölçekli çiftlik; 2,1 milyar \$ ulaşılabilir pazar',
      'model': 'Sensör satışı ve veri platformu için sensör başına aylık 4 \$',
      'traction':
          '12 pilot çiftlik, ortalama %31 su tasarrufu, patent başvurusu, 250 bin \$ Ar-Ge hibesi',
      'competition':
          'Laboratuvar sensörleri (hassas ama pahalı), uydu hizmetleri (ucuz ama kaba)',
      'team':
          'Elif (CEO, ziraat mühendisi), Can (CTO, sensörler üzerine doktora), Jonas (donanım lideri, eski sulama üreticisi)',
      'ask':
          'Üretimi sertifikalandırıp 300 çiftliğe ulaşmak için 1,2 milyon \$ tohum yatırım',
      'email': 'kurucular@terralab.io',
    },
    'onePager': {
      'company': 'Terralab',
      'oneLiner':
          'Tarlalara tam olarak ne zaman sulama yapacağını söyleyen düşük maliyetli toprak sensörleri.',
      'problem':
          'Hassas toprak sensörleri 1.000 \$’ın üzerinde olduğu için tarlalar %30–40 fazla sulanıyor.',
      'solution':
          'Toprak ölçümlerini günlük sulama planına çeviren 90 \$’lık bir sensör ve makine öğrenmesi modeli.',
      'customer': 'Kurak bölgelerdeki orta ölçekli meyve ve sebze üreticileri',
      'market': '2,1 milyar \$ ulaşılabilir pazar',
      'traction': '12 pilot çiftlik, %31 su tasarrufu, patent başvurusu',
      'team': 'Elif (CEO), Can (CTO), Jonas (Donanım)',
      'ask': '1,2 milyon \$ tohum yatırım',
      'email': 'kurucular@terralab.io',
    },
    'investorTracker': {
      'firm': 'Etki yatırım fonu',
      'next': 'Pilot sonuçlarını gönder',
    },
    'kanban': {'owner': 'Elif'},
    'okr': {'objective': 'Sahada su tasarrufunu kanıtlamak'},
    'roadmap': {'why': 'Pilot çiftliklerin talebi'},
    'userStory': {
      'feature': 'Günlük sulama planı',
      'user': 'çiftlik yöneticisi',
      'want': 'bugün her tarlayı ne kadar sulayacağımı görmek',
      'benefit': 'tahmin yürütmeyi bırakıp su tasarrufu yapayım',
      'criteria':
          'Plan her gün sabah 6’da hazır olur\nTarla ve bölge başına dakika gösterir\nGerekçeyi tek satırda açıklar\nÇiftliğin mevcut sulama zamanlayıcısıyla çalışır',
      'outOfScope': 'Otomatik vana kontrolü\nGübreleme önerileri',
      'metric': 'Bir sezonda pilot çiftliklerde %25 daha az su kullanımı',
    },
    'standup': {'who': 'Elif'},
    'brandName': {
      'keyword': 'toprak',
      'keyword2': 'terra',
      'benefit': 'her tarlayı alışkanlıkla değil ihtiyaca göre sula',
      'audience': 'üreticiler',
    },
    'colorPalette': {'company': 'Terralab'},
    'landingPage': {
      'company': 'Terralab',
      'audience': 'üreticiler',
      'outcome': 'Ne zaman sulayacağınızı tam olarak bilin',
      'problem':
          'Alışkanlıkla sulamak suyu, parayı ve bazen hasadı boşa harcatır.',
      'features':
          'Üç toprak derinliğini ölçen 90 \$’lık sensör\nHer tarla için günlük sulama planı\nBitkiler strese girmeden gelen uyarılar',
      'proof': '12 çiftlikte test edildi, %31 su tasarrufu',
      'cta': 'Pilot için başvurun',
    },
    'emailTemplates': {
      'sender': 'Elif',
      'company': 'Terralab',
      'oneLiner':
          'tarlalara ne zaman sulama yapacağını söyleyen düşük maliyetli toprak sensörleri',
      'hook': 'Tarım Teknolojileri Zirvesi’ndeki iklim teknolojisi konuşmanız',
      'traction': '12 pilot çiftlik ve yapılmış bir patent başvurusu',
    },
    'seoKeywords': {
      'topic': 'toprak nem sensörü',
      'audience': 'üreticiler',
      'alternative': 'tansiyometre',
      'location': 'Konya',
    },
    'crm': {
      'company': 'Yeşil Vadi Kooperatifi',
      'next': 'Saha ziyareti planla',
    },
    'proposal': {
      'company': 'Terralab Teknoloji A.Ş.',
      'client': 'Yeşil Vadi Tarım Kooperatifi',
      'need':
          'Yeşil Vadi, 15 üye çiftliğinin verimi düşürmeden sulama suyunu azaltmasını istiyor.',
      'scope':
          '15 çiftliğe 60 toprak sensörü kurulumu\nBir sezonluk veri platformu\nÇiftlik yöneticileri için eğitim günü',
      'timeline': 'İmzadan sonraki üç hafta içinde sensörler kurulur',
      'sender': 'Elif Kaya',
    },
    'followUps': {'note': 'Pilot sonuçlarını gönder'},
    'feedback': {'from': 'Pilot çiftlik'},
    'nda': {
      'company': 'Terralab Teknoloji A.Ş.',
      'otherParty': 'Yeşil Vadi Tarım Kooperatifi',
      'purpose': 'ortak bir saha denemesinin değerlendirilmesi',
    },
    'privacyTerms': {
      'company': 'Terralab Teknoloji A.Ş.',
      'service': 'Terralab uygulaması ve toprak sensörleri',
      'email': 'gizlilik@terralab.io',
      'data':
          'Ad ve e-posta\nÇiftlik konumu ve tarla sınırları\nSensörlerinizden gelen toprak ölçümleri\nUygulama kullanım analitiği',
    },
    'contract': {
      'company': 'Terralab Teknoloji A.Ş.',
      'scope':
          'Saha kullanımı için hava koşullarına dayanıklı sensör gövdesi tasarımı',
    },
    'jobPost': {
      'company': 'Terralab',
      'oneLiner':
          'tarlalara ne zaman sulama yapacağını söyleyen düşük maliyetli toprak sensörleri',
      'title': 'Gömülü Yazılım Mühendisi',
      'location': 'Hibrit (haftada iki gün laboratuvar)',
      'responsibilities':
          'Sensör yazılımını prototipten üretime taşımak\nTek pille iki sezon çalışacak şekilde güç tüketimini düşürmek\nPilot çiftliklerle saha testlerine katılmak',
      'requirements':
          'Düşük güçlü cihazlarda 3+ yıl gömülü C deneyimi\nSensör veya radyo (LoRa, BLE) deneyimi\nTarlada da laboratuvarda olduğu kadar rahat',
      'email': 'kariyer@terralab.io',
    },
    'interviewLibrary': {
      'company': 'Terralab',
      'title': 'Gömülü Yazılım Mühendisi',
    },
    'meetingNotes': {'owner': 'Elif', 'meeting': 'Haftalık Ar-Ge toplantısı'},
    'storeListing': {
      'app': 'Terralab',
      'subtitle': 'Üreticiye akıllı sulama',
      'oneLiner': 'ne zaman sulayacağınızı söyleyen toprak sensörleri',
      'audience': 'üreticiler',
      'features':
          'Her tarla için günlük sulama planı\nÜç derinlikte toprak nemi\nBitkiler strese girmeden uyarılar\nHibe ve denetimler için su tasarrufu raporları',
      'price': 'Her Terralab sensörüne dahildir.',
      'proof': '12 pilot çiftlikte kullanılıyor',
    },
    'asoKeywords': {
      'app': 'Terralab',
      'primary': 'sulama',
      'secondary': 'toprak',
      'audience': 'çiftçi',
      'keywords': 'sensör,nem,su,tarla,bahçe,meyve,hasat,damla',
      'competitor': 'AquaProbe',
    },
    'reviewReply': {
      'app': 'Terralab',
      'topic': 'sulama uyarıları',
      'email': 'destek@terralab.io',
    },
    'appPrivacy': {
      'app': 'Terralab',
      'developer': 'Terralab Teknoloji A.Ş.',
      'email': 'gizlilik@terralab.io',
    },
  },
  samples: {
    'competitors': [
      SampleText('AquaProbe Pro', {
        'price': 'Sensör başına 1.200 \$',
        'strength': 'Laboratuvar düzeyinde hassasiyet',
        'weakness': 'Çoğu çiftlik için fazla pahalı',
      }),
      SampleText('Tansiyometreler', {
        'price': '80 \$’dan başlayan',
        'strength': 'Ucuz ve bilinen',
        'weakness': 'Elle okuma, tek derinlik',
      }),
      SampleText('SatIrrig', {
        'price': 'Hektar başına aylık 6 \$',
        'strength': 'Donanım gerektirmez',
        'weakness': 'Uydu verisi tek tarla için fazla kaba',
      }),
    ],
    'incomeExpense': [
      SampleText('Pilot çiftlik abonelikleri', {'category': 'Gelir'}),
      SampleText('Mühendis maaşları', {'category': 'Ekip'}),
      SampleText('Laboratuvar testleri ve bileşenler', {'category': 'Ar-Ge'}),
    ],
    'investorTracker': [
      SampleText('Maya Chen', {
        'firm': 'AgriTech Ventures',
        'next': 'Perşembe ortaklar toplantısı',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Melek yatırımcı (eski sulama şirketi CEO’su)',
        'next': 'SAFE sözleşmesini gönder',
      }),
      SampleText('İklim Tohum Fonu', {
        'firm': 'İklim fonu',
        'next': 'Jordan’dan tanıştırma iste',
      }),
    ],
    'kanban': [
      SampleText('4 numaralı sensör partisini kalibre et', {'owner': 'Can'}),
      SampleText('Hibe ilerleme raporunu hazırla', {'owner': 'Elif'}),
      SampleText('12 numaralı pilot çiftliğe sensör kur', {'owner': 'Jonas'}),
    ],
    'okr': [
      SampleText('20 çiftlikte pilot yürüt', {
        'objective': 'Sahada su tasarrufunu kanıtlamak',
      }),
      SampleText('Ortalama su tasarrufu %25’in üzerinde', {
        'objective': 'Sahada su tasarrufunu kanıtlamak',
      }),
      SampleText('CE sertifikasını al', {'objective': 'Üretime hazırlanmak'}),
    ],
    'roadmap': [
      SampleText('Tek pille iki sezon', {
        'why': 'Pilot çiftliklerin en çok istediği',
      }),
      SampleText('LoRaWAN ağ geçidi desteği', {
        'why': 'Mobil kapsama alanı olmayan çiftlikler',
      }),
      SampleText('Gübreleme önerileri', {
        'why': 'İkinci bir gelir kalemi açar',
      }),
    ],
    'standup': [
      SampleText('7 numaralı pilot çiftlikte saha testi bitti', {
        'who': 'Jonas',
      }),
      SampleText('Patent vekiliyle görüşme', {'who': 'Elif'}),
      SampleText('Tedarikçiden sensör çipleri bekleniyor', {'who': 'Can'}),
    ],
    'contentCalendar': [
      SampleText('12 pilot çiftlik bize su hakkında ne öğretti?', {
        'channel': 'Blog',
      }),
      SampleText('Laboratuvarın içinden: bir sensör nasıl kalibre edilir?', {
        'channel': 'LinkedIn',
      }),
      SampleText('Yaz zirvesi öncesi sulama ipuçları', {
        'channel': 'Instagram',
      }),
    ],
    'crm': [
      SampleText('Ayşe Demir', {
        'company': 'Yeşil Vadi Kooperatifi',
        'next': 'Salı 10:00 saha demosu',
      }),
      SampleText('Murat Aydın', {
        'company': 'Aydın Meyvecilik',
        'next': 'Cuma tekrar ara',
      }),
      SampleText('Zeynep Koç', {
        'company': 'Koç Bağcılık',
        'next': 'Sensörleri kur',
      }),
    ],
    'followUps': [
      SampleText('Ayşe: saha demosu raporunu gönder', {
        'note': 'Su tasarrufu grafiğini ekle',
      }),
      SampleText('Maya: ortaklar toplantısı notları', {
        'note': 'Geri bildirim bekleniyor',
      }),
      SampleText('Zeynep: sezon değerlendirmesi', {
        'note': 'Tüm sensörler çevrimiçi',
      }),
    ],
    'feedback': [
      SampleText('Daha uzun pil ömrü', {
        'from': '2, 5 ve 9 numaralı pilot çiftlikler',
      }),
      SampleText('Uygulamada İngilizce dil desteği', {
        'from': 'Aydın Meyvecilik',
      }),
      SampleText('Daha anlaşılır sulama uyarıları', {'from': 'Pilot grubu'}),
    ],
    'meetingNotes': [
      SampleText('Hibe ilerleme raporunu gönder', {
        'owner': 'Elif',
        'meeting': 'Haftalık Ar-Ge toplantısı',
      }),
      SampleText('Düşük sıcaklıkta sensör sapmasını düzelt', {
        'owner': 'Can',
        'meeting': 'Laboratuvar değerlendirmesi',
      }),
      SampleText('Üretim ortağını seç', {
        'owner': 'Jonas',
        'meeting': 'Haftalık Ar-Ge toplantısı',
      }),
    ],
    'kpiBoard': [
      SampleText('Sensör kurulan çiftlikler', {
        'current': '12',
        'target': '20',
      }),
      SampleText('Ortalama su tasarrufu', {'current': '%22', 'target': '%25'}),
      SampleText('Sensör arıza oranı', {'current': '%6', 'target': '%2'}),
    ],
  },
);
