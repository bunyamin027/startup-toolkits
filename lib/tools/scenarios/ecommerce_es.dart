import '../l10n/tool_text.dart';
import 'scenario.dart';

/// E-commerce example (Olivara) in Spanish.
const ecommerceEs = ScenarioText(
  fields: {
    'leanCanvas': {
      'company': 'Olivara',
      'problem':
          'El aceite de oliva del supermercado suele estar mezclado, ser viejo o estar mal etiquetado.\n'
          'Los pequeños olivares familiares no llegan a compradores en el extranjero.\n'
          'En la estantería, cuesta distinguir un buen aceite.',
      'solution':
          'Aceite de una sola finca, enviado semanas después de la cosecha.\n'
          'Fecha de cosecha y olivar impresos en cada botella.\n'
          'Una suscripción de recarga que llega antes de que se acabe.',
      'uvp': 'Aceite de oliva fresco y trazable, del olivar a tu cocina.',
      'segment':
          'Cocineros caseros de EE. UU. y Europa que compran comida gourmet en línea',
      'channels':
          'Recetas en Instagram y TikTok\nBlogueros gastronómicos\nMarketplaces en línea',
      'revenue':
          'Botellas: 24 \$ cada una\nSuscripción de recarga: 19 \$ al mes',
      'costs':
          'Aceite de olivares asociados\nEmbotellado y envío\nAnuncios en redes sociales',
      'metrics':
          'Tasa de recompra\nCoste de adquisición de clientes\nTicket medio',
      'advantage':
          'Contratos exclusivos con 9 olivares familiares y una cosecha premiada.',
    },
    'swot': {
      'company': 'Olivara',
      'strengths':
          'Aceite premiado\nContratos directos con olivares familiares\nFuerte comunidad en Instagram',
      'weaknesses':
          'Una sola categoría de producto\nEnvíos caros a EE. UU.\nCosecha estacional, stock limitado',
      'opportunities':
          'Demanda creciente de comida trazable\nCajas regalo para las fiestas\nRestaurantes que compran al por mayor',
      'threats':
          'Malas cosechas tras la sequía\nAceites mezclados baratos con etiquetas de aspecto premium',
    },
    'competitors': {
      'price': '18 \$ la botella',
      'strength': 'Marca',
      'weakness': 'Aceite mezclado',
    },
    'persona': {
      'name': 'Fiona la sibarita',
      'role': 'Responsable de marketing a la que le encanta cocinar',
      'age': '34',
      'location': 'Madrid',
      'goals': 'Cocinar más sano en casa\nComprar comida de origen claro',
      'pains':
          'La han engañado etiquetas de “virgen extra” y no distingue un buen aceite de uno malo',
      'tools':
          'Recetas de Instagram\nUna app de compra a domicilio\nMarketplaces en línea',
      'quote': 'Si pago por un buen aceite, quiero saber de dónde viene.',
      'channels':
          'Cuentas gastronómicas de Instagram\nBoletines de recetas\nMercados de productores',
    },
    'interviewQuestions': {
      'segment': 'Cocineros caseros que compran comida gourmet',
      'problemArea': 'la compra de aceite de oliva',
      'product': 'Olivara',
    },
    'invoice': {
      'company': 'Olivara S.L.',
      'email': 'pedidos@olivara.shop',
      'client': 'Restaurante Bella Cucina',
      'item1': 'Aceite de oliva virgen extra, lata de 5 litros',
      'item2': 'Caja regalo (3 botellas)',
    },
    'incomeExpense': {'category': 'Envíos'},
    'pitchDeck': {
      'company': 'Olivara',
      'oneLiner':
          'Aceite de oliva fresco y trazable de olivares familiares, en tu puerta.',
      'problem':
          'La mayoría del aceite en las tiendas está mezclado o es viejo, y los pequeños olivares no llegan a compradores extranjeros.',
      'solution':
          'Olivara vende en línea aceite de una sola finca, enviado semanas después de la cosecha, con suscripción de recarga.',
      'market':
          '45 M de compradores gourmet en EE. UU. y la UE; mercado alcanzable de 1800 M\$',
      'model':
          'Venta directa a 24 \$ la botella más una suscripción de recarga de 19 \$ al mes',
      'traction':
          '8000 pedidos, 38 % de recompra, 42 k\$ de ingresos mensuales',
      'competition':
          'Marcas de supermercado (baratas, mezcladas), marcas premium (caras, no trazables)',
      'team':
          'Defne (CEO, ex gerente de marca alimentaria), Leo (crecimiento, ex agencia de e-commerce), Ali (abastecimiento, agricultor de tercera generación)',
      'ask':
          'Ronda semilla de 900 k\$ para abrir un almacén en EE. UU. y duplicar la publicidad',
      'email': 'fundadores@olivara.shop',
    },
    'onePager': {
      'company': 'Olivara',
      'oneLiner':
          'Aceite de oliva fresco y trazable de olivares familiares, en tu puerta.',
      'problem':
          'La mayoría del aceite en las tiendas está mezclado o es viejo, y los pequeños olivares no llegan a compradores extranjeros.',
      'solution':
          'Olivara vende en línea aceite de una sola finca, enviado semanas después de la cosecha, con suscripción de recarga.',
      'customer': 'Cocineros caseros de EE. UU. y Europa',
      'market': 'Mercado alcanzable de 1800 M\$',
      'traction': '8000 pedidos, 38 % de recompra',
      'team': 'Defne (CEO), Leo (Crecimiento), Ali (Abastecimiento)',
      'ask': 'Ronda semilla de 900 k\$',
      'email': 'fundadores@olivara.shop',
    },
    'investorTracker': {
      'firm': 'Fondo de consumo',
      'next': 'Enviar datos de cohortes',
    },
    'kanban': {'owner': 'Defne'},
    'okr': {'objective': 'Que los clientes vuelvan'},
    'roadmap': {'why': 'Los clientes lo piden'},
    'userStory': {
      'feature': 'Suscripción de recarga',
      'user': 'cliente habitual',
      'want': 'recibir una botella nueva antes de que se acabe la mía',
      'benefit': 'nunca cocine sin buen aceite',
      'criteria':
          'El cliente elige una entrega cada 1, 2 o 3 meses\nPuede saltar o pausar con un toque\nRecibe un aviso 3 días antes del envío\nSe le cobra automáticamente el precio de la suscripción',
      'outOfScope':
          'Mezclar distintos productos en una caja\nSuscripciones de regalo',
      'metric': '25 % de los clientes suscritos en 3 meses',
    },
    'standup': {'who': 'Defne'},
    'brandName': {
      'keyword': 'oliva',
      'keyword2': 'olivar',
      'benefit': 'saborea la cosecha en casa',
      'audience': 'cocineros caseros',
    },
    'colorPalette': {'company': 'Olivara'},
    'landingPage': {
      'company': 'Olivara',
      'audience': 'cocineros caseros',
      'outcome': 'Aceite de oliva en el que puedes confiar',
      'problem':
          'La mayoría del aceite del supermercado está mezclado, es viejo o ambas cosas.',
      'features':
          'Aceite de una sola finca, embotellado semanas después de la cosecha\nFecha de cosecha y olivar en cada botella\nRecargas que llegan antes de que se acabe',
      'proof': 'Valorado con 4,9 por 8000 clientes',
      'cta': 'Descubre la cosecha',
    },
    'emailTemplates': {
      'sender': 'Defne',
      'company': 'Olivara',
      'oneLiner': 'aceite de oliva fresco y trazable de olivares familiares',
      'hook': 'tu publicación sobre etiquetas de alimentos honestas',
      'traction': '8000 pedidos y un 38 % de recompra',
    },
    'seoKeywords': {
      'topic': 'aceite de oliva',
      'audience': 'cocineros caseros',
      'alternative': 'aceite de oliva de supermercado',
      'location': 'España',
    },
    'crm': {'company': 'Bella Cucina', 'next': 'Enviar muestras de cata'},
    'proposal': {
      'company': 'Olivara S.L.',
      'client': 'Bella Cucina',
      'need':
          'Bella Cucina quiere un suministro estable de aceite de oliva premium con una historia que compartir con sus comensales.',
      'scope':
          '40 litros de aceite virgen extra al mes\nTarjetas con la historia del olivar para las mesas\nPrecio fijo durante 12 meses',
      'timeline': 'Primera entrega en la semana siguiente a la firma',
      'sender': 'Defne Arslan',
    },
    'followUps': {'note': 'Enviar muestras de cata'},
    'feedback': {'from': 'Cliente'},
    'nda': {
      'company': 'Olivara S.L.',
      'otherParty': 'Bella Cucina S.L.',
      'purpose': 'la evaluación de una alianza de suministro',
    },
    'privacyTerms': {
      'company': 'Olivara S.L.',
      'service': 'la tienda en línea de Olivara',
      'email': 'privacidad@olivara.shop',
      'data':
          'Nombre y correo electrónico\nDirección de envío\nHistorial de pedidos\nAnalítica del sitio web',
    },
    'contract': {
      'company': 'Olivara S.L.',
      'scope': 'Diseño de la caja regalo de fiestas y las etiquetas',
    },
    'jobPost': {
      'company': 'Olivara',
      'oneLiner': 'aceite de oliva fresco y trazable de olivares familiares',
      'title': 'Responsable de marketing de crecimiento',
      'location': 'Remoto (husos horarios europeos)',
      'responsibilities':
          'Llevar la publicidad en redes, de la creatividad al presupuesto\nHacer crecer el email y la suscripción de recarga\nTrabajar con creadores gastronómicos',
      'requirements':
          'Más de 3 años en marketing de e-commerce\nSoltura con presupuestos publicitarios y cifras\nPasión por la buena comida',
      'email': 'empleo@olivara.shop',
    },
    'interviewLibrary': {
      'company': 'Olivara',
      'title': 'Responsable de marketing de crecimiento',
    },
    'meetingNotes': {
      'owner': 'Defne',
      'meeting': 'Reunión semanal de operaciones',
    },
    'storeListing': {
      'app': 'Olivara',
      'subtitle': 'Aceite de oliva fresco a domicilio',
      'oneLiner': 'aceite de oliva directo del olivar',
      'audience': 'cocineros caseros',
      'features':
          'Pide en dos toques\nGestiona tu suscripción de recarga\nRecetas de nuestros productores\nSigue cada entrega',
      'price': 'Descarga gratuita. Solo pagas tus pedidos.',
      'proof': 'Valorado con 4,9 por 8000 clientes',
    },
    'asoKeywords': {
      'app': 'Olivara',
      'primary': 'aceite de oliva',
      'secondary': 'supermercado',
      'audience': 'cocinero',
      'keywords': 'ecológico,comida,envío,recetas,gourmet,sano,tienda,regalo',
      'competitor': 'GroveBox',
    },
    'reviewReply': {
      'app': 'Olivara',
      'topic': 'el plazo de entrega',
      'email': 'ayuda@olivara.shop',
    },
    'appPrivacy': {
      'app': 'Olivara',
      'developer': 'Olivara S.L.',
      'email': 'privacidad@olivara.shop',
    },
  },
  samples: {
    'competitors': [
      SampleText('Golden Press', {
        'price': '37 \$ la botella',
        'strength': 'Imagen de marca preciosa',
        'weakness': 'Muy caro',
      }),
      SampleText('Marcas de supermercado', {
        'price': '9 \$ la botella',
        'strength': 'Barato y en todas partes',
        'weakness': 'Mezclado, sin fecha de cosecha',
      }),
      SampleText('GroveBox', {
        'price': '29 \$ al mes',
        'strength': 'Modelo de suscripción',
        'weakness': 'Envía desde un solo almacén',
      }),
    ],
    'incomeExpense': [
      SampleText('Ventas de la tienda en línea (octubre)', {
        'category': 'Ingresos',
      }),
      SampleText('Aceite de olivares asociados', {'category': 'Existencias'}),
      SampleText('Envío y embalaje', {'category': 'Logística'}),
    ],
    'investorTracker': [
      SampleText('Maya Chen', {
        'firm': 'Harvest Consumer Fund',
        'next': 'Reunión de socios el jueves',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Business angel (ex fundador de marca alimentaria)',
        'next': 'Enviar la nota convertible',
      }),
      SampleText('D2C Seed Partners', {
        'firm': 'Fondo presemilla',
        'next': 'Pedir a Jordan una presentación',
      }),
    ],
    'kanban': [
      SampleText('Fotografiar la caja regalo de fiestas', {'owner': 'Leo'}),
      SampleText('Negociar tarifas de envío a EE. UU.', {'owner': 'Defne'}),
      SampleText('Lanzar la suscripción de recarga', {'owner': 'Leo'}),
    ],
    'okr': [
      SampleText('Tasa de recompra superior al 40 %', {
        'objective': 'Que los clientes vuelvan',
      }),
      SampleText('1000 suscriptores', {
        'objective': 'Que los clientes vuelvan',
      }),
      SampleText('Abrir un almacén en EE. UU.', {
        'objective': 'Enviar más rápido a EE. UU.',
      }),
    ],
    'roadmap': [
      SampleText('Cajas regalo de fiestas', {
        'why': 'Lo más pedido el pasado diciembre',
      }),
      SampleText('Almacén en EE. UU.', {'why': 'Reduce la entrega a 3 días'}),
      SampleText('Aceites aromatizados', {
        'why': 'Más margen, nuevos clientes',
      }),
    ],
    'standup': [
      SampleText('Empaquetados 120 pedidos de fiestas', {'who': 'Ali'}),
      SampleText('Llamada con la nueva mensajería', {'who': 'Defne'}),
      SampleText('Esperando las etiquetas de la imprenta', {'who': 'Leo'}),
    ],
    'contentCalendar': [
      SampleText('Cómo distinguir un aceite de oliva fresco de uno viejo', {
        'channel': 'Blog',
      }),
      SampleText('Día de cosecha en nuestro olivar asociado', {
        'channel': 'Instagram',
      }),
      SampleText('Guía de regalos para las fiestas', {'channel': 'Boletín'}),
    ],
    'crm': [
      SampleText('Lucía García', {
        'company': 'Bella Cucina',
        'next': 'Cata mar. 10:00',
      }),
      SampleText('Marco Rossi', {
        'company': 'Delicatessen Rossi',
        'next': 'Seguimiento el viernes',
      }),
      SampleText('Hanna Berg', {
        'company': 'Bistró Berg',
        'next': 'Primera entrega',
      }),
    ],
    'followUps': [
      SampleText('Lucía: enviar notas de cata', {
        'note': 'Incluir la lista de precios',
      }),
      SampleText('Maya: notas de la reunión de socios', {
        'note': 'Esperando respuesta',
      }),
      SampleText('Hanna: revisión tras la primera entrega', {
        'note': 'Todo bien',
      }),
    ],
    'feedback': [
      SampleText('Botella de prueba más pequeña', {
        'from': 'Reseñas de la tienda',
      }),
      SampleText('Embalaje sin plástico', {'from': 'Seguidores de Instagram'}),
      SampleText('Entrega más rápida', {'from': 'Encuesta de pedidos'}),
    ],
    'meetingNotes': [
      SampleText('Enviar la actualización a inversores', {
        'owner': 'Defne',
        'meeting': 'Reunión semanal de operaciones',
      }),
      SampleText('Reducir el abandono en el pago', {
        'owner': 'Leo',
        'meeting': 'Revisión de crecimiento',
      }),
      SampleText('Elegir mensajería para EE. UU.', {
        'owner': 'Ali',
        'meeting': 'Reunión semanal de operaciones',
      }),
    ],
    'kpiBoard': [
      SampleText('Ingresos mensuales', {
        'current': '42 000 \$',
        'target': '50 000 \$',
      }),
      SampleText('Tasa de recompra', {'current': '34 %', 'target': '40 %'}),
      SampleText('Tasa de devolución', {'current': '5 %', 'target': '2 %'}),
    ],
  },
);
