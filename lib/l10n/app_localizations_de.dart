// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Startup Toolkits';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonAdd => 'Hinzufügen';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonDone => 'Fertig';

  @override
  String get commonBack => 'Zurück';

  @override
  String get commonClose => 'Schließen';

  @override
  String get commonCopy => 'Kopieren';

  @override
  String get commonShare => 'Teilen';

  @override
  String get commonUndo => 'Rückgängig';

  @override
  String get commonSkip => 'Überspringen';

  @override
  String get commonContinue => 'Weiter';

  @override
  String get commonMore => 'Mehr';

  @override
  String get commonSeePlans => 'Tarife ansehen';

  @override
  String get commonEdit => 'Bearbeiten';

  @override
  String get commonCopied => 'In die Zwischenablage kopiert';

  @override
  String get commonLinkMissing => 'Dieser Link wird vor dem Release ergänzt.';

  @override
  String commonEditField(String field) {
    return '$field bearbeiten';
  }

  @override
  String commonExample(String value) {
    return 'z. B. $value';
  }

  @override
  String get goalRaiseFunding => 'Kapital aufnehmen';

  @override
  String get goalFirstCustomers => 'Erste Kunden finden';

  @override
  String get goalSetUpCompany => 'Firma gründen';

  @override
  String get goalLaunchApp => 'Meine App launchen';

  @override
  String get categoryIdeaValidation => 'Idee & Validierung';

  @override
  String get categoryFinance => 'Finanzen';

  @override
  String get categoryInvestors => 'Investor Relations';

  @override
  String get categoryProduct => 'Produkt & Projekt';

  @override
  String get categoryMarketing => 'Marketing & Content';

  @override
  String get categorySales => 'Vertrieb & Kunden';

  @override
  String get categoryLegal => 'Recht & Dokumente';

  @override
  String get categoryTeam => 'Team & HR';

  @override
  String get categoryGrowth => 'Wachstum & Analytics';

  @override
  String get categoryMobileApp => 'Gründer mobiler Apps';

  @override
  String get fieldStartupName => 'Name des Startups';

  @override
  String get fieldOneLiner => 'Beschreibung in einem Satz';

  @override
  String get fieldProblem => 'Problem';

  @override
  String get fieldSolution => 'Lösung';

  @override
  String get fieldTargetCustomer => 'Zielkunde';

  @override
  String get fieldMarketSize => 'Marktgröße';

  @override
  String get fieldTraction => 'Traktion';

  @override
  String get fieldAsk => 'Kapitalbedarf';

  @override
  String get fieldTeam => 'Team';

  @override
  String get fieldContactEmail => 'Kontakt-E-Mail';

  @override
  String get fieldCash => 'Liquidität';

  @override
  String get fieldMonthlyExpenses => 'Monatliche Ausgaben';

  @override
  String get fieldMonthlyRevenue => 'Monatlicher Umsatz';

  @override
  String get hintStartupName => 'z. B. Nimbly';

  @override
  String get hintOneLiner => 'Was ihr macht und für wen, in einem Satz';

  @override
  String get hintProblem => 'Der Schmerz, den eure Kunden heute spüren';

  @override
  String get hintSolution => 'Wie ihr diesen Schmerz beseitigt';

  @override
  String get hintTargetCustomer => 'Wer das Problem am stärksten hat';

  @override
  String get hintMarketSize => 'z. B. 4 Mrd. \$ adressierbarer Markt';

  @override
  String get hintTraction => 'Nutzer, Umsatz, Wachstum';

  @override
  String get hintAsk => 'z. B. 750.000 \$ Pre-Seed';

  @override
  String get hintTeam => 'Gründer und Schlüsselrollen';

  @override
  String get hintContactEmail => 'gruender@euerstartup.com';

  @override
  String get hintCash => 'Aktueller Kontostand';

  @override
  String get hintMonthlyExpenses => 'Gesamtausgaben pro Monat';

  @override
  String get hintMonthlyRevenue => 'Umsatz pro Monat';

  @override
  String get stepIdea => 'Idee';

  @override
  String get stepValidate => 'Validieren';

  @override
  String get stepMoney => 'Geld';

  @override
  String get stepPitch => 'Pitch';

  @override
  String get stepLaunch => 'Launch';

  @override
  String get stepIdeaAction => 'Idee schärfen';

  @override
  String get stepValidateAction => 'Mit Kunden sprechen';

  @override
  String get stepMoneyAction => 'Runway kennen';

  @override
  String get stepPitchAction => 'Die Story erzählen';

  @override
  String get stepLaunchAction => 'Live gehen';

  @override
  String get tabHome => 'Start';

  @override
  String get tabProject => 'Projekt';

  @override
  String get tabMyTools => 'Meine Tools';

  @override
  String get tabProfile => 'Profil';

  @override
  String get introHeroTitle =>
      'Alle Tools, die dein Startup braucht. In einer App.';

  @override
  String introHeroBody(int count) {
    return '$count fertige Tools für Idee, Finanzen, Investoren, Verträge, Marketing und Launch.';
  }

  @override
  String get introStatTools => 'Tools';

  @override
  String get introStatCategories => 'Kategorien';

  @override
  String get introStatLanguages => 'Sprachen';

  @override
  String get introStatAccounts => 'Anmeldungen nötig';

  @override
  String get introAutofillTitle =>
      'Einmal eintippen. Jedes Tool füllt sich selbst.';

  @override
  String get introAutofillBody =>
      'Name und Story deines Startups landen automatisch in Pitch Decks, Verträgen und Rechnungen.';

  @override
  String get introNumbersTitle =>
      'Kenne deine Zahlen, bevor Investoren fragen.';

  @override
  String get introNumbersBody =>
      'Runway, Unit Economics und Bewertung aktualisieren sich beim Tippen.';

  @override
  String get introPrivate =>
      'Kein Konto. Deine Daten bleiben auf deinem Gerät.';

  @override
  String get introGetStarted => 'Los geht’s';

  @override
  String introStep(int current, int total) {
    return 'Schritt $current von $total';
  }

  @override
  String get welcomeGoalTitle => 'Worauf arbeitest du hin?';

  @override
  String get welcomeGoalSubtitle =>
      'Wir zeigen dir zuerst die passenden Tools. Du kannst das jederzeit ändern.';

  @override
  String get welcomeGoalRaiseFunding =>
      'Pitch Deck, Runway, Cap Table, Investoren-Pipeline';

  @override
  String get welcomeGoalFirstCustomers =>
      'Interviews, Landingpage, CRM, Preise';

  @override
  String get welcomeGoalSetUpCompany =>
      'NDA, Datenschutzerklärung, Verträge, Rechnungen';

  @override
  String get welcomeGoalLaunchApp =>
      'Store-Eintrag, ASO-Keywords, Datenschutzerklärung';

  @override
  String get welcomeNameTitle => 'Erzähl uns von deinem Startup';

  @override
  String get welcomeNameSubtitle =>
      'Jedes Tool füllt sich damit aus – du tippst es nur einmal.';

  @override
  String get welcomeOneLinerHint =>
      'Buchhaltung, die sich selbst erledigt, für Freelancer';

  @override
  String get welcomeSkipForNow => 'Vorerst überspringen';

  @override
  String get welcomeStart => 'Loslegen';

  @override
  String get homeMissionControl => 'MISSION CONTROL';

  @override
  String get homeYourStartup => 'Dein Startup';

  @override
  String homeSearch(int count) {
    return '$count Tools durchsuchen';
  }

  @override
  String get homeSearchLabel => 'Tools durchsuchen';

  @override
  String get homeLaunchPath => 'Launch-Pfad';

  @override
  String homeLaunchPathProgress(int percent) {
    return 'Launch-Pfad zu $percent Prozent abgeschlossen';
  }

  @override
  String homeStepDone(String step) {
    return '$step: erledigt';
  }

  @override
  String homeStepCurrent(String step) {
    return '$step: aktueller Schritt';
  }

  @override
  String homeStepTodo(String step) {
    return '$step: nicht begonnen';
  }

  @override
  String get homeNextBestStep => 'NÄCHSTER SCHRITT';

  @override
  String homeNextAdds(String fields) {
    return 'Ergänzt $fields';
  }

  @override
  String homeNextFinish(String step) {
    return 'Öffnen, um den Schritt $step abzuschließen';
  }

  @override
  String get homePathComplete =>
      'Launch-Pfad abgeschlossen. Halte Zahlen und Story aktuell, während du wächst.';

  @override
  String get homeStartHere => 'Hier starten';

  @override
  String homeStartHereGoal(String goal) {
    return 'Hier starten · $goal';
  }

  @override
  String get homeRecentlyUsed => 'Zuletzt verwendet';

  @override
  String homeBrowseAll(int count) {
    return 'Alle $count Tools ansehen';
  }

  @override
  String get homeTrialEnded => 'Deine Testphase ist beendet';

  @override
  String get homeTrialEndedBody =>
      'Öffne kostenlos ein Tool pro Tag oder schalte alle frei.';

  @override
  String planTrialBadge(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Test · noch $days Tage',
      one: 'Test · noch 1 Tag',
    );
    return '$_temp0';
  }

  @override
  String get planFree => 'Gratis-Tarif';

  @override
  String get planPro => 'Pro';

  @override
  String catalogTitle(int count) {
    return 'Alle $count Tools';
  }

  @override
  String get catalogNoResults => 'Keine Tools passen zu deiner Suche.';

  @override
  String get myToolsTitle => 'Meine Tools';

  @override
  String get myToolsFavorites => 'Favoriten';

  @override
  String get myToolsFavoritesEmpty =>
      'Tippe in einem Tool auf den Stern, um es hier zu behalten.';

  @override
  String get myToolsRecentEmpty => 'Tools, die du öffnest, erscheinen hier.';

  @override
  String get projectTitle => 'Projekt';

  @override
  String get projectNameEmpty => 'Gib deinem Startup einen Namen';

  @override
  String get projectOneLinerEmpty =>
      'Füge eine Beschreibung in einem Satz hinzu';

  @override
  String get projectSetGoal => 'Ziel festlegen';

  @override
  String projectFilledSemantics(int filled, int total) {
    return '$filled von $total Feldern ausgefüllt';
  }

  @override
  String get projectFieldsFilled => 'Ausgefüllte Felder';

  @override
  String get projectFieldsFilledBody =>
      'Jedes Tool füllt sich aus diesen Feldern.';

  @override
  String get projectCopyBrief => 'Projektsteckbrief kopieren';

  @override
  String get projectUnlockMore => 'Ergänzen, um mehr freizuschalten';

  @override
  String get projectDetails => 'Projektdetails';

  @override
  String get projectToolsUsing => 'Tools, die dein Projekt nutzen';

  @override
  String projectToolFill(int filled, int total) {
    return '$filled von $total Feldern aus deinem Projekt';
  }

  @override
  String get projectShowFewer => 'Weniger anzeigen';

  @override
  String projectShowAll(int count) {
    return 'Alle $count anzeigen';
  }

  @override
  String get profileTitle => 'Profil';

  @override
  String get profilePlan => 'Tarif';

  @override
  String profilePlanTrial(int days, int tools) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Während der Testphase sind alle $tools Tools offen. Noch $days Tage.',
      one: 'Während der Testphase sind alle $tools Tools offen. Noch 1 Tag.',
    );
    return '$_temp0';
  }

  @override
  String get profilePlanFree =>
      'Gratis-Tarif: ein Tool pro Tag. Projekt und Einstieg bleiben kostenlos.';

  @override
  String get profilePlanPro => 'Pro: jedes Tool, jeden Tag.';

  @override
  String get profileManageSubscription => 'Abo verwalten';

  @override
  String get profilePreferences => 'Einstellungen';

  @override
  String get profileGoal => 'Ziel';

  @override
  String get profileNotSet => 'Nicht festgelegt';

  @override
  String get profileLanguage => 'Sprache';

  @override
  String get profileLanguageSystem => 'Systemsprache';

  @override
  String get profileAppearance => 'Darstellung';

  @override
  String get profileAppearanceSystem => 'Wie System';

  @override
  String get profileAppearanceDark => 'Dunkel';

  @override
  String get profileAppearanceLight => 'Hell';

  @override
  String get profileMotion => 'Bewegung';

  @override
  String get profileMotionValue => 'Wie System';

  @override
  String get profileMotionNote =>
      'Aktiviere „Bewegung reduzieren“ in den Systemeinstellungen, um Animationen zu stoppen.';

  @override
  String get profileYourData => 'Deine Daten';

  @override
  String get profileStoredOnDevice => 'Auf diesem Gerät gespeichert';

  @override
  String get profileStoredOnDeviceNote =>
      'Kein Konto, kein Server. Wenn du die App löschst, werden deine Daten gelöscht.';

  @override
  String get profileDeleteAll => 'Alle Daten löschen';

  @override
  String get profileDeleteAllTitle => 'Alle Daten löschen?';

  @override
  String get profileDeleteAllBody =>
      'Dein Projekt, Tool-Eingaben, Listen und Favoriten werden von diesem Gerät entfernt. Das kann nicht rückgängig gemacht werden.';

  @override
  String get profileAbout => 'Über';

  @override
  String get profileRestore => 'Käufe wiederherstellen';

  @override
  String get profileSupport => 'Support & Feedback';

  @override
  String get profileDeveloper => 'Entwickler';

  @override
  String profileVersion(String version) {
    return 'Version $version';
  }

  @override
  String get profileLegalNote =>
      'Rechtliche Vorlagen sind keine Rechtsberatung.';

  @override
  String get purchasesUnavailable => 'Käufe sind gerade nicht verfügbar.';

  @override
  String get restoreSuccess => 'Abo wiederhergestellt.';

  @override
  String get restoreNothing =>
      'Für dieses Konto wurde kein aktives Abo gefunden.';

  @override
  String get termsOfUse => 'Nutzungsbedingungen (EULA)';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get paywallTitle => 'Jedes Tool.\nJeden Tag.';

  @override
  String paywallBenefitAll(int count) {
    return 'Alle $count Tools, unbegrenzt';
  }

  @override
  String get paywallBenefitAutofill =>
      'Decks, Dokumente und Zahlen, die sich aus deinem Projekt füllen';

  @override
  String get paywallBenefitPrivate => 'Deine Daten bleiben auf deinem Gerät';

  @override
  String get paywallUnavailable =>
      'Abos sind gerade nicht verfügbar. Bitte versuche es später erneut.';

  @override
  String get paywallPreview =>
      'Vorschau-Store: Beispielpreise, kein echter Kauf.';

  @override
  String get paywallYearly => 'Jährlich';

  @override
  String get paywallMonthly => 'Monatlich';

  @override
  String paywallSave(int percent) {
    return '$percent % sparen';
  }

  @override
  String paywallDaysFree(int days) {
    return '$days Tage gratis';
  }

  @override
  String get paywallSubscribe => 'Abonnieren';

  @override
  String paywallSubscribeFor(String price) {
    return 'Für $price abonnieren';
  }

  @override
  String paywallStartTrial(int days) {
    return '$days Tage gratis testen';
  }

  @override
  String paywallPerYear(String price) {
    return '$price/Jahr';
  }

  @override
  String paywallPerMonth(String price) {
    return '$price/Monat';
  }

  @override
  String paywallTermsTrialYearly(int days, String price) {
    return '$days Tage gratis, danach $price pro Jahr.';
  }

  @override
  String paywallTermsTrialMonthly(int days, String price) {
    return '$days Tage gratis, danach $price pro Monat.';
  }

  @override
  String paywallTermsYearly(String price) {
    return '$price pro Jahr.';
  }

  @override
  String paywallTermsMonthly(String price) {
    return '$price pro Monat.';
  }

  @override
  String paywallTermsRenewal(String store) {
    return 'Verlängert sich automatisch, sofern nicht mindestens 24 Stunden vor Ende des aktuellen Zeitraums gekündigt wird. Verwalte oder kündige jederzeit in den Einstellungen deines $store-Kontos.';
  }

  @override
  String get paywallRestore => 'Käufe wiederherstellen';

  @override
  String get paywallSuccess => 'Alle Tools sind freigeschaltet. Viel Spaß!';

  @override
  String get paywallFailed =>
      'Der Kauf ist nicht durchgegangen. Bitte versuche es erneut.';

  @override
  String limitCountdown(int hours, int minutes) {
    return '$hours Std. $minutes Min.';
  }

  @override
  String limitCountdownSemantics(int hours, int minutes) {
    return '$hours Stunden $minutes Minuten bis zu deinem nächsten Gratis-Tool';
  }

  @override
  String get limitToReset => 'bis zum Reset';

  @override
  String get limitTitle => 'Du hast das heutige Gratis-Tool genutzt';

  @override
  String get limitBody =>
      'Der Gratis-Tarif öffnet ein Tool pro Tag. Dein Projekt bleibt kostenlos.';

  @override
  String limitBodyTool(String tool) {
    return '$tool bleibt den ganzen Tag offen. Der Gratis-Tarif öffnet ein Tool pro Tag; dein Projekt bleibt kostenlos.';
  }

  @override
  String get limitGoUnlimited => 'Unbegrenzt nutzen';

  @override
  String get limitTomorrow => 'Morgen wiederkommen';

  @override
  String get toolLocked => 'Im Gratis-Tarif gesperrt';

  @override
  String get toolNotFound => 'Tool nicht gefunden';

  @override
  String get toolResetDone => 'Beispieldaten wiederhergestellt';

  @override
  String get toolReset => 'Auf Beispiel zurücksetzen';

  @override
  String get toolFavoriteAdd => 'Zu Favoriten hinzufügen';

  @override
  String get toolFavoriteRemove => 'Aus Favoriten entfernen';

  @override
  String get toolProjectUpToDate => 'Projekt ist bereits aktuell';

  @override
  String toolSavedFields(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Felder im Projekt gespeichert',
      one: '1 Feld im Projekt gespeichert',
    );
    return '$_temp0';
  }

  @override
  String get toolSaveToProject => 'Im Projekt speichern';

  @override
  String get toolInputs => 'Eingaben';

  @override
  String get toolResult => 'Ergebnis';

  @override
  String get listAll => 'Alle';

  @override
  String listAddItem(String item) {
    return '$item hinzufügen';
  }

  @override
  String listNewItem(String item) {
    return 'Neu: $item';
  }

  @override
  String listEditItem(String item) {
    return '$item bearbeiten';
  }

  @override
  String listDeleted(String title) {
    return '„$title“ gelöscht';
  }

  @override
  String listMoveTo(String stage) {
    return 'Verschieben nach $stage';
  }

  @override
  String get listFinalStage => 'Letzte Phase';

  @override
  String get listEmpty =>
      'Noch nichts hier. Tippe auf Hinzufügen, um zu starten.';

  @override
  String listEmptyStage(String stage) {
    return 'Nichts in $stage.';
  }

  @override
  String get listCopy => 'Liste kopieren';

  @override
  String get listStage => 'Phase';
}
