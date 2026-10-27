import '../l10n/tool_text.dart';
import 'mobile_app_de.dart';
import 'mobile_app_es.dart';
import 'mobile_app_fr.dart';
import 'mobile_app_tr.dart';
import 'scenario.dart';

// Mobile app example: Pacely is an AI running coach that adapts each
// week's plan to how the runner actually slept, trained and felt.

const mobileAppScenario = <String, ScenarioText>{
  'en': _en,
  'tr': mobileAppTr,
  'fr': mobileAppFr,
  'es': mobileAppEs,
  'de': mobileAppDe,
};

const _en = ScenarioText(
  fields: {
    'leanCanvas': {
      'company': 'Pacely',
      'problem':
          'Generic running plans ignore sleep, stress and missed sessions.\n'
          'Beginners get injured by doing too much too soon.\n'
          'Human coaches are too expensive for most runners.',
      'solution':
          'An AI coach that rewrites the week after every run.\n'
          'Load warnings before an injury, not after.\n'
          'Voice cues during the run, in plain words.',
      'uvp': 'A running coach in your pocket that adapts to your real week.',
      'segment':
          'Recreational runners training for their first 10K or half marathon',
      'channels':
          'App Store and Google Play\nRunning clubs\nInstagram and Strava communities',
      'revenue': 'Free plan\nPremium: \$9.99 a month or \$59.99 a year',
      'costs': 'App development\nCloud and AI costs\nApp store fees',
      'metrics':
          'Weekly active runners\nFree-to-paid conversion\n30-day retention',
      'advantage':
          'A training model built with sports scientists on 2 million real runs.',
    },
    'swot': {
      'company': 'Pacely',
      'strengths':
          'Plans that adapt every week\nHigh App Store rating\nSports scientists on the team',
      'weaknesses':
          'Depends on watch data\nSmall marketing budget\nOnly running, no other sports',
      'opportunities':
          'More people signing up for races\nPartnerships with race organisers\nCorporate wellness programmes',
      'threats':
          'Watch makers adding their own coaching\nPlatform rule changes on subscriptions',
    },
    'competitors': {
      'price': '\$12.99 a month',
      'strength': 'Brand',
      'weakness': 'Fixed plans',
    },
    'persona': {
      'name': 'Runner Rachel',
      'role': 'Teacher training for her first half marathon',
      'age': '31',
      'location': 'Chicago, Illinois',
      'goals': 'Finish a half marathon without injury\nRun three times a week',
      'pains':
          'Every plan falls apart after one bad week, and she has already had shin splints',
      'tools': 'A smartwatch\nStrava\nYouTube running videos',
      'quote':
          'I don’t need a plan for a perfect week. I need one for my week.',
      'channels':
          'Local running club\nInstagram running accounts\nRace newsletters',
    },
    'interviewQuestions': {
      'segment': 'Recreational runners',
      'problemArea': 'training for a race',
      'product': 'Pacely',
    },
    'invoice': {
      'company': 'Pacely Inc.',
      'email': 'billing@pacely.app',
      'client': 'Lakeside Half Marathon',
      'item1': 'Official training plan partnership (season)',
      'item2': 'Premium codes for 500 runners',
    },
    'incomeExpense': {'category': 'Cloud'},
    'pitchDeck': {
      'company': 'Pacely',
      'oneLiner':
          'An AI running coach that adapts your plan to your real week.',
      'problem':
          'Most runners follow fixed plans that break after one bad week, and many get injured.',
      'solution':
          'Pacely rewrites each week from your sleep, runs and how you felt, and warns you before you overdo it.',
      'market':
          '60M recreational runners in the US and EU; \$1.2B serviceable market',
      'model': 'Freemium; Premium at \$9.99 a month or \$59.99 a year',
      'traction': '120,000 downloads, 6,500 paying runners, 4.8 rating',
      'competition':
          'Static plan apps (cheap, not adaptive), human coaches (great, but \$150 a month)',
      'team':
          'Defne (CEO, ex-product lead at a fitness app), Leo (CTO, ML engineer), Ali (head coach, sports scientist)',
      'ask': '\$1.5M seed to launch Android and grow race partnerships',
      'email': 'founders@pacely.app',
    },
    'onePager': {
      'company': 'Pacely',
      'oneLiner':
          'An AI running coach that adapts your plan to your real week.',
      'problem':
          'Most runners follow fixed plans that break after one bad week, and many get injured.',
      'solution':
          'Pacely rewrites each week from your sleep, runs and how you felt, and warns you before you overdo it.',
      'customer': 'Recreational runners training for a race',
      'market': '\$1.2B serviceable market',
      'traction': '120,000 downloads, 6,500 paying runners',
      'team': 'Defne (CEO), Leo (CTO), Ali (Head coach)',
      'ask': '\$1.5M seed',
      'email': 'founders@pacely.app',
    },
    'investorTracker': {
      'firm': 'Consumer app fund',
      'next': 'Send retention data',
    },
    'kanban': {'owner': 'Leo'},
    'okr': {'objective': 'Keep runners training'},
    'roadmap': {'why': 'Runners ask for it'},
    'userStory': {
      'feature': 'Missed run recovery',
      'user': 'runner',
      'want': 'my plan to adjust when I miss a run',
      'benefit': 'I stay on track without doubling up and getting hurt',
      'criteria':
          'A missed run is detected by the next morning\nThe rest of the week is rebalanced automatically\nWeekly distance never jumps more than 10%\nThe runner sees what changed and why',
      'outOfScope': 'Cross-training plans\nManual editing of every session',
      'metric': '15% fewer runners quitting their plan in the first month',
    },
    'standup': {'who': 'Leo'},
    'brandName': {
      'keyword': 'pace',
      'keyword2': 'stride',
      'benefit': 'train smarter, not harder',
      'audience': 'runners',
    },
    'colorPalette': {'company': 'Pacely'},
    'landingPage': {
      'company': 'Pacely',
      'audience': 'runners',
      'outcome': 'Reach race day fit, not injured',
      'problem': 'Fixed plans break the first time life gets busy.',
      'features':
          'A plan that adapts after every run\nWarnings before you overtrain\nVoice coaching while you run',
      'proof': 'Rated 4.8 by 6,500 runners',
      'cta': 'Start free',
    },
    'emailTemplates': {
      'sender': 'Defne',
      'company': 'Pacely',
      'oneLiner': 'an AI running coach that adapts to your real week',
      'hook': 'your talk about injuries in new runners',
      'traction': '6,500 paying runners and a 4.8 rating',
    },
    'seoKeywords': {
      'topic': 'half marathon training',
      'audience': 'beginner runners',
      'alternative': 'a running coach',
      'location': 'Chicago',
    },
    'crm': {
      'company': 'Lakeside Half Marathon',
      'next': 'Send partnership deck',
    },
    'proposal': {
      'company': 'Pacely Inc.',
      'client': 'Lakeside Half Marathon',
      'need':
          'Lakeside wants more first-time runners to reach the start line ready and to finish the race.',
      'scope':
          'Official Pacely training plan for the race\n3 months of Premium for every registered runner\nA finisher report for the organisers',
      'timeline': 'Plan live 16 weeks before race day',
      'sender': 'Defne Arslan',
    },
    'followUps': {'note': 'Send partnership deck'},
    'feedback': {'from': 'Runner'},
    'nda': {
      'company': 'Pacely Inc.',
      'otherParty': 'Lakeside Events LLC',
      'purpose': 'evaluating a race partnership',
    },
    'privacyTerms': {
      'company': 'Pacely Inc.',
      'service': 'the Pacely app',
      'email': 'privacy@pacely.app',
      'data':
          'Name and email\nRun and heart rate data\nSleep data you choose to share\nApp analytics',
    },
    'contract': {
      'company': 'Pacely Inc.',
      'scope': 'Record the voice coaching cues in English',
    },
    'jobPost': {
      'company': 'Pacely',
      'oneLiner': 'an AI running coach that adapts to your real week',
      'title': 'Senior Mobile Engineer (Flutter)',
      'location': 'Remote (US or European time zones)',
      'responsibilities':
          'Build new features in our Flutter app\nConnect with watches and health platforms\nKeep the app fast and crash-free',
      'requirements':
          '4+ years building mobile apps\nShipped a Flutter app to both stores\nYou run, or want to',
      'email': 'jobs@pacely.app',
    },
    'interviewLibrary': {
      'company': 'Pacely',
      'title': 'Senior Mobile Engineer',
    },
    'meetingNotes': {'owner': 'Leo', 'meeting': 'Weekly product sync'},
    'storeListing': {
      'app': 'Pacely',
      'subtitle': 'AI running coach',
      'oneLiner': 'a running plan that adapts to your week',
      'audience': 'runners of every level',
      'features':
          'Plans for 5K to marathon\nAdapts after every run\nWarnings before you overtrain\nWorks with your watch',
      'price': 'Free to start. Premium from \$9.99 a month.',
      'proof': 'Rated 4.8 by 6,500 runners',
    },
    'asoKeywords': {
      'app': 'Pacely',
      'primary': 'running coach',
      'secondary': 'marathon',
      'audience': 'runner',
      'keywords': 'run,training,plan,5k,10k,pace,jogging,fitness',
      'competitor': 'StrideMate',
    },
    'reviewReply': {
      'app': 'Pacely',
      'topic': 'the watch sync',
      'email': 'help@pacely.app',
    },
    'appPrivacy': {
      'app': 'Pacely',
      'developer': 'Pacely Inc.',
      'email': 'privacy@pacely.app',
    },
  },
  samples: {
    'competitors': [
      SampleText('StrideMate', {
        'price': '\$12.99 a month',
        'strength': 'Huge plan library',
        'weakness': 'Plans never adapt',
      }),
      SampleText('Watch maker apps', {
        'price': 'Free with the watch',
        'strength': 'Already on the wrist',
        'weakness': 'Basic coaching',
      }),
      SampleText('Human coaches', {
        'price': '\$150 a month',
        'strength': 'Truly personal',
        'weakness': 'Too expensive for most',
      }),
    ],
    'incomeExpense': [
      SampleText('App store subscriptions (October)', {'category': 'Revenue'}),
      SampleText('Cloud and AI hosting', {'category': 'Cloud'}),
      SampleText('Instagram ads', {'category': 'Marketing'}),
    ],
    'investorTracker': [
      SampleText('Maya Chen', {
        'firm': 'Stride Ventures',
        'next': 'Partner meeting Thursday',
      }),
      SampleText('Jordan Ellis', {
        'firm': 'Angel (ex-fitness app founder)',
        'next': 'Send SAFE',
      }),
      SampleText('App Seed Partners', {
        'firm': 'Pre-seed fund',
        'next': 'Ask Jordan for an intro',
      }),
    ],
    'kanban': [
      SampleText('Ship the Android beta', {'owner': 'Leo'}),
      SampleText('Fix watch sync on older phones', {'owner': 'Leo'}),
      SampleText('Write the new paywall copy', {'owner': 'Defne'}),
    ],
    'okr': [
      SampleText('30-day retention above 40%', {
        'objective': 'Keep runners training',
      }),
      SampleText('10,000 paying runners', {'objective': 'Grow Premium'}),
      SampleText('Crash-free sessions above 99.5%', {
        'objective': 'Keep runners training',
      }),
    ],
    'roadmap': [
      SampleText('Android app', {'why': 'Half of the waitlist uses Android'}),
      SampleText('Race partnerships', {
        'why': 'Brings runners at the right moment',
      }),
      SampleText('Strength workouts', {'why': 'Helps prevent injuries'}),
    ],
    'standup': [
      SampleText('Released version 2.3', {'who': 'Leo'}),
      SampleText('Call with the race organiser', {'who': 'Defne'}),
      SampleText('Waiting for App Review', {'who': 'Leo'}),
    ],
    'contentCalendar': [
      SampleText('How to train for your first half marathon', {
        'channel': 'Blog',
      }),
      SampleText('Runner story: from couch to 10K', {'channel': 'Instagram'}),
      SampleText('What’s new in version 2.3', {'channel': 'Newsletter'}),
    ],
    'crm': [
      SampleText('Priya Patel', {
        'company': 'Lakeside Half Marathon',
        'next': 'Demo Tue 10:00',
      }),
      SampleText('Marco Rossi', {
        'company': 'City Runners Club',
        'next': 'Follow up Friday',
      }),
      SampleText('Hanna Berg', {
        'company': 'FitWork Wellness',
        'next': 'Pilot kickoff',
      }),
    ],
    'followUps': [
      SampleText('Priya: send the partnership deck', {
        'note': 'Include last season’s results',
      }),
      SampleText('Maya: partner meeting notes', {
        'note': 'Waiting for feedback',
      }),
      SampleText('Hanna: pilot check-in', {'note': 'All good'}),
    ],
    'feedback': [
      SampleText('Treadmill mode', {'from': 'App Store reviews'}),
      SampleText('Share plan with a friend', {'from': 'In-app survey'}),
      SampleText('Apple Watch app', {'from': 'Support emails'}),
    ],
    'meetingNotes': [
      SampleText('Send investor update', {
        'owner': 'Defne',
        'meeting': 'Weekly product sync',
      }),
      SampleText('Fix paywall drop-off', {
        'owner': 'Leo',
        'meeting': 'Growth review',
      }),
      SampleText('Review the new plan model', {
        'owner': 'Ali',
        'meeting': 'Weekly product sync',
      }),
    ],
    'kpiBoard': [
      SampleText('Monthly recurring revenue', {
        'current': '\$38,000',
        'target': '\$50,000',
      }),
      SampleText('30-day retention', {'current': '34%', 'target': '40%'}),
      SampleText('Monthly churn', {'current': '5%', 'target': '2%'}),
    ],
  },
);
