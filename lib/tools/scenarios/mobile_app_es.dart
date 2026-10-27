import '../l10n/tool_text.dart';
import 'scenario.dart';

/// Mobile app example (Pacely) in Spanish.
const mobileAppEs = ScenarioText(
  fields: {
    'leanCanvas': {
      'company': 'Pacely',
      'problem':
          'Los planes de carrera genéricos ignoran el sueño, el estrés y las sesiones perdidas.\n'
          'Los principiantes se lesionan por hacer demasiado, demasiado pronto.\n'
          'Un entrenador personal es demasiado caro para la mayoría.',
      'solution':
          'Un entrenador con IA que reescribe la semana tras cada carrera.\n'
          'Avisos de carga antes de la lesión, no después.\n'
          'Indicaciones de voz durante la carrera, en palabras sencillas.',
      'uvp':
          'Un entrenador de running en tu bolsillo que se adapta a tu semana real.',
      'segment':
          'Corredores aficionados que preparan su primer 10K o media maratón',
      'channels':
          'App Store y Google Play\nClubes de running\nComunidades de Instagram y Strava',
      'revenue': 'Plan gratuito\nPremium: 9,99 \$ al mes o 59,99 \$ al año',
      'costs':
          'Desarrollo de la app\nCostes de nube e IA\nComisiones de las tiendas',
      'metrics':
          'Corredores activos semanales\nConversión de gratis a pago\nRetención a 30 días',
      'advantage':
          'Un modelo de entrenamiento creado con científicos del deporte sobre 2 millones de carreras reales.',
    },
    'swot': {
      'company': 'Pacely',
      'strengths':
          'Planes que se adaptan cada semana\nAlta valoración en la App Store\nCientíficos del deporte en el equipo',
      'weaknesses':
          'Depende de los datos del reloj\nPresupuesto de marketing pequeño\nSolo running, ningún otro deporte',
      'opportunities':
          'Cada vez más inscritos en carreras\nAlianzas con organizadores de carreras\nProgramas de bienestar en empresas',
      'threats':
          'Fabricantes de relojes que añaden su propio entrenamiento\nCambios en las normas de suscripción de las plataformas',
    },
    'competitors': {
      'price': '12,99 \$ al mes',
      'strength': 'Marca',
      'weakness': 'Planes fijos',
    },
    'persona': {
      'name': 'Raquel la corredora',
      'role': 'Profesora que prepara su primera media maratón',
      'age': '31',
      'location': 'Valencia',
      'goals':
          'Terminar una media maratón sin lesiones\nCorrer tres veces por semana',
      'pains':
          'Todos los planes se desmoronan tras una mala semana, y ya ha tenido periostitis',
      'tools': 'Un reloj inteligente\nStrava\nVídeos de running en YouTube',
      'quote':
          'No necesito un plan para una semana perfecta. Necesito uno para mi semana.',
      'channels':
          'Club de running local\nCuentas de running en Instagram\nBoletines de carreras',
    },
    'interviewQuestions': {
      'segment': 'Corredores aficionados',
      'problemArea': 'la preparación de una carrera',
      'product': 'Pacely',
    },
    'invoice': {
      'company': 'Pacely S.L.',
      'email': 'facturacion@pacely.app',
      'client': 'Media Maratón del Lago',
      'item1': 'Alianza de plan de entrenamiento oficial (temporada)',
      'item2': 'Códigos Premium para 500 corredores',
    },
    'incomeExpense': {'category': 'Nube'},
    'pitchDeck': {
      'company': 'Pacely',
      'oneLiner':
          'Un entrenador de running con IA que adapta tu plan a tu semana real.',
      'problem':
          'La mayoría de corredores siguen planes fijos que se rompen tras una mala semana, y muchos se lesionan.',
      'solution':
          'Pacely reescribe cada semana según tu sueño, tus carreras y cómo te sentiste, y te avisa antes de que te pases.',
      'market':
          '60 M de corredores aficionados en EE. UU. y la UE; mercado alcanzable de 1200 M\$',
      'model': 'Freemium; Premium a 9,99 \$ al mes o 59,99 \$ al año',
      'traction':
          '120 000 descargas, 6500 corredores de pago, valoración de 4,8',
      'competition':
          'Apps de planes fijos (baratas, no adaptativas), entrenadores personales (geniales, pero 150 \$ al mes)',
      'team':
          'Defne (CEO, ex responsable de producto en una app de fitness), Leo (CTO, ingeniero de ML), Ali (entrenador jefe, científico del deporte)',
      'ask':
          'Ronda semilla de 1,5 M\$ para lanzar Android y ampliar las alianzas con carreras',
      'email': 'fundadores@pacely.app',
    },
    'onePager': {
      'company': 'Pacely',
      'oneLiner':
          'Un entrenador de running con IA que adapta tu plan a tu semana real.',
      'problem':
          'La mayoría de corredores siguen planes fijos que se rompen tras una mala semana, y muchos se lesionan.',
      'solution':
          'Pacely reescribe cada semana según tu sueño, tus carreras y cómo te sentiste, y te avisa antes de que te pases.',
      'customer': 'Corredores aficionados que preparan una carrera',
      'market': 'Mercado alcanzable de 1200 M\$',
      'traction': '120 000 descargas, 6500 corredores de pago',
      'team': 'Defne (CEO), Leo (CTO), Ali (Entrenador jefe)',
      'ask': 'Ronda semilla de 1,5 M\$',
      'email': 'fundadores@pacely.app',
    },
    'investorTracker': {
      'firm': 'Fondo de apps de consumo',
      'next': 'Enviar datos de retención',
    },
    'kanban': {'owner': 'Leo'},
    'okr': {'objective': 'Que los corredores sigan entrenando'},
    'roadmap': {'why': 'Los corredores lo piden'},
    'userStory': {
      'feature': 'Recuperar carreras perdidas',
      'user': 'corredor',
      'want': 'que mi plan se ajuste cuando me salto una carrera',
      'benefit': 'siga en el camino sin duplicar la carga ni lesionarme',
      'criteria':
          'La carrera perdida se detecta a la mañana siguiente\nEl resto de la semana se reequilibra automáticamente\nLa distancia semanal nunca sube más de un 10 %\nEl corredor ve qué cambió y por qué',
      'outOfScope':
          'Planes de entrenamiento cruzado\nEditar a mano cada sesión',
      'metric': '15 % menos corredores que abandonan el plan el primer mes',
    },
    'standup': {'who': 'Leo'},
    'brandName': {
      'keyword': 'ritmo',
      'keyword2': 'zancada',
      'benefit': 'entrena con más cabeza, no más fuerte',
      'audience': 'corredores',
    },
    'colorPalette': {'company': 'Pacely'},
    'landingPage': {
      'company': 'Pacely',
      'audience': 'corredores',
      'outcome': 'Llega al día de la carrera en forma, no lesionado',
      'problem': 'Los planes fijos se rompen en cuanto la vida se complica.',
      'features':
          'Un plan que se adapta tras cada carrera\nAvisos antes del sobreentrenamiento\nEntrenamiento por voz mientras corres',
      'proof': 'Valorada con 4,8 por 6500 corredores',
      'cta': 'Empieza gratis',
    },
    'emailTemplates': {
      'sender': 'Defne',
      'company': 'Pacely',
      'oneLiner':
          'un entrenador de running con IA que se adapta a tu semana real',
      'hook': 'tu charla sobre lesiones en corredores nuevos',
      'traction': '6500 corredores de pago y una valoración de 4,8',
    },
    'seoKeywords': {
      'topic': 'entrenamiento de media maratón',
      'audience': 'corredores principiantes',
      'alternative': 'un entrenador de running',
      'location': 'Valencia',
    },
    'crm': {
      'company': 'Media Maratón del Lago',
      'next': 'Enviar la presentación de la alianza',
    },
    'proposal': {
      'company': 'Pacely S.L.',
      'client': 'Media Maratón del Lago',
      'need':
          'La organización quiere que más corredores primerizos lleguen preparados a la salida y terminen la carrera.',
      'scope':
          'Plan de entrenamiento oficial de Pacely para la carrera\n3 meses de Premium para cada inscrito\nUn informe de llegadas para los organizadores',
      'timeline': 'Plan disponible 16 semanas antes de la carrera',
      'sender': 'Defne Arslan',
    },
    'followUps': {'note': 'Enviar la presentación de la alianza'},
    'feedback': {'from': 'Corredor'},
    'nda': {
      'company': 'Pacely S.L.',
      'otherParty': 'Eventos del Lago S.L.',
      'purpose': 'la evaluación de una alianza con una carrera',
    },
    'privacyTerms': {
      'company': 'Pacely S.L.',
      'service': 'la app Pacely',
      'email': 'privacidad@pacely.app',
      'data':
          'Nombre y correo electrónico\nDatos de carrera y frecuencia cardiaca\nDatos de sueño que decidas compartir\nAnalítica de la app',
    },
    'contract': {
      'company': 'Pacely S.L.',
      'scope': 'Grabación de las indicaciones de voz en español',
    },
    'jobPost': {
      'company': 'Pacely',
      'oneLiner':
          'un entrenador de running con IA que se adapta a tu semana real',
      'title': 'Ingeniero/a móvil sénior (Flutter)',
      'location': 'Remoto (husos horarios de EE. UU. o Europa)',
      'responsibilities':
          'Crear nuevas funciones en nuestra app Flutter\nConectar relojes y plataformas de salud\nMantener la app rápida y sin cierres',
      'requirements':
          'Más de 4 años creando apps móviles\nHaber publicado una app Flutter en ambas tiendas\nCorres, o te gustaría',
      'email': 'empleo@pacely.app',
    },
    'interviewLibrary': {
      'company': 'Pacely',
      'title': 'Ingeniero/a móvil sénior',
    },
    'meetingNotes': {'owner': 'Leo', 'meeting': 'Reunión semanal de producto'},
    'storeListing': {
      'app': 'Pacely',
      'subtitle': 'Entrenador de running con IA',
      'oneLiner': 'un plan de carrera que se adapta a tu semana',
      'audience': 'corredores de todos los niveles',
      'features':
          'Planes de 5K a maratón\nSe adapta tras cada carrera\nAvisos antes del sobreentrenamiento\nFunciona con tu reloj',
      'price': 'Empieza gratis. Premium desde 9,99 \$ al mes.',
      'proof': 'Valorada con 4,8 por 6500 corredores',
    },
    'asoKeywords': {
      'app': 'Pacely',
      'primary': 'entrenador running',
      'secondary': 'maratón',
      'audience': 'corredor',
      'keywords': 'correr,entrenamiento,plan,5k,10k,ritmo,jogging,fitness',
      'competitor': 'StrideMate',
    },
    'reviewReply': {
      'app': 'Pacely',
      'topic': 'la sincronización con el reloj',
      'email': 'ayuda@pacely.app',
    },
    'appPrivacy': {
      'app': 'Pacely',
      'developer': 'Pacely S.L.',
      'email': 'privacidad@pacely.app',
    },
  },
  samples: {
    'competitors': [
      SampleText('StrideMate', {
        'price': '12,99 \$ al mes',
        'strength': 'Enorme biblioteca de planes',
        'weakness': 'Los planes nunca se adaptan',
      }),
      SampleText('Apps de fabricantes de relojes', {
        'price': 'Gratis con el reloj',
        'strength': 'Ya está en la muñeca',
        'weakness': 'Entrenamiento básico',
      }),
      SampleText('Entrenadores personales', {
        'price': '150 \$ al mes',
        'strength': 'Realmente personal',
        'weakness': 'Demasiado caro para la mayoría',
      }),
    ],
    'incomeExpense': [
      SampleText('Suscripciones de las tiendas (octubre)', {
        'category': 'Ingresos',
      }),
      SampleText('Alojamiento en la nube e IA', {'category': 'Nube'}),
      SampleText('Anuncios en Instagram', {'category': 'Marketing'}),
    ],
    'investorTracker': [
      SampleText('Maya Chen', {
        'firm': 'Stride Ventures',
        'next': 'Reunión de socios el jueves',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Business angel (ex fundador de una app de fitness)',
        'next': 'Enviar la nota convertible',
      }),
      SampleText('App Seed Partners', {
        'firm': 'Fondo presemilla',
        'next': 'Pedir a Jordan una presentación',
      }),
    ],
    'kanban': [
      SampleText('Publicar la beta de Android', {'owner': 'Leo'}),
      SampleText('Arreglar la sincronización del reloj en móviles antiguos', {
        'owner': 'Leo',
      }),
      SampleText('Escribir el texto de la nueva pantalla de pago', {
        'owner': 'Defne',
      }),
    ],
    'okr': [
      SampleText('Retención a 30 días superior al 40 %', {
        'objective': 'Que los corredores sigan entrenando',
      }),
      SampleText('10 000 corredores de pago', {
        'objective': 'Hacer crecer Premium',
      }),
      SampleText('Sesiones sin cierres por encima del 99,5 %', {
        'objective': 'Que los corredores sigan entrenando',
      }),
    ],
    'roadmap': [
      SampleText('App para Android', {
        'why': 'La mitad de la lista de espera usa Android',
      }),
      SampleText('Alianzas con carreras', {
        'why': 'Atrae corredores en el momento justo',
      }),
      SampleText('Entrenamiento de fuerza', {
        'why': 'Ayuda a prevenir lesiones',
      }),
    ],
    'standup': [
      SampleText('Publicada la versión 2.3', {'who': 'Leo'}),
      SampleText('Llamada con el organizador de la carrera', {'who': 'Defne'}),
      SampleText('Esperando la aprobación de App Review', {'who': 'Leo'}),
    ],
    'contentCalendar': [
      SampleText('Cómo preparar tu primera media maratón', {'channel': 'Blog'}),
      SampleText('Historia de un corredor: del sofá al 10K', {
        'channel': 'Instagram',
      }),
      SampleText('Novedades de la versión 2.3', {'channel': 'Boletín'}),
    ],
    'crm': [
      SampleText('Lucía García', {
        'company': 'Media Maratón del Lago',
        'next': 'Demo mar. 10:00',
      }),
      SampleText('Marco Rossi', {
        'company': 'Club de Corredores de la Ciudad',
        'next': 'Seguimiento el viernes',
      }),
      SampleText('Hanna Berg', {
        'company': 'FitWork Bienestar',
        'next': 'Arranque del piloto',
      }),
    ],
    'followUps': [
      SampleText('Lucía: enviar la presentación de la alianza', {
        'note': 'Incluir los resultados de la temporada pasada',
      }),
      SampleText('Maya: notas de la reunión de socios', {
        'note': 'Esperando respuesta',
      }),
      SampleText('Hanna: revisión del piloto', {'note': 'Todo bien'}),
    ],
    'feedback': [
      SampleText('Modo cinta de correr', {'from': 'Reseñas de la App Store'}),
      SampleText('Compartir el plan con un amigo', {
        'from': 'Encuesta en la app',
      }),
      SampleText('App para Apple Watch', {'from': 'Correos de soporte'}),
    ],
    'meetingNotes': [
      SampleText('Enviar la actualización a inversores', {
        'owner': 'Defne',
        'meeting': 'Reunión semanal de producto',
      }),
      SampleText('Reducir el abandono en la pantalla de pago', {
        'owner': 'Leo',
        'meeting': 'Revisión de crecimiento',
      }),
      SampleText('Revisar el nuevo modelo de planes', {
        'owner': 'Ali',
        'meeting': 'Reunión semanal de producto',
      }),
    ],
    'kpiBoard': [
      SampleText('Ingresos recurrentes mensuales', {
        'current': '38 000 \$',
        'target': '50 000 \$',
      }),
      SampleText('Retención a 30 días', {'current': '34 %', 'target': '40 %'}),
      SampleText('Tasa de cancelación mensual', {
        'current': '5 %',
        'target': '2 %',
      }),
    ],
  },
);
