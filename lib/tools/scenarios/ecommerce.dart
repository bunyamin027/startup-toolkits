import '../l10n/tool_text.dart';
import 'ecommerce_de.dart';
import 'ecommerce_es.dart';
import 'ecommerce_fr.dart';
import 'ecommerce_tr.dart';
import 'scenario.dart';

// E-commerce / consumer product example: Olivara sells cold-pressed olive
// oil from small family groves online, with a refill subscription.

const ecommerceScenario = <String, ScenarioText>{
  'en': _en,
  'tr': ecommerceTr,
  'fr': ecommerceFr,
  'es': ecommerceEs,
  'de': ecommerceDe,
};

const _en = ScenarioText(
  fields: {
    'leanCanvas': {
      'company': 'Olivara',
      'problem':
          'Supermarket olive oil is often blended, old or mislabelled.\n'
          'Small family groves cannot reach buyers abroad.\n'
          'On a shelf, good oil is hard to tell apart.',
      'solution':
          'Single-estate oil shipped within weeks of harvest.\n'
          'Harvest date and grove printed on every bottle.\n'
          'A refill subscription that arrives before you run out.',
      'uvp':
          'Fresh, traceable olive oil straight from the grove to your kitchen.',
      'segment': 'Home cooks in the US and Europe who buy premium food online',
      'channels':
          'Instagram and TikTok recipes\nFood bloggers\nOnline marketplaces',
      'revenue': 'Bottles: \$24 each\nRefill subscription: \$19 a month',
      'costs':
          'Oil from partner groves\nBottling and shipping\nPaid social ads',
      'metrics':
          'Repeat purchase rate\nCustomer acquisition cost\nAverage order value',
      'advantage':
          'Exclusive contracts with 9 family groves and an award-winning harvest.',
    },
    'swot': {
      'company': 'Olivara',
      'strengths':
          'Award-winning oil\nDirect contracts with family groves\nStrong Instagram community',
      'weaknesses':
          'A single product category\nHigh shipping costs to the US\nSeasonal harvest, limited stock',
      'opportunities':
          'Growing demand for traceable food\nGift boxes for the holidays\nRestaurants buying in bulk',
      'threats':
          'Poor harvests after drought\nCheap blended oils with premium-looking labels',
    },
    'competitors': {
      'price': '\$18 a bottle',
      'strength': 'Brand',
      'weakness': 'Blended oil',
    },
    'persona': {
      'name': 'Foodie Fiona',
      'role': 'Marketing manager who loves to cook',
      'age': '34',
      'location': 'Brooklyn, New York',
      'goals': 'Cook healthier meals at home\nBuy food with a clear origin',
      'pains':
          'Has been fooled by “extra virgin” labels and cannot tell good oil from bad',
      'tools': 'Instagram recipes\nA grocery delivery app\nOnline marketplaces',
      'quote': 'If I pay for good oil, I want to know where it came from.',
      'channels':
          'Instagram food accounts\nRecipe newsletters\nFarmers’ markets',
    },
    'interviewQuestions': {
      'segment': 'Home cooks who buy premium food',
      'problemArea': 'buying olive oil',
      'product': 'Olivara',
    },
    'invoice': {
      'company': 'Olivara Ltd.',
      'email': 'orders@olivara.shop',
      'client': 'Bella Cucina Restaurant',
      'item1': 'Extra virgin olive oil, 5-litre tin',
      'item2': 'Gift box (3 bottles)',
    },
    'incomeExpense': {'category': 'Shipping'},
    'pitchDeck': {
      'company': 'Olivara',
      'oneLiner':
          'Fresh, traceable olive oil from family groves, delivered to your door.',
      'problem':
          'Most olive oil on shelves is blended or old, and small groves cannot reach buyers abroad.',
      'solution':
          'Olivara sells single-estate oil online, shipped within weeks of harvest, with a refill subscription.',
      'market':
          '45M premium food buyers in the US and EU; \$1.8B serviceable market',
      'model':
          'Direct sales at \$24 a bottle plus a \$19 monthly refill subscription',
      'traction': '8,000 orders, 38% repeat rate, \$42k monthly revenue',
      'competition':
          'Supermarket brands (cheap, blended), premium brands (pricey, not traceable)',
      'team':
          'Defne (CEO, ex-food brand manager), Leo (growth, ex-e-commerce agency), Ali (sourcing, third-generation grower)',
      'ask': '\$900k seed to open a US warehouse and double ad spend',
      'email': 'founders@olivara.shop',
    },
    'onePager': {
      'company': 'Olivara',
      'oneLiner':
          'Fresh, traceable olive oil from family groves, delivered to your door.',
      'problem':
          'Most olive oil on shelves is blended or old, and small groves cannot reach buyers abroad.',
      'solution':
          'Olivara sells single-estate oil online, shipped within weeks of harvest, with a refill subscription.',
      'customer': 'Home cooks in the US and Europe',
      'market': '\$1.8B serviceable market',
      'traction': '8,000 orders, 38% repeat rate',
      'team': 'Defne (CEO), Leo (Growth), Ali (Sourcing)',
      'ask': '\$900k seed',
      'email': 'founders@olivara.shop',
    },
    'investorTracker': {'firm': 'Consumer fund', 'next': 'Send cohort data'},
    'kanban': {'owner': 'Defne'},
    'okr': {'objective': 'Make customers come back'},
    'roadmap': {'why': 'Customers ask for it'},
    'userStory': {
      'feature': 'Refill subscription',
      'user': 'regular customer',
      'want': 'get a new bottle before mine runs out',
      'benefit': 'I never cook without good oil',
      'criteria':
          'Customer picks a delivery every 1, 2 or 3 months\nCan skip or pause in one tap\nGets a reminder 3 days before shipping\nIs charged automatically at the subscription price',
      'outOfScope': 'Mixing different products in one box\nGift subscriptions',
      'metric': '25% of customers on a subscription within 3 months',
    },
    'standup': {'who': 'Defne'},
    'brandName': {
      'keyword': 'olive',
      'keyword2': 'grove',
      'benefit': 'taste the harvest at home',
      'audience': 'home cooks',
    },
    'colorPalette': {'company': 'Olivara'},
    'landingPage': {
      'company': 'Olivara',
      'audience': 'home cooks',
      'outcome': 'Olive oil you can trust',
      'problem': 'Most supermarket olive oil is blended, old or both.',
      'features':
          'Single-estate oil, bottled within weeks of harvest\nHarvest date and grove on every bottle\nRefills delivered before you run out',
      'proof': 'Rated 4.9 by 8,000 customers',
      'cta': 'Shop the harvest',
    },
    'emailTemplates': {
      'sender': 'Defne',
      'company': 'Olivara',
      'oneLiner': 'fresh, traceable olive oil from family groves',
      'hook': 'your post about honest food labels',
      'traction': '8,000 orders and a 38% repeat rate',
    },
    'seoKeywords': {
      'topic': 'olive oil',
      'audience': 'home cooks',
      'alternative': 'supermarket olive oil',
      'location': 'US',
    },
    'crm': {'company': 'Bella Cucina', 'next': 'Send tasting samples'},
    'proposal': {
      'company': 'Olivara Ltd.',
      'client': 'Bella Cucina',
      'need':
          'Bella Cucina wants a steady supply of premium olive oil with a story it can share with guests.',
      'scope':
          '40 litres of extra virgin oil a month\nGrove story cards for the tables\nPrice fixed for 12 months',
      'timeline': 'First delivery within one week of signing',
      'sender': 'Defne Arslan',
    },
    'followUps': {'note': 'Send tasting samples'},
    'feedback': {'from': 'Customer'},
    'nda': {
      'company': 'Olivara Ltd.',
      'otherParty': 'Bella Cucina Ltd.',
      'purpose': 'evaluating a supply partnership',
    },
    'privacyTerms': {
      'company': 'Olivara Ltd.',
      'service': 'the Olivara online shop',
      'email': 'privacy@olivara.shop',
      'data':
          'Name and email\nShipping address\nOrder history\nWebsite analytics',
    },
    'contract': {
      'company': 'Olivara Ltd.',
      'scope': 'Design the holiday gift box and bottle labels',
    },
    'jobPost': {
      'company': 'Olivara',
      'oneLiner': 'fresh, traceable olive oil from family groves',
      'title': 'Growth Marketing Manager',
      'location': 'Remote (European time zones)',
      'responsibilities':
          'Own paid social from creative to budget\nGrow email and the refill subscription\nWork with food creators',
      'requirements':
          '3+ years in e-commerce marketing\nComfortable with ad budgets and numbers\nA love of good food',
      'email': 'jobs@olivara.shop',
    },
    'interviewLibrary': {
      'company': 'Olivara',
      'title': 'Growth Marketing Manager',
    },
    'meetingNotes': {'owner': 'Defne', 'meeting': 'Weekly ops sync'},
    'storeListing': {
      'app': 'Olivara',
      'subtitle': 'Fresh olive oil, delivered',
      'oneLiner': 'olive oil straight from the grove',
      'audience': 'home cooks',
      'features':
          'Order in two taps\nManage your refill subscription\nRecipes from our partner growers\nTrack every delivery',
      'price': 'Free to download. Pay only for your orders.',
      'proof': 'Rated 4.9 by 8,000 customers',
    },
    'asoKeywords': {
      'app': 'Olivara',
      'primary': 'olive oil',
      'secondary': 'grocery',
      'audience': 'cook',
      'keywords': 'organic,food,delivery,recipes,gourmet,healthy,shop,gift',
      'competitor': 'GroveBox',
    },
    'reviewReply': {
      'app': 'Olivara',
      'topic': 'the delivery time',
      'email': 'help@olivara.shop',
    },
    'appPrivacy': {
      'app': 'Olivara',
      'developer': 'Olivara Ltd.',
      'email': 'privacy@olivara.shop',
    },
  },
  samples: {
    'competitors': [
      SampleText('Golden Press', {
        'price': '\$37 a bottle',
        'strength': 'Beautiful branding',
        'weakness': 'Very expensive',
      }),
      SampleText('Supermarket brands', {
        'price': '\$9 a bottle',
        'strength': 'Cheap and everywhere',
        'weakness': 'Blended, no harvest date',
      }),
      SampleText('GroveBox', {
        'price': '\$29 a month',
        'strength': 'Subscription model',
        'weakness': 'Ships from a single warehouse',
      }),
    ],
    'incomeExpense': [
      SampleText('Online shop sales (October)', {'category': 'Revenue'}),
      SampleText('Oil from partner groves', {'category': 'Stock'}),
      SampleText('Shipping and packaging', {'category': 'Logistics'}),
    ],
    'investorTracker': [
      SampleText('Maya Chen', {
        'firm': 'Harvest Consumer Fund',
        'next': 'Partner meeting Thursday',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Angel (ex-food brand founder)',
        'next': 'Send SAFE',
      }),
      SampleText('D2C Seed Partners', {
        'firm': 'Pre-seed fund',
        'next': 'Ask Jordan for an intro',
      }),
    ],
    'kanban': [
      SampleText('Shoot holiday gift box photos', {'owner': 'Leo'}),
      SampleText('Negotiate shipping rates to the US', {'owner': 'Defne'}),
      SampleText('Launch the refill subscription', {'owner': 'Leo'}),
    ],
    'okr': [
      SampleText('Repeat purchase rate above 40%', {
        'objective': 'Make customers come back',
      }),
      SampleText('1,000 subscription members', {
        'objective': 'Make customers come back',
      }),
      SampleText('Open a US warehouse', {'objective': 'Ship faster to the US'}),
    ],
    'roadmap': [
      SampleText('Holiday gift boxes', {'why': 'Top request last December'}),
      SampleText('US warehouse', {'why': 'Cuts delivery to 3 days'}),
      SampleText('Flavoured oils', {'why': 'Higher margin, new customers'}),
    ],
    'standup': [
      SampleText('Packed 120 holiday orders', {'who': 'Ali'}),
      SampleText('Call with the new courier', {'who': 'Defne'}),
      SampleText('Waiting for labels from the printer', {'who': 'Leo'}),
    ],
    'contentCalendar': [
      SampleText('How to tell fresh olive oil from old', {'channel': 'Blog'}),
      SampleText('Harvest day at our partner grove', {'channel': 'Instagram'}),
      SampleText('Holiday gift guide', {'channel': 'Newsletter'}),
    ],
    'crm': [
      SampleText('Priya Patel', {
        'company': 'Bella Cucina',
        'next': 'Tasting Tue 10:00',
      }),
      SampleText('Marco Rossi', {
        'company': 'Rossi Deli',
        'next': 'Follow up Friday',
      }),
      SampleText('Hanna Berg', {
        'company': 'Berg Bistro',
        'next': 'First delivery',
      }),
    ],
    'followUps': [
      SampleText('Priya: send tasting notes', {
        'note': 'Include the price list',
      }),
      SampleText('Maya: partner meeting notes', {
        'note': 'Waiting for feedback',
      }),
      SampleText('Hanna: first delivery check-in', {'note': 'All good'}),
    ],
    'feedback': [
      SampleText('Smaller trial bottle', {'from': 'Shop reviews'}),
      SampleText('Plastic-free packaging', {'from': 'Instagram followers'}),
      SampleText('Faster delivery', {'from': 'Order survey'}),
    ],
    'meetingNotes': [
      SampleText('Send investor update', {
        'owner': 'Defne',
        'meeting': 'Weekly ops sync',
      }),
      SampleText('Fix checkout drop-off', {
        'owner': 'Leo',
        'meeting': 'Growth review',
      }),
      SampleText('Choose a courier for the US', {
        'owner': 'Ali',
        'meeting': 'Weekly ops sync',
      }),
    ],
    'kpiBoard': [
      SampleText('Monthly revenue', {
        'current': '\$42,000',
        'target': '\$50,000',
      }),
      SampleText('Repeat purchase rate', {'current': '34%', 'target': '40%'}),
      SampleText('Return rate', {'current': '5%', 'target': '2%'}),
    ],
  },
);
