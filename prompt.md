Build a complete Flutter mobile app (new app named HisaabMitra)that recreates the invoice/purchase flow described below. Use Flutter latest stable, Dart null safety, Material 3, clean architecture, reusable widgets, and production-style code. Do not give pseudo-code. Generate real runnable code with proper folder structure, navigation, state management, mock data, and polished UI.

APP GOAL
Create a pharmacy/accounting-style invoice app with this exact end-to-end flow:

1. App launch loader screen
2. A second loader screen before the landing page
3. Landing page dashboard
4. Clicking the green + button opens the Sales Transaction page
5. Clicking Purchase opens the Purchase page
6. On the Purchase page, clicking the top-right icon opens the Upload Bill page
7. After upload, show a Bill Preview page
8. Clicking Proceed starts invoice parsing
9. Show an Invoice Parsing loader screen
10. Open a Parsed Invoice editable page
11. From Parsed Invoice, tapping Place of Supply edit opens Place of Supply screen
12. Tapping Change Party opens Change Party screen
13. Tapping Change Item opens Change Item screen
14. User reviews data and saves draft or creates purchase

TECH REQUIREMENTS
- Flutter latest stable
- Dart latest stable
- Material 3
- Use go_router for navigation
- Use Riverpod or Provider for state management
- Use feature-based folder structure
- Modular widgets only
- App must compile
- Use mock local data only
- No backend required
- No pseudo-code
- No incomplete placeholders
- Include comments where useful, but avoid excessive noise

PROJECT STRUCTURE
Generate code using a clean feature-first structure like this:

lib/
  core/
    theme/
    constants/
    utils/
    widgets/
  routes/
  models/
  services/
  features/
    splash/
    preload/
    landing/
    sales_transaction/
    purchase/
    upload_bill/
    bill_preview/
    parsing/
    parsed_invoice/
    place_of_supply/
    change_party/
    change_item/
  main.dart

UI AND SCREEN DETAILS

1) SPLASH / APP LAUNCH LOADER
- First screen shown on app open
- Centered app logo/icon and app name
- Show loader animation or CircularProgressIndicator
- Professional clean look
- After short delay automatically navigate to second loader screen

2) SECOND PRE-LANDING LOADER
- Show another loader page before home screen
- Text like:
  - Preparing workspace
  - Loading dashboard
- Clean transition feel
- After short delay go to Landing page

3) LANDING PAGE
Build a polished dashboard-like home screen.
Include:
- App bar or header
- Greeting or business summary
- Quick action cards
- Purchase tile/button
- Sales tile/button
- Floating green + button
- Modern accounting/pharmacy app feel

Behavior:
- Green + button -> Sales Transaction page
- Purchase button/tile -> Purchase page

4) SALES TRANSACTION PAGE
- A sales entry screen
- Basic form fields such as:
  - Customer name
  - Invoice number
  - Date
  - Items
  - Quantity
  - Amount
- Keep it visually consistent with the app

5) PURCHASE PAGE
- Purchase entry screen with clean accounting layout
- Show fields/cards relevant to purchase creation
- Top-right icon button for Upload Bill
- Professional ERP/accounting UI feel

Behavior:
- Clicking upload icon opens Upload Bill page

6) UPLOAD BILL PAGE
- Upload invoice file/image UI
- Show upload card area
- Buttons/options like:
  - Pick from gallery/files
  - Camera
- Use mock file picker behavior if needed
- Show selected file info
- Continue/Next button enabled after mock selection

7) BILL PREVIEW PAGE
- Show preview of uploaded bill image/document
- Use mock sample invoice image or placeholder asset/container
- Show filename and preview card
- Buttons:
  - Back
  - Proceed

8) PARSING LOADER PAGE
- Triggered when Proceed is clicked
- Show animated loader
- Text such as:
  - Parsing invoice
  - Extracting line items
  - Identifying GST and totals
- After delay, open Parsed Invoice screen

9) PARSED INVOICE PAGE
This is the main complex screen.

Create a detailed editable invoice form that looks like a real purchase invoice editor.

Include:
- Supplier / Party field
- Invoice number
- Invoice date
- Place of Supply
- GSTIN / tax related area
- Bill summary section
- Item list section
- Each line item should include:
  - Item name
  - Quantity
  - Unit
  - Rate
  - Discount
  - Tax %
  - Amount
- Totals section:
  - Subtotal
  - Discount total
  - Tax total
  - Grand total
  - Payable amount

Include clear actions/buttons:
- Edit Place of Supply
- Change Party
- Change Item on each item or from action area
- Add item
- Remove item
- Save Draft
- Create Purchase

This page should feel like a proper invoice verification/edit screen after OCR parsing.

10) PLACE OF SUPPLY SCREEN
- Opened from Parsed Invoice page
- Searchable list of states/places
- Select one
- Return selected value to Parsed Invoice screen
- Clean selection UI with radio/check state

11) CHANGE PARTY SCREEN
- Searchable supplier/party list
- Show cards/list tiles with supplier name and small details
- Tapping one replaces current supplier in Parsed Invoice
- Return to previous screen with updated data

12) CHANGE ITEM SCREEN
- Searchable medicine/product/item list
- Show item cards or rows
- Tapping one replaces currently selected parsed item
- Optionally allow quick edit of quantity/rate before confirming
- Return chosen item to Parsed Invoice screen

13) FINAL REVIEW / SAVE / CREATE PURCHASE
On Parsed Invoice page:
- Save Draft should show success snackbar/dialog
- Create Purchase should show confirmation dialog and success state
- Use mock storage/state only
- No backend

DESIGN REQUIREMENTS
- Clean professional mobile design
- Pharmacy/accounting software inspired
- Rounded cards
- Soft shadows
- Green as primary color
- White/light grey background
- Proper spacing and alignment
- Good typography hierarchy
- Mobile responsive
- Visually polished, not plain default widgets

STATE MANAGEMENT REQUIREMENTS
Use Riverpod or Provider to manage:
- Current uploaded bill
- Parsed invoice data
- Selected place of supply
- Selected supplier
- Selected item replacements
- Draft/save state

MODEL REQUIREMENTS
Create proper Dart models, for example:
- PartyModel
- InvoiceModel
- InvoiceItemModel
- PlaceOfSupplyModel
- UploadedBillModel

Also provide mock repositories/services for:
- Fetch mock suppliers
- Fetch mock items
- Fetch mock places of supply
- Simulate invoice parsing
- Simulate save draft / create purchase

ROUTING REQUIREMENTS
Use go_router and define all routes cleanly.
Navigation should be fully wired across the whole flow.

THEME REQUIREMENTS
Create centralized app theme:
- Color scheme with green primary
- Input decoration theme
- Elevated button theme
- Card theme
- App bar theme

REUSABLE WIDGETS
Create reusable widgets such as:
- App scaffold wrapper
- Loader view
- Primary button
- Secondary button
- Search text field
- Summary card
- Invoice item row/card
- Section header
- Empty state widget

MOCK DATA REQUIREMENTS
Use realistic mock data for:
- Supplier names
- Medicine/item names
- Invoice numbers
- Tax percentages
- Item rows
- Totals
- States / places of supply

USER EXPERIENCE REQUIREMENTS
- Smooth navigation
- Good spacing
- Search should filter lists locally
- Form fields editable
- Values update on return from selection screens
- Totals recalculate when items change
- Show validation where needed
- Save/Create actions should feel realistic

DELIVERABLE FORMAT
Generate the full project in one go, including:
1. pubspec.yaml dependencies
2. full folder structure
3. all Dart files with code
4. theme setup
5. router setup
6. models
7. mock services/repositories
8. all screen implementations
9. reusable widgets
10. instructions to run

IMPORTANT CODING RULES
- No pseudo-code
- No “implement this later”
- No omitted files
- No one-file giant app
- No backend code
- No Firebase
- No broken imports
- Keep files logically separated
- Make the app runnable after flutter pub get

VISUAL FLOW TO MATCH
The app flow must clearly reflect:
loader -> second loader -> landing page -> purchase page -> upload bill -> bill preview -> proceed -> parsing loader -> parsed invoice -> edit place of supply -> change party -> change item -> final save/create purchase

OUTPUT EXPECTATION
Start by showing the folder structure, then provide pubspec.yaml, then all source files one by one with correct filenames and full contents.