import 'tool_text.dart';

/// Finance tools (`catalog/finance.dart`) per language.
const financeText = <String, Map<String, ToolText>>{
  'tr': _tr,
  'fr': _fr,
  'es': _es,
  'de': _de,
};

const _tr = <String, ToolText>{
  'runway': ToolText(
    name: 'Pist ve yakım hızı',
    description: 'Para bitene kadar kaç ay kaldığı.',
    fields: {
      'cash': FieldText('Bankadaki nakit'),
      'monthlyExpenses': FieldText('Aylık giderler'),
      'monthlyRevenue': FieldText('Aylık gelir'),
    },
  ),
  'unitEconomics': ToolText(
    name: 'Birim ekonomisi',
    description: 'Bir müşteri için LTV, CAC ve geri ödeme süresi.',
    fields: {
      'arpu': FieldText('Müşteri başı gelir / ay'),
      'grossMargin': FieldText('Brüt marj'),
      'churn': FieldText('Aylık kayıp oranı'),
      'cac': FieldText('Müşteri edinme maliyeti'),
    },
  ),
  'pricing': ToolText(
    name: 'Fiyat hesaplayıcı',
    description: 'Maliyet ve hedef marjdan fiyat.',
    fields: {
      'unitCost': FieldText('Birim maliyet'),
      'targetMargin': FieldText('Hedef marj'),
      'competitorPrice': FieldText('Rakip fiyatı'),
    },
  ),
  'invoice': ToolText(
    name: 'Fatura oluşturucu',
    description: 'Toplamları ve vergisiyle temiz bir fatura.',
    fields: {
      'company': FieldText('Şirket adı', example: 'Nimbly A.Ş.'),
      'email': FieldText('İletişim e-postası'),
      'client': FieldText('Müşteri', example: 'Studio North Ltd. Şti.'),
      'number': FieldText('Fatura numarası'),
      'date': FieldText('Düzenleme tarihi', example: '19 Ekim 2026'),
      'due': FieldText('Son ödeme tarihi', example: '18 Kasım 2026'),
      'item1': FieldText('Kalem 1', example: 'Başlangıç atölyesi'),
      'qty1': FieldText('Kalem 1 adet'),
      'price1': FieldText('Kalem 1 birim fiyat'),
      'item2': FieldText('Kalem 2', example: 'Yıllık abonelik koltukları'),
      'qty2': FieldText('Kalem 2 adet'),
      'price2': FieldText('Kalem 2 birim fiyat'),
      'tax': FieldText('KDV oranı'),
      'payment': FieldText(
        'Ödeme bilgileri',
        example: 'IBAN TR00 0000 0000 0000 hesabına havale',
      ),
    },
    template: r'''FATURA {number}

Düzenleyen: {company} ({email})
Alıcı: {client}
Düzenleme: {date}
Son ödeme: {due}

KALEMLER
{item1}: {qty1} × {price1|money} = {=qty1 * price1|money}
{item2}: {qty2} × {price2|money} = {=qty2 * price2|money}

Ara toplam: {=qty1 * price1 + qty2 * price2|money}
KDV (%{tax}): {=(qty1 * price1 + qty2 * price2) * tax / 100|money}
ÖDENECEK TOPLAM: {=(qty1 * price1 + qty2 * price2) * (1 + tax / 100)|money}

Ödeme: {payment}
Bizi tercih ettiğiniz için teşekkür ederiz.''',
  ),
  'capTable': ToolText(
    name: 'Hisse tablosu simülatörü',
    description: 'Bir turdan sonra sulanma ve hisse fiyatı.',
    fields: {
      'preMoney': FieldText('Yatırım öncesi değerleme'),
      'investment': FieldText('Yatırım'),
      'existingShares': FieldText('Mevcut hisseler'),
    },
  ),
  'incomeExpense': ToolText(
    name: 'Gelir ve gider takibi',
    description: 'Giren ve çıkan para, bir bakışta.',
    itemLabel: 'Kayıt',
    stages: {'Income': 'Gelir', 'Expense': 'Gider'},
    fields: {
      'amount': FieldText('Tutar'),
      'date': FieldText('Tarih', example: '1 Eki'),
      'category': FieldText('Kategori', example: 'Yazılım'),
    },
    samples: [
      SampleText('Abonelikler (Ekim)', {'date': '31 Eki', 'category': 'Gelir'}),
      SampleText('Maaşlar', {'date': '28 Eki', 'category': 'Ekip'}),
      SampleText('Bulut barındırma', {'date': '3 Eki', 'category': 'Yazılım'}),
    ],
  ),
};

const _fr = <String, ToolText>{
  'runway': ToolText(
    name: 'Runway et burn rate',
    description: 'Combien de mois avant d’être à court d’argent.',
    fields: {
      'cash': FieldText('Trésorerie en banque'),
      'monthlyExpenses': FieldText('Dépenses mensuelles'),
      'monthlyRevenue': FieldText('Revenu mensuel'),
    },
  ),
  'unitEconomics': ToolText(
    name: 'Économie unitaire',
    description: 'LTV, CAC et délai de retour pour un client.',
    fields: {
      'arpu': FieldText('Revenu par client / mois'),
      'grossMargin': FieldText('Marge brute'),
      'churn': FieldText('Churn mensuel'),
      'cac': FieldText('Coût d’acquisition client'),
    },
  ),
  'pricing': ToolText(
    name: 'Calculateur de prix',
    description: 'Un prix à partir du coût et de la marge visée.',
    fields: {
      'unitCost': FieldText('Coût unitaire'),
      'targetMargin': FieldText('Marge visée'),
      'competitorPrice': FieldText('Prix du concurrent'),
    },
  ),
  'invoice': ToolText(
    name: 'Générateur de factures',
    description: 'Une facture claire avec totaux et taxes.',
    fields: {
      'company': FieldText('Nom de l’entreprise', example: 'Nimbly SAS'),
      'email': FieldText('E-mail de contact'),
      'client': FieldText('Client', example: 'Studio North SARL'),
      'number': FieldText('Numéro de facture'),
      'date': FieldText('Date d’émission', example: '19 oct. 2026'),
      'due': FieldText('Date d’échéance', example: '18 nov. 2026'),
      'item1': FieldText('Article 1', example: 'Atelier de prise en main'),
      'qty1': FieldText('Quantité article 1'),
      'price1': FieldText('Prix unitaire article 1'),
      'item2': FieldText('Article 2', example: 'Licences d’abonnement annuel'),
      'qty2': FieldText('Quantité article 2'),
      'price2': FieldText('Prix unitaire article 2'),
      'tax': FieldText('Taux de TVA'),
      'payment': FieldText(
        'Modalités de paiement',
        example: 'Virement sur l’IBAN FR00 0000 0000 0000',
      ),
    },
    template: r'''FACTURE {number}

De : {company} ({email})
Facturé à : {client}
Émise le : {date}
Échéance : {due}

ARTICLES
{item1} : {qty1} × {price1|money} = {=qty1 * price1|money}
{item2} : {qty2} × {price2|money} = {=qty2 * price2|money}

Sous-total : {=qty1 * price1 + qty2 * price2|money}
TVA ({tax} %) : {=(qty1 * price1 + qty2 * price2) * tax / 100|money}
TOTAL À PAYER : {=(qty1 * price1 + qty2 * price2) * (1 + tax / 100)|money}

Paiement : {payment}
Merci pour votre confiance.''',
  ),
  'capTable': ToolText(
    name: 'Simulateur de table de capitalisation',
    description: 'Dilution et prix par action après une levée.',
    fields: {
      'preMoney': FieldText('Valorisation pre-money'),
      'investment': FieldText('Investissement'),
      'existingShares': FieldText('Actions existantes'),
    },
  ),
  'incomeExpense': ToolText(
    name: 'Suivi recettes et dépenses',
    description: 'L’argent qui entre et qui sort, en un coup d’œil.',
    itemLabel: 'Écriture',
    stages: {'Income': 'Recette', 'Expense': 'Dépense'},
    fields: {
      'amount': FieldText('Montant'),
      'date': FieldText('Date', example: '1 oct.'),
      'category': FieldText('Catégorie', example: 'Logiciels'),
    },
    samples: [
      SampleText('Abonnements (octobre)', {
        'date': '31 oct.',
        'category': 'Chiffre d’affaires',
      }),
      SampleText('Salaires', {'date': '28 oct.', 'category': 'Équipe'}),
      SampleText('Hébergement cloud', {
        'date': '3 oct.',
        'category': 'Logiciels',
      }),
    ],
  ),
};

const _es = <String, ToolText>{
  'runway': ToolText(
    name: 'Runway y burn rate',
    description: 'Cuántos meses quedan hasta que se acabe el dinero.',
    fields: {
      'cash': FieldText('Dinero en el banco'),
      'monthlyExpenses': FieldText('Gastos mensuales'),
      'monthlyRevenue': FieldText('Ingresos mensuales'),
    },
  ),
  'unitEconomics': ToolText(
    name: 'Economía unitaria',
    description: 'LTV, CAC y recuperación para un cliente.',
    fields: {
      'arpu': FieldText('Ingreso por cliente / mes'),
      'grossMargin': FieldText('Margen bruto'),
      'churn': FieldText('Churn mensual'),
      'cac': FieldText('Coste de adquirir un cliente'),
    },
  ),
  'pricing': ToolText(
    name: 'Calculadora de precios',
    description: 'Precio a partir del coste y el margen objetivo.',
    fields: {
      'unitCost': FieldText('Coste por unidad'),
      'targetMargin': FieldText('Margen objetivo'),
      'competitorPrice': FieldText('Precio del competidor'),
    },
  ),
  'invoice': ToolText(
    name: 'Generador de facturas',
    description: 'Una factura clara con totales e impuestos.',
    fields: {
      'company': FieldText('Nombre de la empresa', example: 'Nimbly S.L.'),
      'email': FieldText('Correo de contacto'),
      'client': FieldText('Cliente', example: 'Studio North S.L.'),
      'number': FieldText('Número de factura'),
      'date': FieldText('Fecha de emisión', example: '19 oct 2026'),
      'due': FieldText('Fecha de vencimiento', example: '18 nov 2026'),
      'item1': FieldText('Concepto 1', example: 'Taller de puesta en marcha'),
      'qty1': FieldText('Cantidad concepto 1'),
      'price1': FieldText('Precio unitario concepto 1'),
      'item2': FieldText(
        'Concepto 2',
        example: 'Licencias de suscripción anual',
      ),
      'qty2': FieldText('Cantidad concepto 2'),
      'price2': FieldText('Precio unitario concepto 2'),
      'tax': FieldText('Tipo de IVA'),
      'payment': FieldText(
        'Datos de pago',
        example: 'Transferencia al IBAN ES00 0000 0000 0000',
      ),
    },
    template: r'''FACTURA {number}

De: {company} ({email})
Facturar a: {client}
Emitida: {date}
Vencimiento: {due}

CONCEPTOS
{item1}: {qty1} × {price1|money} = {=qty1 * price1|money}
{item2}: {qty2} × {price2|money} = {=qty2 * price2|money}

Subtotal: {=qty1 * price1 + qty2 * price2|money}
IVA ({tax} %): {=(qty1 * price1 + qty2 * price2) * tax / 100|money}
TOTAL A PAGAR: {=(qty1 * price1 + qty2 * price2) * (1 + tax / 100)|money}

Pago: {payment}
Gracias por confiar en nosotros.''',
  ),
  'capTable': ToolText(
    name: 'Simulador de cap table',
    description: 'Dilución y precio por acción tras una ronda.',
    fields: {
      'preMoney': FieldText('Valoración pre-money'),
      'investment': FieldText('Inversión'),
      'existingShares': FieldText('Acciones existentes'),
    },
  ),
  'incomeExpense': ToolText(
    name: 'Control de ingresos y gastos',
    description: 'El dinero que entra y sale, de un vistazo.',
    itemLabel: 'Movimiento',
    stages: {'Income': 'Ingreso', 'Expense': 'Gasto'},
    fields: {
      'amount': FieldText('Importe'),
      'date': FieldText('Fecha', example: '1 oct'),
      'category': FieldText('Categoría', example: 'Software'),
    },
    samples: [
      SampleText('Suscripciones (octubre)', {
        'date': '31 oct',
        'category': 'Ingresos',
      }),
      SampleText('Nóminas', {'date': '28 oct', 'category': 'Equipo'}),
      SampleText('Alojamiento en la nube', {
        'date': '3 oct',
        'category': 'Software',
      }),
    ],
  ),
};

const _de = <String, ToolText>{
  'runway': ToolText(
    name: 'Runway & Burn Rate',
    description: 'Wie viele Monate das Geld noch reicht.',
    fields: {
      'cash': FieldText('Kontostand'),
      'monthlyExpenses': FieldText('Monatliche Ausgaben'),
      'monthlyRevenue': FieldText('Monatlicher Umsatz'),
    },
  ),
  'unitEconomics': ToolText(
    name: 'Unit Economics',
    description: 'LTV, CAC und Amortisation für einen Kunden.',
    fields: {
      'arpu': FieldText('Umsatz pro Kunde / Monat'),
      'grossMargin': FieldText('Bruttomarge'),
      'churn': FieldText('Monatlicher Churn'),
      'cac': FieldText('Kosten pro Neukunde'),
    },
  ),
  'pricing': ToolText(
    name: 'Preisrechner',
    description: 'Preis aus Kosten und Zielmarge.',
    fields: {
      'unitCost': FieldText('Kosten pro Einheit'),
      'targetMargin': FieldText('Zielmarge'),
      'competitorPrice': FieldText('Preis der Konkurrenz'),
    },
  ),
  'invoice': ToolText(
    name: 'Rechnungsgenerator',
    description: 'Eine saubere Rechnung mit Summen und Steuer.',
    fields: {
      'company': FieldText('Firmenname', example: 'Nimbly GmbH'),
      'email': FieldText('Kontakt-E-Mail'),
      'client': FieldText('Kunde', example: 'Studio North GmbH'),
      'number': FieldText('Rechnungsnummer'),
      'date': FieldText('Rechnungsdatum', example: '19. Okt. 2026'),
      'due': FieldText('Fällig am', example: '18. Nov. 2026'),
      'item1': FieldText('Position 1', example: 'Onboarding-Workshop'),
      'qty1': FieldText('Menge Position 1'),
      'price1': FieldText('Einzelpreis Position 1'),
      'item2': FieldText('Position 2', example: 'Lizenzen Jahresabo'),
      'qty2': FieldText('Menge Position 2'),
      'price2': FieldText('Einzelpreis Position 2'),
      'tax': FieldText('Umsatzsteuersatz'),
      'payment': FieldText(
        'Zahlungsdetails',
        example: 'Überweisung auf IBAN DE00 0000 0000 0000',
      ),
    },
    template: r'''RECHNUNG {number}

Von: {company} ({email})
An: {client}
Rechnungsdatum: {date}
Fällig: {due}

POSITIONEN
{item1}: {qty1} × {price1|money} = {=qty1 * price1|money}
{item2}: {qty2} × {price2|money} = {=qty2 * price2|money}

Zwischensumme: {=qty1 * price1 + qty2 * price2|money}
USt. ({tax} %): {=(qty1 * price1 + qty2 * price2) * tax / 100|money}
GESAMTBETRAG: {=(qty1 * price1 + qty2 * price2) * (1 + tax / 100)|money}

Zahlung: {payment}
Vielen Dank für Ihren Auftrag.''',
  ),
  'capTable': ToolText(
    name: 'Cap-Table-Simulator',
    description: 'Verwässerung und Anteilspreis nach einer Runde.',
    fields: {
      'preMoney': FieldText('Pre-Money-Bewertung'),
      'investment': FieldText('Investment'),
      'existingShares': FieldText('Bestehende Anteile'),
    },
  ),
  'incomeExpense': ToolText(
    name: 'Einnahmen & Ausgaben',
    description: 'Geld rein, Geld raus, auf einen Blick.',
    itemLabel: 'Buchung',
    stages: {'Income': 'Einnahme', 'Expense': 'Ausgabe'},
    fields: {
      'amount': FieldText('Betrag'),
      'date': FieldText('Datum', example: '1. Okt.'),
      'category': FieldText('Kategorie', example: 'Software'),
    },
    samples: [
      SampleText('Abos (Oktober)', {'date': '31. Okt.', 'category': 'Umsatz'}),
      SampleText('Gehälter', {'date': '28. Okt.', 'category': 'Team'}),
      SampleText('Cloud-Hosting', {'date': '3. Okt.', 'category': 'Software'}),
    ],
  ),
};
