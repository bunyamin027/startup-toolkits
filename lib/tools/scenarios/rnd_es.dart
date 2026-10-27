import '../l10n/tool_text.dart';
import 'scenario.dart';

/// R&D example (Terralab) in Spanish.
const rndEs = ScenarioText(
  fields: {
    'leanCanvas': {
      'company': 'Terralab',
      'problem':
          'Las fincas riegan un 30–40 % de más porque la humedad del suelo se calcula a ojo.\n'
          'Un sensor de suelo de calidad de laboratorio cuesta más de 1.000 \$.\n'
          'El precio del agua y las restricciones por sequía no dejan de subir.',
      'solution':
          'Una sonda de 90 \$ que mide la humedad a tres profundidades.\n'
          'Un modelo de aprendizaje automático que convierte las lecturas en un plan de riego diario.\n'
          'Alertas en el móvil, sin necesidad de agrónomo.',
      'uvp':
          'Datos de suelo de calidad de laboratorio por una décima parte del precio: cada parcela se riega según lo que necesita, no por costumbre.',
      'segment': 'Fincas medianas de fruta y hortaliza en zonas secas',
      'channels':
          'Cooperativas agrícolas\nDistribuidores de material de riego\nJornadas técnicas y ferias agrarias',
      'revenue':
          'Sondas: 90 \$ cada una\nPlataforma de datos: 4 \$ por sonda al mes',
      'costs':
          'Equipo de I+D y ensayos de laboratorio\nFabricación de sondas\nPilotos en campo',
      'metrics':
          'Agua ahorrada por hectárea\nSondas instaladas\nConversión de piloto a cliente',
      'advantage':
          'Método de medición con patente en trámite y 3 años de datos de ensayos universitarios.',
    },
    'swot': {
      'company': 'Terralab',
      'strengths':
          'Sensor con patente en trámite\nAlianza con un laboratorio universitario\nDatos de 12 fincas piloto',
      'weaknesses':
          'Ciclos largos de desarrollo de hardware\nTodavía sin línea de producción certificada\nEquipo comercial pequeño',
      'opportunities':
          'Ayudas públicas para la eficiencia hídrica\nNormas de riego más estrictas en zonas secas\nCooperativas que compran en volumen',
      'threats':
          'Grandes marcas de riego que añaden sensores\nEscasez de componentes electrónicos',
    },
    'competitors': {
      'price': '1.200 \$ por sensor',
      'strength': 'Precisión',
      'weakness': 'Caro',
    },
    'persona': {
      'name': 'Gabriel el agricultor',
      'role': 'Propietario de un frutal de 40 hectáreas',
      'age': '47',
      'location': 'Murcia',
      'goals':
          'Reducir el gasto en agua sin perder cosecha\nCumplir las nuevas normas de riego',
      'pains':
          'Riega por costumbre y solo ve los problemas cuando los árboles ya sufren estrés',
      'tools':
          'Una app del tiempo\nUn programador de riego\nLos consejos del agrónomo de la cooperativa',
      'quote': 'No necesito más datos. Necesito saber cuándo regar.',
      'channels':
          'Reuniones de la cooperativa\nDistribuidores de riego\nGrupos de WhatsApp de agricultores de la zona',
    },
    'interviewQuestions': {
      'segment': 'Fruticultores y horticultores',
      'problemArea': 'la planificación del riego',
      'product': 'Terralab',
    },
    'invoice': {
      'company': 'Terralab S.L.',
      'email': 'facturacion@terralab.io',
      'client': 'Cooperativa Valle Verde',
      'item1': 'Kit de sondas de suelo (10 sondas)',
      'item2': 'Plataforma de datos, licencia anual por finca',
    },
    'incomeExpense': {'category': 'Laboratorio'},
    'pitchDeck': {
      'company': 'Terralab',
      'oneLiner':
          'Sensores de suelo asequibles que dicen a cada finca exactamente cuándo regar.',
      'problem':
          'Las fincas riegan un 30–40 % de más porque un sensor de suelo preciso cuesta más de 1.000 \$.',
      'solution':
          'Una sonda de 90 \$ y un modelo de aprendizaje automático que convierten las lecturas del suelo en un plan de riego diario.',
      'market':
          '570.000 fincas medianas en zonas secas; mercado alcanzable de 2.100 M\$',
      'model':
          'Venta de sondas y 4 \$ por sonda al mes por la plataforma de datos',
      'traction':
          '12 fincas piloto, 31 % de ahorro de agua de media, patente presentada, ayuda de I+D de 250.000 \$',
      'competition':
          'Sensores de laboratorio (precisos pero caros), servicios por satélite (baratos pero imprecisos)',
      'team':
          'Elif (CEO, agrónoma), Can (CTO, doctor en sensores), Jonas (responsable de hardware, ex-fabricante de riego)',
      'ask':
          'Ronda semilla de 1,2 M\$ para certificar la producción y llegar a 300 fincas',
      'email': 'fundadores@terralab.io',
    },
    'onePager': {
      'company': 'Terralab',
      'oneLiner':
          'Sensores de suelo asequibles que dicen a cada finca exactamente cuándo regar.',
      'problem':
          'Las fincas riegan un 30–40 % de más porque un sensor de suelo preciso cuesta más de 1.000 \$.',
      'solution':
          'Una sonda de 90 \$ y un modelo de aprendizaje automático que convierten las lecturas del suelo en un plan de riego diario.',
      'customer': 'Fincas medianas de fruta y hortaliza en zonas secas',
      'market': 'Mercado alcanzable de 2.100 M\$',
      'traction':
          '12 fincas piloto, 31 % de ahorro de agua, patente presentada',
      'team': 'Elif (CEO), Can (CTO), Jonas (Hardware)',
      'ask': 'Ronda semilla de 1,2 M\$',
      'email': 'fundadores@terralab.io',
    },
    'investorTracker': {
      'firm': 'Fondo de impacto',
      'next': 'Enviar los resultados de los pilotos',
    },
    'kanban': {'owner': 'Elif'},
    'okr': {'objective': 'Demostrar el ahorro de agua en campo'},
    'roadmap': {'why': 'Lo piden las fincas piloto'},
    'userStory': {
      'feature': 'Plan de riego diario',
      'user': 'responsable de finca',
      'want': 'ver cuánto tiempo regar cada parcela hoy',
      'benefit': 'deje de adivinar y ahorre agua',
      'criteria':
          'El plan está listo cada día a las 6:00\nMuestra los minutos por parcela y sector\nExplica el motivo en una línea\nFunciona con el programador de riego que ya tiene la finca',
      'outOfScope':
          'Control automático de válvulas\nRecomendaciones de abonado',
      'metric': '25 % menos de agua en las fincas piloto en una campaña',
    },
    'standup': {'who': 'Elif'},
    'brandName': {
      'keyword': 'suelo',
      'keyword2': 'terra',
      'benefit': 'regar cada parcela según lo que necesita, no por costumbre',
      'audience': 'agricultores',
    },
    'colorPalette': {'company': 'Terralab'},
    'landingPage': {
      'company': 'Terralab',
      'audience': 'agricultores',
      'outcome': 'Sabe exactamente cuándo regar',
      'problem':
          'Regar por costumbre desperdicia agua, dinero y a veces la cosecha.',
      'features':
          'Una sonda de 90 \$ que mide tres profundidades\nUn plan de riego diario para cada parcela\nAlertas antes de que las plantas sufran',
      'proof': 'Probado en 12 fincas con un 31 % de ahorro de agua',
      'cta': 'Solicita un piloto',
    },
    'emailTemplates': {
      'sender': 'Elif',
      'company': 'Terralab',
      'oneLiner':
          'sensores de suelo asequibles que dicen a cada finca cuándo regar',
      'hook': 'tu charla sobre climate tech en la cumbre AgriFood',
      'traction': '12 fincas piloto y una patente presentada',
    },
    'seoKeywords': {
      'topic': 'sensor de humedad del suelo',
      'audience': 'agricultores',
      'alternative': 'tensiómetros',
      'location': 'Murcia',
    },
    'crm': {
      'company': 'Cooperativa Valle Verde',
      'next': 'Concertar visita a la finca',
    },
    'proposal': {
      'company': 'Terralab S.L.',
      'client': 'Cooperativa Valle Verde',
      'need':
          'Valle Verde quiere que sus 15 fincas socias reduzcan el agua de riego sin perder cosecha.',
      'scope':
          '60 sondas de suelo instaladas en 15 fincas\nPlataforma de datos durante una campaña\nJornada de formación para responsables de finca',
      'timeline': 'Sondas instaladas en las tres semanas siguientes a la firma',
      'sender': 'Elif Kaya',
    },
    'followUps': {'note': 'Enviar los resultados de los pilotos'},
    'feedback': {'from': 'Finca piloto'},
    'nda': {
      'company': 'Terralab S.L.',
      'otherParty': 'Cooperativa Valle Verde',
      'purpose': 'evaluar un ensayo de campo conjunto',
    },
    'privacyTerms': {
      'company': 'Terralab S.L.',
      'service': 'la app Terralab y sus sondas de suelo',
      'email': 'privacidad@terralab.io',
      'data':
          'Nombre y correo electrónico\nUbicación de la finca y límites de las parcelas\nLecturas de suelo de tus sondas\nAnalítica de uso de la app',
    },
    'contract': {
      'company': 'Terralab S.L.',
      'scope': 'Diseñar una carcasa de sonda resistente a la intemperie',
    },
    'jobPost': {
      'company': 'Terralab',
      'oneLiner':
          'sensores de suelo asequibles que dicen a cada finca cuándo regar',
      'title': 'Ingeniero/a de firmware embebido',
      'location': 'Híbrido (laboratorio dos días por semana)',
      'responsibilities':
          'Llevar el firmware de la sonda del prototipo a producción\nReducir el consumo hasta dos campañas con una pila\nParticipar en los ensayos de campo con las fincas piloto',
      'requirements':
          'Más de 3 años de C embebido en dispositivos de bajo consumo\nExperiencia con sensores o radio (LoRa, BLE)\nIgual de cómodo/a en el campo que en el laboratorio',
      'email': 'empleo@terralab.io',
    },
    'interviewLibrary': {
      'company': 'Terralab',
      'title': 'Ingeniero/a de firmware embebido',
    },
    'meetingNotes': {'owner': 'Elif', 'meeting': 'Reunión semanal de I+D'},
    'storeListing': {
      'app': 'Terralab',
      'subtitle': 'Riego inteligente',
      'oneLiner': 'sensores de suelo que te dicen cuándo regar',
      'audience': 'agricultores',
      'features':
          'Un plan de riego diario para cada parcela\nHumedad del suelo a tres profundidades\nAlertas antes de que las plantas sufran\nInformes de ahorro de agua para ayudas y auditorías',
      'price': 'Incluido con cada sonda Terralab.',
      'proof': 'En uso en 12 fincas piloto',
    },
    'asoKeywords': {
      'app': 'Terralab',
      'primary': 'riego',
      'secondary': 'suelo',
      'audience': 'agricultor',
      'keywords': 'sensor,humedad,agua,finca,huerto,frutal,cultivo,goteo',
      'competitor': 'AquaProbe',
    },
    'reviewReply': {
      'app': 'Terralab',
      'topic': 'las alertas de riego',
      'email': 'ayuda@terralab.io',
    },
    'appPrivacy': {
      'app': 'Terralab',
      'developer': 'Terralab S.L.',
      'email': 'privacidad@terralab.io',
    },
  },
  samples: {
    'competitors': [
      SampleText('AquaProbe Pro', {
        'price': '1.200 \$ por sensor',
        'strength': 'Precisión de laboratorio',
        'weakness': 'Demasiado caro para la mayoría de fincas',
      }),
      SampleText('Tensiómetros', {
        'price': 'Desde 80 \$',
        'strength': 'Baratos y conocidos',
        'weakness': 'Lectura manual a una sola profundidad',
      }),
      SampleText('SatIrrig', {
        'price': '6 \$ por hectárea al mes',
        'strength': 'Sin hardware',
        'weakness': 'Datos de satélite demasiado gruesos para una parcela',
      }),
    ],
    'incomeExpense': [
      SampleText('Suscripciones de fincas piloto', {'category': 'Ingresos'}),
      SampleText('Sueldos de ingeniería', {'category': 'Equipo'}),
      SampleText('Ensayos de laboratorio y componentes', {'category': 'I+D'}),
    ],
    'investorTracker': [
      SampleText('Maya Chen', {
        'firm': 'AgriTech Ventures',
        'next': 'Reunión de socios el jueves',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Business angel (ex-CEO de una empresa de riego)',
        'next': 'Enviar la nota convertible',
      }),
      SampleText('Climate Seed Fund', {
        'firm': 'Fondo climático',
        'next': 'Pedir a Jordan una presentación',
      }),
    ],
    'kanban': [
      SampleText('Calibrar el lote de sondas n.º 4', {'owner': 'Can'}),
      SampleText('Preparar el informe de avance de la ayuda', {
        'owner': 'Elif',
      }),
      SampleText('Instalar sondas en la finca piloto 12', {'owner': 'Jonas'}),
    ],
    'okr': [
      SampleText('Hacer pilotos en 20 fincas', {
        'objective': 'Demostrar el ahorro de agua en campo',
      }),
      SampleText('Ahorro medio de agua por encima del 25 %', {
        'objective': 'Demostrar el ahorro de agua en campo',
      }),
      SampleText('Obtener el marcado CE', {
        'objective': 'Prepararse para producir',
      }),
    ],
    'roadmap': [
      SampleText('Dos campañas con una sola pila', {
        'why': 'Lo que más piden las fincas piloto',
      }),
      SampleText('Soporte para pasarelas LoRaWAN', {
        'why': 'Fincas sin cobertura móvil',
      }),
      SampleText('Recomendaciones de abonado', {
        'why': 'Abre una segunda fuente de ingresos',
      }),
    ],
    'standup': [
      SampleText('Terminada la prueba de campo en la finca piloto 7', {
        'who': 'Jonas',
      }),
      SampleText('Llamada con el agente de patentes', {'who': 'Elif'}),
      SampleText('Esperando los chips del proveedor', {'who': 'Can'}),
    ],
    'contentCalendar': [
      SampleText('Lo que 12 fincas piloto nos enseñaron sobre el agua', {
        'channel': 'Blog',
      }),
      SampleText('Dentro del laboratorio: así se calibra una sonda', {
        'channel': 'LinkedIn',
      }),
      SampleText('Consejos de riego antes del pico del verano', {
        'channel': 'Instagram',
      }),
    ],
    'crm': [
      SampleText('Lucía García', {
        'company': 'Cooperativa Valle Verde',
        'next': 'Demo en campo el martes a las 10:00',
      }),
      SampleText('Marco Rossi', {
        'company': 'Frutales Rossi',
        'next': 'Volver a llamar el viernes',
      }),
      SampleText('Hanna Berg', {
        'company': 'Viñedos Berg',
        'next': 'Instalar las sondas',
      }),
    ],
    'followUps': [
      SampleText('Lucía: enviar el informe de la demo', {
        'note': 'Incluir el gráfico de ahorro de agua',
      }),
      SampleText('Maya: notas de la reunión de socios', {
        'note': 'Esperando respuesta',
      }),
      SampleText('Hanna: revisión de la campaña', {
        'note': 'Todas las sondas en línea',
      }),
    ],
    'feedback': [
      SampleText('Más duración de la pila', {'from': 'Fincas piloto 2, 5 y 9'}),
      SampleText('La app en inglés', {'from': 'Frutales Rossi'}),
      SampleText('Alertas de riego más claras', {'from': 'Grupo piloto'}),
    ],
    'meetingNotes': [
      SampleText('Enviar el informe de avance de la ayuda', {
        'owner': 'Elif',
        'meeting': 'Reunión semanal de I+D',
      }),
      SampleText('Corregir la deriva de las sondas con frío', {
        'owner': 'Can',
        'meeting': 'Revisión de laboratorio',
      }),
      SampleText('Elegir socio de fabricación', {
        'owner': 'Jonas',
        'meeting': 'Reunión semanal de I+D',
      }),
    ],
    'kpiBoard': [
      SampleText('Fincas con sondas instaladas', {
        'current': '12',
        'target': '20',
      }),
      SampleText('Ahorro medio de agua', {'current': '22 %', 'target': '25 %'}),
      SampleText('Tasa de fallos de sondas', {
        'current': '6 %',
        'target': '2 %',
      }),
    ],
  },
);
