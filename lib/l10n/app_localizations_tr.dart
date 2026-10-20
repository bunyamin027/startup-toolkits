// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'Startup Toolkits';

  @override
  String get commonSave => 'Kaydet';

  @override
  String get commonAdd => 'Ekle';

  @override
  String get commonCancel => 'İptal';

  @override
  String get commonDelete => 'Sil';

  @override
  String get commonDone => 'Tamam';

  @override
  String get commonBack => 'Geri';

  @override
  String get commonClose => 'Kapat';

  @override
  String get commonCopy => 'Kopyala';

  @override
  String get commonShare => 'Paylaş';

  @override
  String get commonUndo => 'Geri al';

  @override
  String get commonSkip => 'Atla';

  @override
  String get commonContinue => 'Devam et';

  @override
  String get commonMore => 'Diğer';

  @override
  String get commonSeePlans => 'Planları gör';

  @override
  String get commonEdit => 'Düzenle';

  @override
  String get commonCopied => 'Panoya kopyalandı';

  @override
  String get commonLinkMissing => 'Bu bağlantı yayından önce eklenecek.';

  @override
  String commonEditField(String field) {
    return '$field alanını düzenle';
  }

  @override
  String commonExample(String value) {
    return 'ör. $value';
  }

  @override
  String get goalRaiseFunding => 'Yatırım almak';

  @override
  String get goalFirstCustomers => 'İlk müşterileri bulmak';

  @override
  String get goalSetUpCompany => 'Şirketi kurmak';

  @override
  String get goalLaunchApp => 'Uygulamamı yayınlamak';

  @override
  String get categoryIdeaValidation => 'Fikir ve doğrulama';

  @override
  String get categoryFinance => 'Finans';

  @override
  String get categoryInvestors => 'Yatırımcı ilişkileri';

  @override
  String get categoryProduct => 'Ürün ve proje';

  @override
  String get categoryMarketing => 'Pazarlama ve içerik';

  @override
  String get categorySales => 'Satış ve müşteriler';

  @override
  String get categoryLegal => 'Hukuki belgeler';

  @override
  String get categoryTeam => 'Ekip ve İK';

  @override
  String get categoryGrowth => 'Büyüme ve analitik';

  @override
  String get categoryMobileApp => 'Mobil uygulama girişimcileri';

  @override
  String get fieldStartupName => 'Girişim adı';

  @override
  String get fieldOneLiner => 'Tek cümlelik tanım';

  @override
  String get fieldProblem => 'Problem';

  @override
  String get fieldSolution => 'Çözüm';

  @override
  String get fieldTargetCustomer => 'Hedef müşteri';

  @override
  String get fieldMarketSize => 'Pazar büyüklüğü';

  @override
  String get fieldTraction => 'Çekiş gücü';

  @override
  String get fieldAsk => 'İstenen yatırım';

  @override
  String get fieldTeam => 'Ekip';

  @override
  String get fieldContactEmail => 'İletişim e-postası';

  @override
  String get fieldCash => 'Nakit';

  @override
  String get fieldMonthlyExpenses => 'Aylık giderler';

  @override
  String get fieldMonthlyRevenue => 'Aylık gelir';

  @override
  String get hintStartupName => 'ör. Nimbly';

  @override
  String get hintOneLiner =>
      'Ne yaptığınızı ve kimin için yaptığınızı tek cümleyle anlatın';

  @override
  String get hintProblem => 'Müşterilerinizin bugün yaşadığı sorun';

  @override
  String get hintSolution => 'Bu sorunu nasıl çözüyorsunuz';

  @override
  String get hintTargetCustomer => 'Bu sorunu en çok kim yaşıyor';

  @override
  String get hintMarketSize => 'ör. 4 milyar \$ ulaşılabilir pazar';

  @override
  String get hintTraction => 'Kullanıcı sayısı, gelir, büyüme';

  @override
  String get hintAsk => 'ör. 750 bin \$ pre-seed yatırım';

  @override
  String get hintTeam => 'Kurucular ve kilit roller';

  @override
  String get hintContactEmail => 'kurucular@girisiminiz.com';

  @override
  String get hintCash => 'Bugün bankadaki nakit';

  @override
  String get hintMonthlyExpenses => 'Aylık toplam harcama';

  @override
  String get hintMonthlyRevenue => 'Aylık gelir';

  @override
  String get stepIdea => 'Fikir';

  @override
  String get stepValidate => 'Doğrula';

  @override
  String get stepMoney => 'Finans';

  @override
  String get stepPitch => 'Sunum';

  @override
  String get stepLaunch => 'Lansman';

  @override
  String get stepIdeaAction => 'Fikri şekillendir';

  @override
  String get stepValidateAction => 'Müşterilerle konuş';

  @override
  String get stepMoneyAction => 'Nakit ömrünü hesapla';

  @override
  String get stepPitchAction => 'Hikâyeni anlat';

  @override
  String get stepLaunchAction => 'Yayına çık';

  @override
  String get tabHome => 'Ana sayfa';

  @override
  String get tabProject => 'Proje';

  @override
  String get tabMyTools => 'Araçlarım';

  @override
  String get tabProfile => 'Profil';

  @override
  String get introHeroTitle =>
      'Girişiminizin ihtiyaç duyduğu tüm araçlar, tek uygulamada.';

  @override
  String introHeroBody(int count) {
    return 'Fikirden yatırımcıya, hukuki belgelerden pazarlamaya ve lansmana kadar $count hazır araç.';
  }

  @override
  String get introStatTools => 'araç';

  @override
  String get introStatCategories => 'kategori';

  @override
  String get introStatLanguages => 'dil';

  @override
  String get introStatAccounts => 'kayıt gerekmez';

  @override
  String get introAutofillTitle =>
      'Bir kez yazın, tüm araçlar kendini doldursun.';

  @override
  String get introAutofillBody =>
      'Girişiminizin adı ve hikâyesi yatırımcı sunumuna, sözleşmelere ve faturalara kendiliğinden aktarılır.';

  @override
  String get introNumbersTitle => 'Yatırımcılar sormadan rakamlarınızı bilin.';

  @override
  String get introNumbersBody =>
      'Nakit ömrü, birim ekonomisi ve değerleme siz yazdıkça güncellenir.';

  @override
  String get introPrivate => 'Hesap yok. Verileriniz cihazınızda kalır.';

  @override
  String get introGetStarted => 'Hadi başlayalım';

  @override
  String introStep(int current, int total) {
    return 'Adım $current / $total';
  }

  @override
  String get welcomeGoalTitle => 'Hedefiniz ne?';

  @override
  String get welcomeGoalSubtitle =>
      'Size uygun araçları öne çıkaralım. Bunu istediğiniz zaman değiştirebilirsiniz.';

  @override
  String get welcomeGoalRaiseFunding =>
      'Yatırımcı sunumu, nakit ömrü, ortaklık tablosu, yatırımcı listesi';

  @override
  String get welcomeGoalFirstCustomers =>
      'Müşteri görüşmeleri, açılış sayfası, CRM, fiyatlandırma';

  @override
  String get welcomeGoalSetUpCompany =>
      'NDA, gizlilik politikası, sözleşmeler, faturalar';

  @override
  String get welcomeGoalLaunchApp =>
      'Mağaza sayfası, ASO anahtar kelimeleri, uygulama gizlilik politikası';

  @override
  String get welcomeNameTitle => 'Girişiminizi tanıtın';

  @override
  String get welcomeNameSubtitle =>
      'Tüm araçlar bu bilgilerle otomatik doldurulur; yalnızca bir kez yazmanız yeterli.';

  @override
  String get welcomeOneLinerHint =>
      'Serbest çalışanlar için kendi kendine işleyen muhasebe';

  @override
  String get welcomeSkipForNow => 'Şimdilik atla';

  @override
  String get welcomeStart => 'Başlayalım';

  @override
  String get homeMissionControl => 'KONTROL MERKEZİ';

  @override
  String get homeYourStartup => 'Girişiminiz';

  @override
  String homeSearch(int count) {
    return '$count aracı ara';
  }

  @override
  String get homeSearchLabel => 'Araçları ara';

  @override
  String get homeLaunchPath => 'Lansman yolu';

  @override
  String homeLaunchPathProgress(int percent) {
    return 'Lansman yolunun yüzde $percent kadarı tamamlandı';
  }

  @override
  String homeStepDone(String step) {
    return '$step: tamamlandı';
  }

  @override
  String homeStepCurrent(String step) {
    return '$step: sıradaki adım';
  }

  @override
  String homeStepTodo(String step) {
    return '$step: başlanmadı';
  }

  @override
  String get homeNextBestStep => 'SIRADAKİ ADIM';

  @override
  String homeNextAdds(String fields) {
    return 'Eklenecekler: $fields';
  }

  @override
  String homeNextFinish(String step) {
    return '$step adımını tamamlamak için açın';
  }

  @override
  String get homePathComplete =>
      'Lansman yolu tamamlandı. Büyüdükçe rakamlarınızı ve hikâyenizi güncel tutun.';

  @override
  String get homeStartHere => 'Buradan başlayın';

  @override
  String homeStartHereGoal(String goal) {
    return 'Buradan başlayın · $goal';
  }

  @override
  String get homeRecentlyUsed => 'Son kullanılanlar';

  @override
  String homeBrowseAll(int count) {
    return 'Tüm araçlara göz at ($count)';
  }

  @override
  String get homeTrialEnded => 'Deneme süreniz bitti';

  @override
  String get homeTrialEndedBody =>
      'Her gün bir aracı ücretsiz kullanın ya da tüm araçların kilidini açın.';

  @override
  String planTrialBadge(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Deneme · $days gün kaldı',
      one: 'Deneme · 1 gün kaldı',
    );
    return '$_temp0';
  }

  @override
  String get planFree => 'Ücretsiz plan';

  @override
  String get planPro => 'Pro';

  @override
  String catalogTitle(int count) {
    return 'Tüm araçlar ($count)';
  }

  @override
  String get catalogNoResults => 'Aramanızla eşleşen araç yok.';

  @override
  String get myToolsTitle => 'Araçlarım';

  @override
  String get myToolsFavorites => 'Favoriler';

  @override
  String get myToolsFavoritesEmpty =>
      'Bir aracı burada görmek için içindeki yıldıza dokunun.';

  @override
  String get myToolsRecentEmpty => 'Açtığınız araçlar burada görünür.';

  @override
  String get projectTitle => 'Proje';

  @override
  String get projectNameEmpty => 'Girişiminize bir ad verin';

  @override
  String get projectOneLinerEmpty => 'Tek cümlelik bir tanım ekleyin';

  @override
  String get projectSetGoal => 'Hedef belirle';

  @override
  String projectFilledSemantics(int filled, int total) {
    return '$total alandan $filled tanesi dolu';
  }

  @override
  String get projectFieldsFilled => 'Dolu alanlar';

  @override
  String get projectFieldsFilledBody =>
      'Tüm araçlar bu alanlarla otomatik doldurulur.';

  @override
  String get projectCopyBrief => 'Proje özetini kopyala';

  @override
  String get projectUnlockMore => 'Ekledikçe daha fazlası açılır';

  @override
  String get projectDetails => 'Proje ayrıntıları';

  @override
  String get projectToolsUsing => 'Projenizi kullanan araçlar';

  @override
  String projectToolFill(int filled, int total) {
    return '$total alandan $filled tanesi projenizden geliyor';
  }

  @override
  String get projectShowFewer => 'Daha az göster';

  @override
  String projectShowAll(int count) {
    return 'Tümünü göster ($count)';
  }

  @override
  String get profileTitle => 'Profil';

  @override
  String get profilePlan => 'Plan';

  @override
  String profilePlanTrial(int days, int tools) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Ücretsiz deneme boyunca $tools aracın tümü açık. $days gün kaldı.',
      one: 'Ücretsiz deneme boyunca $tools aracın tümü açık. 1 gün kaldı.',
    );
    return '$_temp0';
  }

  @override
  String get profilePlanFree =>
      'Ücretsiz plan: günde bir araç. Proje ve ilk kurulum her zaman ücretsiz.';

  @override
  String get profilePlanPro => 'Pro: tüm araçlar, her gün.';

  @override
  String get profileManageSubscription => 'Aboneliği yönet';

  @override
  String get profilePreferences => 'Tercihler';

  @override
  String get profileGoal => 'Hedef';

  @override
  String get profileNotSet => 'Belirlenmedi';

  @override
  String get profileLanguage => 'Dil';

  @override
  String get profileLanguageSystem => 'Sistem varsayılanı';

  @override
  String get profileAppearance => 'Görünüm';

  @override
  String get profileAppearanceSystem => 'Sistem varsayılanı';

  @override
  String get profileAppearanceDark => 'Koyu';

  @override
  String get profileAppearanceLight => 'Açık';

  @override
  String get profileMotion => 'Hareket';

  @override
  String get profileMotionValue => 'Sistem ayarını izler';

  @override
  String get profileMotionNote =>
      'Animasyonları durdurmak için sistem ayarlarında Hareketi Azalt seçeneğini açın.';

  @override
  String get profileYourData => 'Verileriniz';

  @override
  String get profileStoredOnDevice => 'Bu cihazda saklanır';

  @override
  String get profileStoredOnDeviceNote =>
      'Hesap yok, sunucu yok. Uygulamayı silerseniz verileriniz de silinir.';

  @override
  String get profileDeleteAll => 'Tüm verileri sil';

  @override
  String get profileDeleteAllTitle => 'Tüm veriler silinsin mi?';

  @override
  String get profileDeleteAllBody =>
      'Projeniz, araçlara girdiğiniz bilgiler, listeleriniz ve favorileriniz bu cihazdan silinecek. Bu işlem geri alınamaz.';

  @override
  String get profileAbout => 'Hakkında';

  @override
  String get profileRestore => 'Satın almaları geri yükle';

  @override
  String get profileSupport => 'Destek ve geri bildirim';

  @override
  String get profileDeveloper => 'Geliştirici';

  @override
  String profileVersion(String version) {
    return 'Sürüm $version';
  }

  @override
  String get profileLegalNote =>
      'Hukuki şablonlar hukuki danışmanlık yerine geçmez.';

  @override
  String get purchasesUnavailable => 'Satın alma şu anda kullanılamıyor.';

  @override
  String get restoreSuccess => 'Abonelik geri yüklendi.';

  @override
  String get restoreNothing => 'Bu hesapta etkin bir abonelik bulunamadı.';

  @override
  String get termsOfUse => 'Kullanım Koşulları (EULA)';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get paywallTitle => 'Tüm araçlar.\nHer gün.';

  @override
  String paywallBenefitAll(int count) {
    return '$count aracın tamamı, sınırsız';
  }

  @override
  String get paywallBenefitAutofill =>
      'Projenizdeki bilgilerle otomatik dolan sunumlar, belgeler ve hesaplar';

  @override
  String get paywallBenefitPrivate => 'Verileriniz cihazınızda kalır';

  @override
  String get paywallUnavailable =>
      'Abonelikler şu anda kullanılamıyor. Lütfen daha sonra tekrar deneyin.';

  @override
  String get paywallPreview =>
      'Önizleme mağazası: örnek fiyatlar, gerçek ödeme alınmaz.';

  @override
  String get paywallYearly => 'Yıllık';

  @override
  String get paywallMonthly => 'Aylık';

  @override
  String paywallSave(int percent) {
    return '%$percent indirim';
  }

  @override
  String paywallDaysFree(int days) {
    return '$days gün ücretsiz';
  }

  @override
  String get paywallSubscribe => 'Abone ol';

  @override
  String paywallSubscribeFor(String price) {
    return '$price ile abone ol';
  }

  @override
  String paywallStartTrial(int days) {
    return '$days günlük ücretsiz denemeyi başlat';
  }

  @override
  String paywallPerYear(String price) {
    return '$price/yıl';
  }

  @override
  String paywallPerMonth(String price) {
    return '$price/ay';
  }

  @override
  String paywallTermsTrialYearly(int days, String price) {
    return '$days gün ücretsiz, ardından yıllık $price.';
  }

  @override
  String paywallTermsTrialMonthly(int days, String price) {
    return '$days gün ücretsiz, ardından aylık $price.';
  }

  @override
  String paywallTermsYearly(String price) {
    return 'Yıllık $price.';
  }

  @override
  String paywallTermsMonthly(String price) {
    return 'Aylık $price.';
  }

  @override
  String paywallTermsRenewal(String store) {
    return 'Abonelik, geçerli dönemin bitiminden en az 24 saat önce iptal edilmezse otomatik olarak yenilenir. Aboneliğinizi istediğiniz zaman $store hesap ayarlarınızdan yönetebilir veya iptal edebilirsiniz.';
  }

  @override
  String get paywallRestore => 'Satın Almaları Geri Yükle';

  @override
  String get paywallSuccess => 'Tüm araçların kilidi açıldı. İyi çalışmalar!';

  @override
  String get paywallFailed =>
      'Satın alma tamamlanamadı. Lütfen tekrar deneyin.';

  @override
  String limitCountdown(int hours, int minutes) {
    return '$hours sa $minutes dk';
  }

  @override
  String limitCountdownSemantics(int hours, int minutes) {
    return 'Sıradaki ücretsiz araca $hours saat $minutes dakika var';
  }

  @override
  String get limitToReset => 'sonra yenilenir';

  @override
  String get limitTitle => 'Bugünkü ücretsiz aracınızı kullandınız';

  @override
  String get limitBody =>
      'Ücretsiz planda günde bir araç açılır. Projeniz her zaman ücretsiz.';

  @override
  String limitBodyTool(String tool) {
    return '$tool gün boyunca açık kalır. Ücretsiz planda günde bir araç açılır; projeniz her zaman ücretsiz.';
  }

  @override
  String get limitGoUnlimited => 'Sınırsız kullan';

  @override
  String get limitTomorrow => 'Yarın tekrar gelin';

  @override
  String get toolLocked => 'Ücretsiz planda kilitli';

  @override
  String get toolNotFound => 'Araç bulunamadı';

  @override
  String get toolResetDone => 'Örnek verilere dönüldü';

  @override
  String get toolReset => 'Örnek verilere dön';

  @override
  String get toolFavoriteAdd => 'Favorilere ekle';

  @override
  String get toolFavoriteRemove => 'Favorilerden çıkar';

  @override
  String get toolProjectUpToDate => 'Proje zaten güncel';

  @override
  String toolSavedFields(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alan projenize kaydedildi',
      one: '1 alan projenize kaydedildi',
    );
    return '$_temp0';
  }

  @override
  String get toolSaveToProject => 'Projeye kaydet';

  @override
  String get toolInputs => 'Girdiler';

  @override
  String get toolResult => 'Sonuç';

  @override
  String get listAll => 'Tümü';

  @override
  String listAddItem(String item) {
    return '$item ekle';
  }

  @override
  String listNewItem(String item) {
    return 'Yeni $item';
  }

  @override
  String listEditItem(String item) {
    return '$item kaydını düzenle';
  }

  @override
  String listDeleted(String title) {
    return '“$title” silindi';
  }

  @override
  String listMoveTo(String stage) {
    return '$stage aşamasına taşı';
  }

  @override
  String get listFinalStage => 'Son aşama';

  @override
  String get listEmpty => 'Henüz kayıt yok. Başlamak için Ekle’ye dokunun.';

  @override
  String listEmptyStage(String stage) {
    return '$stage aşamasında kayıt yok.';
  }

  @override
  String get listCopy => 'Listeyi kopyala';

  @override
  String get listStage => 'Aşama';
}
