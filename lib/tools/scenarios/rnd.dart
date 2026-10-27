import '../l10n/tool_text.dart';
import 'rnd_de.dart';
import 'rnd_es.dart';
import 'rnd_fr.dart';
import 'rnd_tr.dart';
import 'scenario.dart';

// R&D / deep tech example: Terralab builds a low-cost soil probe and a
// machine-learning model that tells farms when to water. Patent pending,
// grant funded, piloting on 12 farms. The default example of the app.

const rndScenario = <String, ScenarioText>{
  'en': _en,
  'tr': rndTr,
  'fr': rndFr,
  'es': rndEs,
  'de': rndDe,
};

const _en = ScenarioText(
  fields: {
    'leanCanvas': {
      'company': 'Terralab',
      'problem':
          'Farms over-irrigate by 30–40% because soil moisture is guessed.\n'
          'Lab-grade soil sensors cost over \$1,000 each.\n'
          'Water prices and drought rules keep rising.',
      'solution':
          'A \$90 probe that measures moisture at three depths.\n'
          'A machine-learning model that turns readings into a daily irrigation plan.\n'
          'Alerts on the phone, no agronomist needed.',
      'uvp':
          'Lab-grade soil data at a tenth of the price, so every field is watered by need, not habit.',
      'segment': 'Mid-size fruit and vegetable farms in dry regions',
      'channels':
          'Farming cooperatives\nIrrigation equipment dealers\nField days and agri fairs',
      'revenue': 'Probes: \$90 each\nData platform: \$4 per probe per month',
      'costs': 'R&D staff and lab tests\nProbe manufacturing\nField pilots',
      'metrics':
          'Water saved per hectare\nProbes installed\nPilot-to-paid conversion',
      'advantage':
          'Patent-pending sensing method and 3 years of field data from university trials.',
    },
    'swot': {
      'company': 'Terralab',
      'strengths':
          'Patent-pending sensor design\nUniversity lab partnership\nField data from 12 pilot farms',
      'weaknesses':
          'Long hardware development cycles\nNo certified production line yet\nSmall sales team',
      'opportunities':
          'Public grants for water efficiency\nStricter irrigation rules in drought regions\nCooperatives buying in bulk',
      'threats':
          'Large irrigation brands adding sensors\nShortages of electronic components',
    },
    'competitors': {
      'price': '\$1,200 per sensor',
      'strength': 'Accuracy',
      'weakness': 'Expensive',
    },
    'persona': {
      'name': 'Grower Gabriel',
      'role': 'Owner of a 40-hectare orchard',
      'age': '47',
      'location': 'Central Valley, California',
      'goals':
          'Cut water costs without losing yield\nMeet the new irrigation rules',
      'pains':
          'Waters by habit and only notices problems once the trees are stressed',
      'tools':
          'A weather app\nAn irrigation timer\nAdvice from the co-op agronomist',
      'quote': 'I don’t need more data. I need to know when to water.',
      'channels':
          'Cooperative meetings\nIrrigation dealers\nWhatsApp groups of local growers',
    },
    'interviewQuestions': {
      'segment': 'Orchard and vegetable growers',
      'problemArea': 'irrigation planning',
      'product': 'Terralab',
    },
    'invoice': {
      'company': 'Terralab Ltd.',
      'email': 'billing@terralab.io',
      'client': 'Green Valley Cooperative',
      'item1': 'Soil probe kit (10 probes)',
      'item2': 'Data platform, annual licence per farm',
    },
    'incomeExpense': {'category': 'Lab'},
    'pitchDeck': {
      'company': 'Terralab',
      'oneLiner':
          'Low-cost soil sensors that tell farms exactly when to water.',
      'problem':
          'Farms over-irrigate by 30–40% because accurate soil sensors cost over \$1,000.',
      'solution':
          'A \$90 probe and a machine-learning model that turn soil readings into a daily irrigation plan.',
      'market': '570k mid-size farms in dry regions; \$2.1B serviceable market',
      'model': 'Probe sales plus \$4 per probe per month for the data platform',
      'traction':
          '12 pilot farms, 31% average water saving, patent filed, \$250k R&D grant',
      'competition':
          'Lab sensors (accurate but expensive), satellite services (cheap but coarse)',
      'team':
          'Elif (CEO, agronomist), Can (CTO, PhD in sensors), Jonas (hardware lead, ex-irrigation maker)',
      'ask': '\$1.2M seed to certify production and reach 300 farms',
      'email': 'founders@terralab.io',
    },
    'onePager': {
      'company': 'Terralab',
      'oneLiner':
          'Low-cost soil sensors that tell farms exactly when to water.',
      'problem':
          'Farms over-irrigate by 30–40% because accurate soil sensors cost over \$1,000.',
      'solution':
          'A \$90 probe and a machine-learning model that turn soil readings into a daily irrigation plan.',
      'customer': 'Mid-size fruit and vegetable farms in dry regions',
      'market': '\$2.1B serviceable market',
      'traction': '12 pilot farms, 31% water saving, patent filed',
      'team': 'Elif (CEO), Can (CTO), Jonas (Hardware)',
      'ask': '\$1.2M seed',
      'email': 'founders@terralab.io',
    },
    'investorTracker': {'firm': 'Impact fund', 'next': 'Send pilot results'},
    'kanban': {'owner': 'Elif'},
    'okr': {'objective': 'Prove water savings in the field'},
    'roadmap': {'why': 'Asked for by pilot farms'},
    'userStory': {
      'feature': 'Daily irrigation plan',
      'user': 'farm manager',
      'want': 'see how long to water each field today',
      'benefit': 'I stop guessing and save water',
      'criteria':
          'Plan is ready by 6 a.m. every day\nShows minutes per field and zone\nExplains the reason in one line\nWorks with the irrigation timer the farm already has',
      'outOfScope': 'Automatic valve control\nFertiliser advice',
      'metric': '25% less water on pilot farms within one season',
    },
    'standup': {'who': 'Elif'},
    'brandName': {
      'keyword': 'soil',
      'keyword2': 'terra',
      'benefit': 'water every field by need, not habit',
      'audience': 'growers',
    },
    'colorPalette': {'company': 'Terralab'},
    'landingPage': {
      'company': 'Terralab',
      'audience': 'growers',
      'outcome': 'Know exactly when to water',
      'problem':
          'Watering by habit wastes water, money and sometimes the harvest.',
      'features':
          'A \$90 probe that reads three soil depths\nA daily irrigation plan for every field\nAlerts before plants get stressed',
      'proof': 'Tested on 12 farms with 31% water savings',
      'cta': 'Book a pilot',
    },
    'emailTemplates': {
      'sender': 'Elif',
      'company': 'Terralab',
      'oneLiner': 'low-cost soil sensors that tell farms when to water',
      'hook': 'your talk on climate tech at the AgriFood Summit',
      'traction': '12 pilot farms and a filed patent',
    },
    'seoKeywords': {
      'topic': 'soil moisture sensor',
      'audience': 'growers',
      'alternative': 'tensiometers',
      'location': 'California',
    },
    'crm': {'company': 'Green Valley Co-op', 'next': 'Book a field visit'},
    'proposal': {
      'company': 'Terralab Ltd.',
      'client': 'Green Valley Cooperative',
      'need':
          'Green Valley wants its 15 member farms to cut irrigation water without losing yield.',
      'scope':
          '60 soil probes installed on 15 farms\nData platform for one season\nTraining day for farm managers',
      'timeline': 'Probes installed within three weeks of signing',
      'sender': 'Elif Kaya',
    },
    'followUps': {'note': 'Send pilot results'},
    'feedback': {'from': 'Pilot farm'},
    'nda': {
      'company': 'Terralab Ltd.',
      'otherParty': 'Green Valley Cooperative',
      'purpose': 'evaluating a joint field trial',
    },
    'privacyTerms': {
      'company': 'Terralab Ltd.',
      'service': 'the Terralab app and soil probes',
      'email': 'privacy@terralab.io',
      'data':
          'Name and email\nFarm location and field boundaries\nSoil readings from your probes\nApp usage analytics',
    },
    'contract': {
      'company': 'Terralab Ltd.',
      'scope': 'Design a weatherproof probe housing for field use',
    },
    'jobPost': {
      'company': 'Terralab',
      'oneLiner': 'low-cost soil sensors that tell farms when to water',
      'title': 'Embedded Firmware Engineer',
      'location': 'Hybrid (lab visits twice a week)',
      'responsibilities':
          'Own the probe firmware from prototype to production\nCut power use to reach two seasons on one battery\nJoin field tests with pilot farms',
      'requirements':
          '3+ years of embedded C on low-power devices\nExperience with sensors or radio (LoRa, BLE)\nAs comfortable in a field as in the lab',
      'email': 'jobs@terralab.io',
    },
    'interviewLibrary': {
      'company': 'Terralab',
      'title': 'Embedded Firmware Engineer',
    },
    'meetingNotes': {'owner': 'Elif', 'meeting': 'Weekly R&D sync'},
    'storeListing': {
      'app': 'Terralab',
      'subtitle': 'Smart irrigation for growers',
      'oneLiner': 'soil sensors that tell you when to water',
      'audience': 'growers',
      'features':
          'A daily irrigation plan for every field\nSoil moisture at three depths\nAlerts before plants get stressed\nWater-saving reports for grants and audits',
      'price': 'Included with every Terralab probe.',
      'proof': 'Used on 12 pilot farms',
    },
    'asoKeywords': {
      'app': 'Terralab',
      'primary': 'irrigation',
      'secondary': 'soil',
      'audience': 'farmer',
      'keywords': 'sensor,moisture,water,farm,garden,orchard,crop,drip',
      'competitor': 'AquaProbe',
    },
    'reviewReply': {
      'app': 'Terralab',
      'topic': 'the watering alerts',
      'email': 'help@terralab.io',
    },
    'appPrivacy': {
      'app': 'Terralab',
      'developer': 'Terralab Ltd.',
      'email': 'privacy@terralab.io',
    },
  },
  samples: {
    'competitors': [
      SampleText('AquaProbe Pro', {
        'price': '\$1,200 per sensor',
        'strength': 'Lab-grade accuracy',
        'weakness': 'Too expensive for most farms',
      }),
      SampleText('Tensiometers', {
        'price': 'From \$80',
        'strength': 'Cheap and well known',
        'weakness': 'Manual readings at one depth',
      }),
      SampleText('SatIrrig', {
        'price': '\$6 per hectare a month',
        'strength': 'No hardware needed',
        'weakness': 'Satellite data too coarse for one field',
      }),
    ],
    'incomeExpense': [
      SampleText('Pilot farm subscriptions', {'category': 'Revenue'}),
      SampleText('Engineer salaries', {'category': 'Team'}),
      SampleText('Lab tests and components', {'category': 'R&D'}),
    ],
    'investorTracker': [
      SampleText('Maya Chen', {
        'firm': 'AgriTech Ventures',
        'next': 'Partner meeting Thursday',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Angel (ex-irrigation CEO)',
        'next': 'Send SAFE',
      }),
      SampleText('Climate Seed Fund', {
        'firm': 'Climate fund',
        'next': 'Ask Jordan for an intro',
      }),
    ],
    'kanban': [
      SampleText('Calibrate probe batch #4', {'owner': 'Can'}),
      SampleText('Prepare grant progress report', {'owner': 'Elif'}),
      SampleText('Install probes at pilot farm 12', {'owner': 'Jonas'}),
    ],
    'okr': [
      SampleText('Run pilots on 20 farms', {
        'objective': 'Prove water savings in the field',
      }),
      SampleText('Average water saving above 25%', {
        'objective': 'Prove water savings in the field',
      }),
      SampleText('Pass CE certification', {
        'objective': 'Get ready for production',
      }),
    ],
    'roadmap': [
      SampleText('Two seasons on one battery', {
        'why': 'Top request from pilot farms',
      }),
      SampleText('LoRaWAN gateway support', {
        'why': 'Farms without mobile coverage',
      }),
      SampleText('Fertiliser recommendations', {
        'why': 'Opens a second revenue line',
      }),
    ],
    'standup': [
      SampleText('Finished field test at pilot farm 7', {'who': 'Jonas'}),
      SampleText('Call with the patent attorney', {'who': 'Elif'}),
      SampleText('Waiting for sensor chips from the supplier', {'who': 'Can'}),
    ],
    'contentCalendar': [
      SampleText('What 12 pilot farms taught us about water', {
        'channel': 'Blog',
      }),
      SampleText('Inside the lab: how a probe is calibrated', {
        'channel': 'LinkedIn',
      }),
      SampleText('Irrigation tips before the summer peak', {
        'channel': 'Instagram',
      }),
    ],
    'crm': [
      SampleText('Priya Patel', {
        'company': 'Green Valley Co-op',
        'next': 'Field demo Tue 10:00',
      }),
      SampleText('Marco Rossi', {
        'company': 'Rossi Orchards',
        'next': 'Follow up Friday',
      }),
      SampleText('Hanna Berg', {
        'company': 'Berg Vineyards',
        'next': 'Install probes',
      }),
    ],
    'followUps': [
      SampleText('Priya: send field demo report', {
        'note': 'Include the water savings chart',
      }),
      SampleText('Maya: partner meeting notes', {
        'note': 'Waiting for feedback',
      }),
      SampleText('Hanna: season check-in', {'note': 'All probes online'}),
    ],
    'feedback': [
      SampleText('Longer battery life', {'from': 'Pilot farms 2, 5, 9'}),
      SampleText('Spanish in the app', {'from': 'Rossi Orchards'}),
      SampleText('Clearer watering alerts', {'from': 'Pilot group'}),
    ],
    'meetingNotes': [
      SampleText('Send grant progress report', {
        'owner': 'Elif',
        'meeting': 'Weekly R&D sync',
      }),
      SampleText('Fix probe drift at low temperatures', {
        'owner': 'Can',
        'meeting': 'Lab review',
      }),
      SampleText('Choose a manufacturing partner', {
        'owner': 'Jonas',
        'meeting': 'Weekly R&D sync',
      }),
    ],
    'kpiBoard': [
      SampleText('Farms with probes installed', {
        'current': '12',
        'target': '20',
      }),
      SampleText('Average water saving', {'current': '22%', 'target': '25%'}),
      SampleText('Probe failure rate', {'current': '6%', 'target': '2%'}),
    ],
  },
);
