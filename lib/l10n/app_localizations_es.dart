// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Startup Toolkits';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonAdd => 'Añadir';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonDone => 'Listo';

  @override
  String get commonBack => 'Atrás';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonCopy => 'Copiar';

  @override
  String get commonShare => 'Compartir';

  @override
  String get commonUndo => 'Deshacer';

  @override
  String get commonSkip => 'Omitir';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonMore => 'Más';

  @override
  String get commonSeePlans => 'Ver planes';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonCopied => 'Copiado al portapapeles';

  @override
  String get commonLinkMissing =>
      'Este enlace se añadirá antes del lanzamiento.';

  @override
  String commonEditField(String field) {
    return 'Editar: $field';
  }

  @override
  String commonExample(String value) {
    return 'p. ej. $value';
  }

  @override
  String get goalRaiseFunding => 'Conseguir financiación';

  @override
  String get goalFirstCustomers => 'Encontrar los primeros clientes';

  @override
  String get goalSetUpCompany => 'Constituir la empresa';

  @override
  String get goalLaunchApp => 'Lanzar mi app';

  @override
  String get categoryIdeaValidation => 'Idea y validación';

  @override
  String get categoryFinance => 'Finanzas';

  @override
  String get categoryInvestors => 'Relación con inversores';

  @override
  String get categoryProduct => 'Producto y proyecto';

  @override
  String get categoryMarketing => 'Marketing y contenido';

  @override
  String get categorySales => 'Ventas y clientes';

  @override
  String get categoryLegal => 'Legal y documentos';

  @override
  String get categoryTeam => 'Equipo y RR. HH.';

  @override
  String get categoryGrowth => 'Crecimiento y analítica';

  @override
  String get categoryMobileApp => 'Fundadores de apps móviles';

  @override
  String get fieldStartupName => 'Nombre de la startup';

  @override
  String get fieldOneLiner => 'Descripción en una frase';

  @override
  String get fieldProblem => 'Problema';

  @override
  String get fieldSolution => 'Solución';

  @override
  String get fieldTargetCustomer => 'Cliente objetivo';

  @override
  String get fieldMarketSize => 'Tamaño de mercado';

  @override
  String get fieldTraction => 'Tracción';

  @override
  String get fieldAsk => 'Lo que pides';

  @override
  String get fieldTeam => 'Equipo';

  @override
  String get fieldContactEmail => 'Correo de contacto';

  @override
  String get fieldCash => 'Caja';

  @override
  String get fieldMonthlyExpenses => 'Gastos mensuales';

  @override
  String get fieldMonthlyRevenue => 'Ingresos mensuales';

  @override
  String get hintStartupName => 'p. ej. Nimbly';

  @override
  String get hintOneLiner => 'Qué haces y para quién, en una frase';

  @override
  String get hintProblem => 'El dolor que sienten hoy tus clientes';

  @override
  String get hintSolution => 'Cómo eliminas ese dolor';

  @override
  String get hintTargetCustomer => 'Quién sufre más el problema';

  @override
  String get hintMarketSize => 'p. ej. mercado servible de 4000 M\$';

  @override
  String get hintTraction => 'Usuarios, ingresos, crecimiento';

  @override
  String get hintAsk => 'p. ej. 750 k\$ pre-seed';

  @override
  String get hintTeam => 'Fundadores y roles clave';

  @override
  String get hintContactEmail => 'fundadores@tustartup.com';

  @override
  String get hintCash => 'Dinero en el banco hoy';

  @override
  String get hintMonthlyExpenses => 'Gasto total al mes';

  @override
  String get hintMonthlyRevenue => 'Ingresos al mes';

  @override
  String get stepIdea => 'Idea';

  @override
  String get stepValidate => 'Validar';

  @override
  String get stepMoney => 'Dinero';

  @override
  String get stepPitch => 'Pitch';

  @override
  String get stepLaunch => 'Lanzar';

  @override
  String get stepIdeaAction => 'Da forma a la idea';

  @override
  String get stepValidateAction => 'Habla con clientes';

  @override
  String get stepMoneyAction => 'Conoce tu runway';

  @override
  String get stepPitchAction => 'Cuenta la historia';

  @override
  String get stepLaunchAction => 'Sal en vivo';

  @override
  String get tabHome => 'Inicio';

  @override
  String get tabProject => 'Proyecto';

  @override
  String get tabMyTools => 'Mis herramientas';

  @override
  String get tabProfile => 'Perfil';

  @override
  String get introHeroTitle =>
      'Todas las herramientas que tu startup necesita. En una sola app.';

  @override
  String introHeroBody(int count) {
    return '$count herramientas listas para tu idea, tus finanzas, tus inversores, tus documentos legales, tu marketing y tu lanzamiento.';
  }

  @override
  String get introStatTools => 'herramientas';

  @override
  String get introStatCategories => 'categorías';

  @override
  String get introStatLanguages => 'idiomas';

  @override
  String get introStatAccounts => 'registros necesarios';

  @override
  String get introAutofillTitle =>
      'Escríbelo una vez. Cada herramienta se rellena sola.';

  @override
  String get introAutofillBody =>
      'El nombre y la historia de tu startup pasan solos a tus pitch decks, contratos y facturas.';

  @override
  String get introNumbersTitle =>
      'Domina tus números antes de que pregunten los inversores.';

  @override
  String get introNumbersBody =>
      'El runway, la economía unitaria y la valoración se actualizan mientras escribes.';

  @override
  String get introPrivate =>
      'Sin cuenta. Tus datos se quedan en tu dispositivo.';

  @override
  String get introGetStarted => 'Empecemos';

  @override
  String introStep(int current, int total) {
    return 'Paso $current de $total';
  }

  @override
  String get welcomeGoalTitle => '¿Hacia qué estás construyendo?';

  @override
  String get welcomeGoalSubtitle =>
      'Pondremos primero las herramientas adecuadas. Puedes cambiarlo cuando quieras.';

  @override
  String get welcomeGoalRaiseFunding =>
      'Pitch deck, runway, cap table, pipeline de inversores';

  @override
  String get welcomeGoalFirstCustomers =>
      'Entrevistas, landing page, CRM, precios';

  @override
  String get welcomeGoalSetUpCompany =>
      'NDA, política de privacidad, contratos, facturas';

  @override
  String get welcomeGoalLaunchApp =>
      'Ficha de la tienda, palabras clave ASO, política de privacidad';

  @override
  String get welcomeNameTitle => 'Háblanos de tu startup';

  @override
  String get welcomeNameSubtitle =>
      'Todas las herramientas se rellenan con esto, así que solo lo escribes una vez.';

  @override
  String get welcomeOneLinerHint =>
      'Contabilidad que se hace sola, para freelancers';

  @override
  String get welcomeSkipForNow => 'Omitir por ahora';

  @override
  String get welcomeStart => 'Empezar';

  @override
  String get homeMissionControl => 'CENTRO DE CONTROL';

  @override
  String get homeYourStartup => 'Tu startup';

  @override
  String homeSearch(int count) {
    return 'Buscar entre $count herramientas';
  }

  @override
  String get homeSearchLabel => 'Buscar herramientas';

  @override
  String get homeLaunchPath => 'Ruta de lanzamiento';

  @override
  String homeLaunchPathProgress(int percent) {
    return 'Ruta de lanzamiento completada al $percent por ciento';
  }

  @override
  String homeStepDone(String step) {
    return '$step: hecho';
  }

  @override
  String homeStepCurrent(String step) {
    return '$step: paso actual';
  }

  @override
  String homeStepTodo(String step) {
    return '$step: sin empezar';
  }

  @override
  String get homeNextBestStep => 'SIGUIENTE MEJOR PASO';

  @override
  String homeNextAdds(String fields) {
    return 'Añade $fields';
  }

  @override
  String homeNextFinish(String step) {
    return 'Ábrelo para terminar el paso $step';
  }

  @override
  String get homePathComplete =>
      'Ruta de lanzamiento completada. Mantén al día tus números y tu historia a medida que creces.';

  @override
  String get homeStartHere => 'Empieza aquí';

  @override
  String homeStartHereGoal(String goal) {
    return 'Empieza aquí · $goal';
  }

  @override
  String get homeRecentlyUsed => 'Usadas recientemente';

  @override
  String homeBrowseAll(int count) {
    return 'Ver las $count herramientas';
  }

  @override
  String get homeTrialEnded => 'Tu prueba ha terminado';

  @override
  String get homeTrialEndedBody =>
      'Abre una herramienta al día gratis o desbloquéalas todas.';

  @override
  String planTrialBadge(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Prueba · quedan $days días',
      one: 'Prueba · queda 1 día',
    );
    return '$_temp0';
  }

  @override
  String get planFree => 'Plan gratuito';

  @override
  String get planPro => 'Pro';

  @override
  String catalogTitle(int count) {
    return 'Las $count herramientas';
  }

  @override
  String get catalogNoResults =>
      'Ninguna herramienta coincide con tu búsqueda.';

  @override
  String get myToolsTitle => 'Mis herramientas';

  @override
  String get myToolsFavorites => 'Favoritas';

  @override
  String get myToolsFavoritesEmpty =>
      'Toca la estrella de cualquier herramienta para guardarla aquí.';

  @override
  String get myToolsRecentEmpty =>
      'Las herramientas que abras aparecerán aquí.';

  @override
  String get projectTitle => 'Proyecto';

  @override
  String get projectNameEmpty => 'Ponle nombre a tu startup';

  @override
  String get projectOneLinerEmpty => 'Añade una descripción en una frase';

  @override
  String get projectSetGoal => 'Definir un objetivo';

  @override
  String projectFilledSemantics(int filled, int total) {
    return '$filled de $total campos completados';
  }

  @override
  String get projectFieldsFilled => 'Campos completados';

  @override
  String get projectFieldsFilledBody =>
      'Todas las herramientas se rellenan con estos campos.';

  @override
  String get projectCopyBrief => 'Copiar resumen del proyecto';

  @override
  String get projectUnlockMore => 'Añade para desbloquear más';

  @override
  String get projectDetails => 'Detalles del proyecto';

  @override
  String get projectToolsUsing => 'Herramientas que usan tu proyecto';

  @override
  String projectToolFill(int filled, int total) {
    return '$filled de $total campos de tu proyecto';
  }

  @override
  String get projectShowFewer => 'Mostrar menos';

  @override
  String projectShowAll(int count) {
    return 'Mostrar todas ($count)';
  }

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profilePlan => 'Plan';

  @override
  String profilePlanTrial(int days, int tools) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Las $tools herramientas están abiertas durante tu prueba gratuita. Quedan $days días.',
      one:
          'Las $tools herramientas están abiertas durante tu prueba gratuita. Queda 1 día.',
    );
    return '$_temp0';
  }

  @override
  String get profilePlanFree =>
      'Plan gratuito: una herramienta al día. El proyecto y la bienvenida siguen siendo gratis.';

  @override
  String get profilePlanPro => 'Pro: todas las herramientas, todos los días.';

  @override
  String get profileManageSubscription => 'Gestionar suscripción';

  @override
  String get profilePreferences => 'Preferencias';

  @override
  String get profileGoal => 'Objetivo';

  @override
  String get profileNotSet => 'Sin definir';

  @override
  String get profileLanguage => 'Idioma';

  @override
  String get profileLanguageSystem => 'Idioma del sistema';

  @override
  String get profileAppearance => 'Apariencia';

  @override
  String get profileAppearanceSystem => 'Según el sistema';

  @override
  String get profileAppearanceDark => 'Oscura';

  @override
  String get profileAppearanceLight => 'Clara';

  @override
  String get profileMotion => 'Movimiento';

  @override
  String get profileMotionValue => 'Sigue al sistema';

  @override
  String get profileMotionNote =>
      'Activa Reducir movimiento en los ajustes del sistema para detener las animaciones.';

  @override
  String get profileYourData => 'Tus datos';

  @override
  String get profileStoredOnDevice => 'Guardados en este dispositivo';

  @override
  String get profileStoredOnDeviceNote =>
      'Sin cuenta ni servidor. Si eliminas la app, se eliminan tus datos.';

  @override
  String get profileDeleteAll => 'Eliminar todos los datos';

  @override
  String get profileDeleteAllTitle => '¿Eliminar todos los datos?';

  @override
  String get profileDeleteAllBody =>
      'Tu proyecto, los datos de las herramientas, tus listas y favoritas se eliminarán de este dispositivo. No se puede deshacer.';

  @override
  String get profileAbout => 'Acerca de';

  @override
  String get profileRestore => 'Restaurar compras';

  @override
  String get profileSupport => 'Soporte y comentarios';

  @override
  String get profileDeveloper => 'Desarrollador';

  @override
  String profileVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get profileLegalNote =>
      'Las plantillas legales no constituyen asesoramiento legal.';

  @override
  String get purchasesUnavailable =>
      'Las compras no están disponibles en este momento.';

  @override
  String get restoreSuccess => 'Suscripción restaurada.';

  @override
  String get restoreNothing =>
      'No se encontró ninguna suscripción activa para esta cuenta.';

  @override
  String get termsOfUse => 'Condiciones de uso (EULA)';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get paywallTitle => 'Cada herramienta.\nCada día.';

  @override
  String paywallBenefitAll(int count) {
    return 'Las $count herramientas, sin límites';
  }

  @override
  String get paywallBenefitAutofill =>
      'Decks, documentos y números que se rellenan solos desde tu proyecto';

  @override
  String get paywallBenefitPrivate => 'Tus datos se quedan en tu dispositivo';

  @override
  String get paywallUnavailable =>
      'Las suscripciones no están disponibles en este momento. Inténtalo de nuevo más tarde.';

  @override
  String get paywallPreview =>
      'Tienda de prueba: precios de ejemplo, sin compra real.';

  @override
  String get paywallYearly => 'Anual';

  @override
  String get paywallMonthly => 'Mensual';

  @override
  String paywallSave(int percent) {
    return 'Ahorra un $percent %';
  }

  @override
  String paywallDaysFree(int days) {
    return '$days días gratis';
  }

  @override
  String get paywallSubscribe => 'Suscribirse';

  @override
  String paywallSubscribeFor(String price) {
    return 'Suscribirse por $price';
  }

  @override
  String paywallStartTrial(int days) {
    return 'Empezar prueba gratuita de $days días';
  }

  @override
  String paywallPerYear(String price) {
    return '$price/año';
  }

  @override
  String paywallPerMonth(String price) {
    return '$price/mes';
  }

  @override
  String paywallTermsTrialYearly(int days, String price) {
    return '$days días gratis y después $price al año.';
  }

  @override
  String paywallTermsTrialMonthly(int days, String price) {
    return '$days días gratis y después $price al mes.';
  }

  @override
  String paywallTermsYearly(String price) {
    return '$price al año.';
  }

  @override
  String paywallTermsMonthly(String price) {
    return '$price al mes.';
  }

  @override
  String paywallTermsRenewal(String store) {
    return 'Se renueva automáticamente salvo que se cancele al menos 24 horas antes del final del periodo actual. Gestiona o cancela cuando quieras en los ajustes de tu cuenta de $store.';
  }

  @override
  String get paywallRestore => 'Restaurar compras';

  @override
  String get paywallSuccess =>
      'Todas las herramientas están desbloqueadas. ¡Disfrútalas!';

  @override
  String get paywallFailed => 'La compra no se completó. Inténtalo de nuevo.';

  @override
  String limitCountdown(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String limitCountdownSemantics(int hours, int minutes) {
    return '$hours horas $minutes minutos para tu próxima herramienta gratis';
  }

  @override
  String get limitToReset => 'para reiniciar';

  @override
  String get limitTitle => 'Ya usaste la herramienta gratis de hoy';

  @override
  String get limitBody =>
      'El plan gratuito abre una herramienta al día. Tu proyecto sigue siendo gratis.';

  @override
  String limitBodyTool(String tool) {
    return '$tool sigue abierta todo el día. El plan gratuito abre una herramienta al día; tu proyecto sigue siendo gratis.';
  }

  @override
  String get limitGoUnlimited => 'Pasar a ilimitado';

  @override
  String get limitTomorrow => 'Vuelve mañana';

  @override
  String get toolLocked => 'Bloqueada en el plan gratuito';

  @override
  String get toolNotFound => 'Herramienta no encontrada';

  @override
  String get toolResetDone => 'Se restauraron los datos de ejemplo';

  @override
  String get toolReset => 'Restablecer ejemplo';

  @override
  String get toolFavoriteAdd => 'Añadir a favoritas';

  @override
  String get toolFavoriteRemove => 'Quitar de favoritas';

  @override
  String get toolProjectUpToDate => 'El proyecto ya está al día';

  @override
  String toolSavedFields(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count campos guardados en tu proyecto',
      one: '1 campo guardado en tu proyecto',
    );
    return '$_temp0';
  }

  @override
  String get toolSaveToProject => 'Guardar en el proyecto';

  @override
  String get toolInputs => 'Datos';

  @override
  String get toolResult => 'Resultado';

  @override
  String get listAll => 'Todo';

  @override
  String listAddItem(String item) {
    return 'Añadir: $item';
  }

  @override
  String listNewItem(String item) {
    return 'Nuevo: $item';
  }

  @override
  String listEditItem(String item) {
    return 'Editar: $item';
  }

  @override
  String listDeleted(String title) {
    return 'Se eliminó «$title»';
  }

  @override
  String listMoveTo(String stage) {
    return 'Mover a $stage';
  }

  @override
  String get listFinalStage => 'Etapa final';

  @override
  String get listEmpty => 'Aún no hay nada. Toca Añadir para empezar.';

  @override
  String listEmptyStage(String stage) {
    return 'Nada en $stage.';
  }

  @override
  String get listCopy => 'Copiar lista';

  @override
  String get listStage => 'Etapa';
}
