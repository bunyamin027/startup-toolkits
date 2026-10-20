# Startup Cebimde: Ana Plan (Ürün, Tasarım, Teknik, Gelir, Apple, Yol Haritası)

*Son güncelleme: 19 Ekim 2026. Bu dosya sohbetteki tüm kararların tek kaynağıdır. Fiyatlar, tarihler ve "açık karar" işaretli maddeler varsayımdır.*

Çalışma adı: **Startup Cebimde** (nihai uygulama adı henüz yok).
Referans prototipler: web prototipi (45 araç, çalışıyor) ve 6 ekranlı tıklanabilir tasarım (Design canvas).

---

## 1. Vizyon

**Ne:** Bir kurucunun ihtiyaç duyduğu mini araçları tek çatı altında toplayan mobil süper uygulama.
**Kime:** Global pazardaki girişimciler ve erken aşama kurucular. İngilizce ile başlanır.
**Fark:** Araçlar bağımsız değil. Kullanıcı startup bilgisini bir kez girer, tüm araçlar otomatik dolar (Lean Canvas'taki problem pitch deck'e ve one-pager'a akar).

**UX ilkeleri**
1. İlk 60 saniyede değer: hesap ve kayıt yok, hedef seç ve başla.
2. Araçlar hedefe göre sunulur ("fon arıyorum"), araç adına göre değil.
3. Tüm araçlarda aynı kalıp: **Gir, anında sonucu gör, kopyala ya da kaydet.**
4. Boş ekran yok: her araç örnek veriyle açılır.
5. Hareket amaçlı ve kısa; "hareketi azalt" ayarına uyar.

---

## 2. Verilen kararlar

| Konu | Karar |
|---|---|
| Pazar | Global, İngilizce ile başla; mimari baştan çok dilli (RTL dahil) |
| Kapsam | 10 kategori, 45 araç |
| Mimari | Üç motor (hesaplayıcı, metin üretici, liste). Her araç bir veri tanımıdır |
| Çekirdek özellik | Proje çalışma alanı + otomatik doldurma |
| İlk açılış | Onboarding: hedef seçimi, startup adı ve tek cümlelik tanım; atlanabilir |
| Gelir modeli | 14 gün her şey açık, sonra aylık/yıllık plan, yıllıkta indirim |
| Deneme sonrası | Ücretsiz plan: günde 1 araç |
| Teknoloji | Flutter, iOS öncelikli, sonra Android |
| Veri (v1) | Yalnızca cihazda; hesap ve sunucu yok |
| Görsel yön | Koyu lacivert zemin, limon vurgu, sistem yazı tipi, "Mission control" konsepti |

**Fiyatlar (karar):** aylık 6,99 $, yıllık 49,99 $ (yaklaşık %40 indirim); bölgesel kademeler mağazalardan.

---

## 3. Kapsam: 45 araç

Üç motor: **H** = hesaplayıcı (8), **M** = metin üretici (23), **L** = takip listesi (14).

### 3.1 Fikir ve doğrulama (6)
- Lean Canvas **M**: problem, çözüm, değer önerisi, müşteri segmenti, kanallar, gelir, maliyet, metrikler, haksız avantaj
- SWOT analizi **M**
- Rakip takipçisi **L**: rakip, fiyat, güçlü ve zayıf yön
- Persona oluşturucu **M**
- Görüşme ve anket soruları **M**
- Fikir puanlama matrisi **H**

### 3.2 Finans (6)
- Runway ve burn rate **H**
- Unit economics **H**
- Fiyatlandırma hesaplayıcı **H**
- Fatura oluşturucu **M**
- Cap table simülatörü **H**
- Gelir-gider takibi **L**

### 3.3 Yatırımcı ilişkileri (4)
- Pitch deck sihirbazı **M** (10 slaytlık taslak)
- One-pager **M**
- Yatırımcı takibi **L** (aşamalar: To contact, Contacted, Meeting, Committed, Passed)
- Değerleme tahmini **H**

### 3.4 Ürün ve proje (5)
- Kanban **L** (To do, Doing, Done)
- OKR takibi **L**
- Yol haritası **L** (Now, Next, Later)
- User story ve PRD **M**
- Stand-up notları **L**

### 3.5 Pazarlama ve içerik (6)
- Marka ismi ve slogan **M**
- Renk paleti ve logo fikri **M**
- İçerik takvimi **L**
- Landing page metni **M**
- E-posta şablonları **M** (cold outreach, follow-up, investor update, thank you)
- SEO anahtar kelime fikirleri **M**

### 3.6 Satış ve müşteri (4)
- Mini CRM **L** (Lead, Contacted, Demo, Won, Lost)
- Teklif şablonu **M**
- Takip hatırlatıcıları **L**
- Müşteri geri bildirimi **L**

### 3.7 Hukuk ve belgeler (3)
- NDA (karşılıklı) **M**
- Gizlilik politikası ve kullanım şartları **M** (GDPR, CCPA, KVKK, Global varyantları)
- Freelancer ve ortaklık sözleşmesi **M**

*Her hukuki çıktıda: "Template only, not legal advice. Have a lawyer review it before use."*

### 3.8 Ekip ve İK (4)
- İş ilanı **M**
- Mülakat soru kütüphanesi **M**
- Toplantı notu ve aksiyonlar **L**
- Onboarding kontrol listesi **L** (hazır maddelerle gelir)

### 3.9 Büyüme ve analitik (3)
- KPI panosu **L**
- A/B test anlamlılığı **H**
- Dönüşüm hunisi **H**

### 3.10 Mobil uygulama kurucuları (4)
- Store listing yazıcı **M**
- ASO anahtar kelime aracı **M**
- Yorum cevabı yazıcı **M**
- Uygulama gizlilik politikası **M**

---

## 4. Hesaplayıcı formülleri (birim testi için)

| Araç | Girdi → çıktı |
|---|---|
| Runway | net burn = max(gider − gelir, 0); runway (ay) = nakit / (gider − gelir); gider ≤ gelir ise "kârlı, burn yok" |
| Unit economics | ömür (ay) = 100 / churn%; LTV = ARPU × marj% / churn%; LTV:CAC = LTV / CAC; geri ödeme (ay) = CAC / (ARPU × marj%/100) |
| Fiyatlandırma | fiyat = maliyet / (1 − hedef marj%); rakip fiyatta marj = (rakip − maliyet) / rakip |
| Cap table | post-money = pre + yatırım; yatırımcı payı = yatırım / post; mevcut hissedar = pre / post; yeni hisse = mevcut hisse × yatırım / pre; hisse fiyatı = pre / mevcut hisse |
| Değerleme | ARR × çarpan. Büyüme ≥100%: 6–12×; ≥50%: 4–8×; altı: 3–6×. Yalnızca kaba tahmin |
| Fikir puanı | 6 kriter (1–5) toplamı / 30; ≥24 güçlü, ≥17 umut verici, altı zayıf |
| A/B testi | iki oran z-testi, iki yönlü; güven = 2Φ(\|z\|) − 1; ≥95% anlamlı |
| Dönüşüm hunisi | ziyaretçi→kayıt, kayıt→aktif, aktif→ödeyen, genel oran |

Örnek doğrulama: nakit 120.000, gider 14.000, gelir 3.500 → net burn 10.500, runway 11,43 ay.

---

## 5. Proje çalışma alanı ve otomatik doldurma

Proje alanları: startup adı, tek cümlelik tanım, problem, çözüm, hedef müşteri, pazar büyüklüğü, traction, yatırım talebi, ekip, iletişim e-postası, nakit, aylık gider, aylık gelir (13 alan).

**Eşleştirme kuralı (alan etiketine göre):**
- şirket, ürün, uygulama adı, geliştirici → startup adı
- problem → problem; çözüm → çözüm
- müşteri segmenti, hedef kitle → hedef müşteri
- pazar büyüklüğü, traction, "the ask", ekip → aynı adlı alan
- iletişim, destek e-postası → e-posta
- nakit, aylık gider, aylık gelir → finans alanları

Kurallar: iki yönlü (araçta değişen alan projeyi günceller); takip listelerine uygulanmaz (şirket adı müşteri formuna dolmasın); "sonraki adım" önerisi doluluğa göre değişir; "Copy project brief" tüm bilgileri tek metin olarak kopyalar.

---

## 6. Gelir modeli

| Dönem | Erişim |
|---|---|
| İlk 14 gün | 45 aracın hepsi açık |
| Deneme sonrası, abone değil | Günde **1 araç**. Günün ilk açılan aracı "bugünün aracı" olur ve gün boyu sınırsız açılır; başka araca dokununca plan ekranı çıkar. Gece yarısı yenilenir |
| Abone | Hepsi açık |

**Plan ekranı:** Yıllık (varsayılan seçili, "Save 40%"), aylık; "Start 14-day free trial".
**Project sekmesi ve onboarding** her zaman ücretsiz.

**Açık karar (deneme türü):**
- *Mağaza tabanlı deneme:* güvenilir, kötüye kullanımı zor; kart istediği için denemeye başlayan azalır.
- *Uygulama içi deneme (prototip):* kartsız, başlayan fazla; ama uygulamayı silip kurunca sıfırlanır.
- Öneri: mağaza tabanlı abonelik + tanıtım teklifi ile başla, dönüşümü ölç. Apple'da dijital özellik satışı In-App Purchase üzerinden olmalıdır.

**Açık karar (ücretsiz plan):** "günde 1 araç" sıkı olabilir. Alternatif: hesaplayıcılar tamamen ücretsiz, kilit yalnızca üretici ve takip araçlarında. Gerçek veriyle karar ver.

**Büyüme fikirleri (v1.1):** davet sistemi (arkadaşını getir, ek deneme günü), çıktılarda küçük "Created with [App name]" filigranı.

---

## 7. UI/UX tasarım sistemi

### 7.1 Renk belirteçleri (koyu tema)
| Belirteç | Değer | Kullanım |
|---|---|---|
| bg | `#0B1020` | Zemin |
| surface-1 | `#151B31` | Kart |
| surface-2 | `#1F2744` | İkincil yüzey, iz çizgisi |
| border | `#2A3355` | Kenarlık |
| text | `#F2F4FA` | Ana metin |
| muted | `#A3ACC8` | İkincil metin |
| accent (limon) | `#B8F46A` | Vurgu, birincil düğme; üzerinde `#0B1020` metin |
| blue | `#6C93FF` | Arka plan ışığı, ikincil vurgu |

Açık tema henüz çizilmedi; aynı belirteç adlarıyla ayrı değer seti tanımlanacak.

### 7.2 Tipografi, boşluk, şekil
- Yazı tipi: sistem (SF Pro). Başlık 32/700, ekran başlığı 26/700, gövde 16, ikincil 13, küçük etiket 11–12.
- Sayılar tabular (hizalı) rakam.
- Köşe: kart 20–24, düğme 18, çip 16, ikon kutusu 14.
- Kenar boşluğu 20; öğeler arası 8–14.
- Dokunma hedefi **en az 44×44**.

### 7.3 Animasyonlar
| Efekt | Süre | Nerede |
|---|---|---|
| Sırayla yükselme (opaklık + 14 px) | 600 ms, öğe başına 70 ms gecikme | Tüm ekranlar |
| Halka çizilmesi (stroke) | 1,4 sn | Runway, proje doluluğu, geri sayım |
| Sayaç artışı (0'dan değere) | 1,4 sn | Runway sonucu |
| Çubuk büyümesi ve sürgü kayması | 1,1 sn | Sürgüler, ilerleme çubukları |
| Nabız | 1,8–2,2 sn, sürekli | Yol üzerindeki şu anki adım, "next step" oku |
| Süzülme | 5–9 sn, sürekli | Arka plan ışığı, paywall ikonları |
| Alt sayfa yaylanması | 700 ms | Free limit |

Hepsi "Reduce Motion" açıkken kapatılır. Flutter: `flutter_animate` ya da `TweenAnimationBuilder`; `MediaQuery.disableAnimations`.

### 7.4 Ekranlar ve akış
1. **Welcome:** "What are you building toward?" 4 hedef kartı (Raise funding, Find first customers, Set up the company, Launch my app), Continue, Skip.
2. **Home ("Mission control"):** proje adı, deneme rozeti, arama, **Launch path** (Idea, Validate, Money, Pitch, Launch) ve %, "Next best step" kartı, hedefe göre araç kartları, alt sekme (Home, Project, My tools, Profile).
3. **Tool (Runway örneği):** geri ve favori, dev halka sayaç, net burn çipi, üç sürgü, "Save to project" ve paylaş.
4. **Project:** ad, tek cümlelik tanım, aşama çipleri, doluluk halkası (8/13), "Add to unlock more" çipleri, araç satırları (alan doluluğu).
5. **Paywall:** yüzen araç ikonları, 3 fayda, yıllık/aylık kartlar, "Start 14-day free trial", yasal metin, Restore Purchases · Terms of Use · Privacy Policy.
6. **Free limit:** alt sayfa, geri sayım halkası ("6h 12m to reset"), "Go unlimited", "Come back tomorrow".

**Tıklanabilir akış:** Welcome → Home; Home → Tool / Paywall / Project / Free limit; Tool → Home / Project; Project → Home / Tool; Paywall → Home; Free limit → Paywall / Home.

**Eksik ekranlar (yapılacak):** My tools (favoriler), Profile (plan, dil, tema, gizlilik, Terms), Discover/arama sonuçları, tüm araç ekranı varyantları (metin üretici çıktısı, liste), açık tema.

---

## 8. Apple gereksinimleri (özet; ayrıntı: Apple-Gereksinimleri-ve-Tasarim-Kurallari.md)

**Abonelik (3.1.2):** süre ve ad; tam yenileme fiyatı belirgin ve yerel para biriminde (faturalanan tutar aylık karşılığından büyük); deneme süresi ve sonrası fiyat; otomatik yenileme ve iptal bilgisi; **Restore Purchases**; Terms of Use ve Privacy Policy bağlantıları (uygulamada ve App Store Connect'te); fiyat StoreKit'ten gelir.
**Gizlilik (5.1):** gizlilik politikası; App Privacy formu; analitik varsa bildir; reklam izleme yoksa ATT gerekmez; hesap eklenirse uygulama içi hesap silme; üçüncü taraf girişi eklenirse Sign in with Apple.
**Kalite (2, 4):** çökme yok, gerçek işlev, doğru metadata, destek URL'si, hukuki şablonlarda uyarı.
**HIG:** güvenli alan, 44 pt hedef, Dynamic Type, VoiceOver etiketleri, karanlık/açık mod, kontrast (4,5:1), Reduce Motion, sistem paylaşım menüsü.
**Doğrulanacak:** App Store Connect'te "2 hafta" deneme seçeneğinin listelendiği. Apple kuralları değişir; gönderimden önce resmi metinleri oku.

---

## 9. Teknik mimari (Flutter)

```
lib/
  core/        tema belirteçleri, animasyon yardımcıları, biçimlendirme (para, yüzde, ay)
  engines/     calc_engine.dart, doc_engine.dart, list_engine.dart
  tools/       tool_def.dart (ToolDef, FieldDef) + 10 kategori tanımı (45 araç)
  project/     project_store.dart, field_mapper.dart (etiket eşleştirme)
  billing/     entitlement.dart (deneme, günlük hak, plan), paywall
  features/    welcome, home, tool_screen, project, paywall, limit, favorites, profile
  l10n/        app_en.arb (sonra es, pt, tr, ar)
test/          formüller, şablon motoru, alan eşleştirme, günlük hak mantığı
```

**Katmanlar**
1. **Araç tanımı:** kategori, ad, tür (calc, doc, list), alanlar (anahtar, etiket, varsayılan, tür), çıktı şablonu ya da formüller.
2. **Motorlar:** `CalcEngine` (formül, biçim), `DocEngine` (`{alan}` yer tutucuları, `{=ifade}` hesapları, seçim kutusuna göre şablon), `ListEngine` (aşamalar, ekle, ilerlet, sil, toplam).
3. **Proje deposu ve eşleştirici.**
4. **Yetki katmanı:** durum = deneme / ücretsiz / abone; günlük hak (tarih + araç adı).
5. **UI:** ortak bileşenler (araç kartı, form alanı, sonuç satırı, liste öğesi, halka, sürgü).

**Paketler (öneri):** Riverpod (state), shared_preferences (proje, favoriler, yetki), Hive ya da Isar (listeler), `flutter_localizations` + `.arb`, `purchases_flutter` (RevenueCat), Firebase Analytics ya da PostHog, `flutter_animate`, `share_plus`.

**Analitik olayları:** onboarding hedefi seçildi, proje kuruldu, araç açıldı, çıktı kopyalandı, paywall görüldü, plan seçildi, deneme başladı, abone olundu, iptal edildi.

**Prototipten taşınacaklar:** 45 araç tanımı, formüller, eşleştirme kuralları, tasarım belirteçleri.

---

## 10. Yol haritası

| Aşama | Tarih | Hedef |
|---|---|---|
| Sprint 1 | 19–25 Eki | İskelet, tema, araç modeli, motorlar, birim testleri |
| Sprint 2 | 26 Eki–8 Kas | 45 araç ve araç ekranları |
| Sprint 3 | 9–15 Kas | Home, proje alanı, onboarding, favoriler, profil |
| Sprint 4 | 16–22 Kas | Abonelik, paywall, günlük hak, analitik |
| Sprint 5 | 23–29 Kas | Cilalama, erişilebilirlik, test, mağaza hazırlığı |
| Beta ve gönderim | 30 Kas–6 Ara | TestFlight, düzeltmeler, gönderim |

Tarihler tahmindir; Sprint 2 sonunda ilerleme gözden geçirilir, gerekirse bazı araçlar v1.1'e ertelenir.

### Sprint görevleri
**Sprint 1:** Flutter projesi ve lint · tema belirteçleri (koyu/açık) · `ToolDef`/`FieldDef` · `CalcEngine` · `DocEngine` · yerel depolama · formül testleri (runway, LTV/CAC, cap table, A/B, fatura toplamı).
**Sprint 2:** ortak araç ekranı · 8 hesaplayıcı · 23 metin üretici · 14 liste · örnek verilerle açılış.
**Sprint 3:** Home (Launch path, Next best step, Start here) · onboarding · proje alanı ve otomatik doldurma · favoriler · profil.
**Sprint 4:** RevenueCat ürünleri (aylık, yıllık, 2 haftalık tanıtım teklifi) · paywall · günlük hak · analitik · "Demo" bağlantılarının kaldırılması.
**Sprint 5:** Dynamic Type, VoiceOver, Reduce Motion, küçük ekran testi · gizlilik politikası ve şartlar · mağaza metni, ekran görüntüleri, ikon · iç test.

---

## 11. Gönderim öncesi kontrol listesi

- [ ] Uygulama adı, ikon, alt başlık, açıklama (abonelik ve otomatik yenileme dahil)
- [ ] Terms of Use, Privacy Policy, destek URL'leri
- [ ] Abonelik grubu, ürünler, 2 haftalık tanıtım teklifi, yerelleştirme
- [ ] App Privacy formu, yaş anketi
- [ ] Fiyatlar StoreKit'ten; Restore Purchases sandbox'ta test edildi
- [ ] Demo bağlantıları kaldırıldı
- [ ] Dynamic Type, VoiceOver, Reduce Motion, karanlık/açık mod, küçük ekran
- [ ] TestFlight iç ve dış test
- [ ] İncelemeciye not: "Giriş gerekmez. Abonelik sandbox ile test edilebilir."

---

## 12. Riskler

| Risk | Önlem |
|---|---|
| Hukuki şablonlar tavsiye gibi algılanır | Her çıktıda uyarı; mağaza metninde belirt |
| Abonelik kuralları nedeniyle ret | Paywall'da fiyat, süre, yenileme, Restore; gönderim öncesi güncel kılavuz |
| 45 aracın kalite farkı | Önce en çok kullanılacak 12 aracı cilala |
| Yerel veri kaybı | v1'de belirt; yedekleme ve senkron v1.1 |
| Kapsam geniş, takvim dar | Sprint 2 sonunda gözden geçir |
| Şablon çıktıları "sıradan" bulunur | AI destekli üretimi premium değer olarak planla |

---

## 13. Yayın sonrası (v1.1+)

1. PDF dışa aktarma (ücretli)
2. Davet sistemi ve filigran
3. Çoklu proje
4. Yeni diller: İspanyolca, Portekizce, Türkçe, Arapça (RTL)
5. AI destekli üretim (premium)
6. Hesap ve bulut senkronu
7. Kullanıcı şablonları pazaryeri

---

## 14. Açık kararlar

Tümü karara bağlandı (20 Ekim 2026):

1. Uygulama adı ve ikon: **Startup Toolkits**, ikon hazır
2. Fiyatlar: **aylık 6,99 $ / yıllık 49,99 $**, 14 günlük tanıtım teklifi
3. Deneme türü: **uygulama içi 14 gün** (uygunsa mağaza tanıtım teklifi de sunulur)
4. Ücretsiz plan kuralı: **günde 1 araç**, yerel gece yarısı sıfırlanır
5. Açık tema: **tasarlandı**; Profil → Görünüm: Sistem / Koyu / Açık
6. Platformlar: **iOS ve Android birlikte**
7. Analitik: **v1'de yok**; veri cihazdan çıkmaz (satın alımlar hariç)

---

## 15. Claude Code başlangıç komutu (kodlamaya geçiş)

Aşağıdaki metni Flutter projesi klasöründe Claude Code'a ver:

```
Bu dosya (Startup-Cebimde-Master-Plan.md) projenin tek kaynağıdır. Önce tamamını oku.

Görev: Sprint 1'i yap.
1. `flutter create` ile iOS öncelikli bir Flutter projesi aç (paket adı: yer tutucu).
2. Bölüm 9'daki klasör yapısını kur.
3. Bölüm 7.1–7.2'deki tema belirteçlerini koyu tema olarak `core/` altında tanımla; açık tema için aynı adlarla yer tutucu bırak.
4. `ToolDef` ve `FieldDef` modellerini yaz.
5. `CalcEngine` ve `DocEngine`'i yaz. Bölüm 4'teki formüllerin hepsi için birim testi yaz ve çalıştır. Örnek: nakit 120000, gider 14000, gelir 3500 → runway 11,43 ay.
6. Yerel depolama katmanını (proje, favoriler, yetki) yaz.
7. `flutter analyze` ve `flutter test` temiz geçmeden bitirme; sonucu raporla.

Kurallar: bölüm 14'teki açık kararlar için kendin karar verme, varsayılanı kullan ve not düş. UI'ı bu sprintte yazma. Her adımdan sonra küçük commit.
```
