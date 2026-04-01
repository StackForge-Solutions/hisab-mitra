import '../models/invoice_item_model.dart';
import '../models/party_model.dart';
import '../models/place_of_supply_model.dart';

class MockCatalogService {
  List<PartyModel> getSuppliers() {
    return const [
      PartyModel(
        id: 'party_1',
        name: 'Sunrise Pharma Distributors',
        gstin: '27AABCU9603R1ZX',
        address: '14 Wholesale Medicine Market',
        city: 'Mumbai',
        phone: '+91 98765 23001',
      ),
      PartyModel(
        id: 'party_2',
        name: 'Apex Lifecare Supply Co.',
        gstin: '24AAJCA1029M1ZC',
        address: 'Block B, Medico Trade Hub',
        city: 'Ahmedabad',
        phone: '+91 98765 23002',
      ),
      PartyModel(
        id: 'party_3',
        name: 'WellCure Remedies Pvt Ltd',
        gstin: '29AACCW7738P1Z6',
        address: '68 Industrial Pharma Estate',
        city: 'Bengaluru',
        phone: '+91 98765 23003',
      ),
      PartyModel(
        id: 'party_4',
        name: 'Metro Medisales',
        gstin: '07AAKCM5513D1Z2',
        address: '9 Central Drug Plaza',
        city: 'New Delhi',
        phone: '+91 98765 23004',
      ),
    ];
  }

  List<PlaceOfSupplyModel> getPlacesOfSupply() {
    return const [
      PlaceOfSupplyModel(code: '27', name: 'Maharashtra'),
      PlaceOfSupplyModel(code: '24', name: 'Gujarat'),
      PlaceOfSupplyModel(code: '29', name: 'Karnataka'),
      PlaceOfSupplyModel(code: '07', name: 'Delhi'),
      PlaceOfSupplyModel(code: '33', name: 'Tamil Nadu'),
      PlaceOfSupplyModel(code: '32', name: 'Kerala'),
      PlaceOfSupplyModel(code: '23', name: 'Madhya Pradesh'),
      PlaceOfSupplyModel(code: '09', name: 'Uttar Pradesh'),
      PlaceOfSupplyModel(code: '36', name: 'Telangana'),
      PlaceOfSupplyModel(code: '19', name: 'West Bengal'),
    ];
  }

  List<InvoiceItemModel> getItems() {
    return const [
      InvoiceItemModel(
        id: 'item_1',
        name: 'Paracetamol 650mg Tablets',
        sku: 'PCM650',
        hsnCode: '30049069',
        quantity: 10,
        unit: 'Strip',
        rate: 34,
        discount: 12,
        taxPercent: 12,
      ),
      InvoiceItemModel(
        id: 'item_2',
        name: 'Amoxicillin 500mg Capsules',
        sku: 'AMX500',
        hsnCode: '30041050',
        quantity: 8,
        unit: 'Box',
        rate: 86,
        discount: 20,
        taxPercent: 12,
      ),
      InvoiceItemModel(
        id: 'item_3',
        name: 'Omeprazole 20mg Capsules',
        sku: 'OMP20',
        hsnCode: '30049099',
        quantity: 6,
        unit: 'Box',
        rate: 71,
        discount: 10,
        taxPercent: 12,
      ),
      InvoiceItemModel(
        id: 'item_4',
        name: 'Cetirizine 10mg Tablets',
        sku: 'CTZ10',
        hsnCode: '30049069',
        quantity: 12,
        unit: 'Strip',
        rate: 26,
        discount: 6,
        taxPercent: 5,
      ),
      InvoiceItemModel(
        id: 'item_5',
        name: 'Vitamin C Effervescent',
        sku: 'VITC',
        hsnCode: '21069099',
        quantity: 15,
        unit: 'Tube',
        rate: 54,
        discount: 18,
        taxPercent: 18,
      ),
      InvoiceItemModel(
        id: 'item_6',
        name: 'ORS Sachet Orange Flavour',
        sku: 'ORS-ORG',
        hsnCode: '30049011',
        quantity: 20,
        unit: 'Pack',
        rate: 18,
        discount: 0,
        taxPercent: 5,
      ),
    ];
  }
}
