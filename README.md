# N26 Salesforce Engineer Case Study Solution README FILE
This repository implements the two tasks for displaying customer product pricing on Case pages
and exposing it via REST API for external systems.

Task 1: Lightning Web Component for Case Page Pricing Display
**Objective**: Show pricing (Monthly Fee, ATM Fee, Card Replacement) on Case layout based
on Contact.Product__c and Contact.Home_Country__c

Implementation:
-
Custom Fields:
- Contact: Product__c
 (Picklist: Standard, Black, Metal), Home
_
Home_Country__c (Picklist: DE, FR,
ES, IT, UK).
-
**Product_Fee__c Object**: Stores configurable pricing (e.g., Monthly_Fee__c Currency,
ATM_Fee__c Percent, Card_Replacement__c Currency, Product__c, Country__c). Supports
future overrides.
-
Apex:`PricingInfoClass.getPricingForCase(caseId)`
matching fees, wraps in
`ProductFeeDisplay

LWC:lWCProductInfo queries Contact via Case, fetches
with formatted strings (€, %).
wires Apex data into datatable on Case recordId. 


Task 2: REST API for External UUID Lookup
Objective:
services/apexrest/n26/ProductFee/{uuid}`
returns pricing for Contact.External_UUID__c
**Implementation**:
-
**Custom Field**: Contact.External_UUID__C(Text(36), External ID, Unique).
-
Apex:ProductFeeAPI`
: @HttpGet extracts UUID from URI, calls service, wraps response.
-
`ProductFeeService.getPricingForContact(uuid)`: Queries Contact, then matching
Product_Fee__c productWrapper: Serializes fields (note: formatting suggested in assessment).
-
External Client App:ProductExternalAPI for Oauth setup for connectivity
**Error Handling**: CustomException for invalid UUID; empty list if no product/country.

Setup Instructions
1. Deploy metadata: Objects, fields, Apex classes, LWC bundle.
2. Assign permissions: Read access to Contact/Product
Fee
_
__
c; Apex execution.
3. Add LWC to Case page layout (Record Page > Related > Product Pricing).
4. Populate Product_Fee__c
 with sample data from case study tables
5. Test API: GET `/n26/ProductFee/{contact-uuid}` (use Postman with Connected App auth).
## Architecture Decisions
- OOP: Service layer separates logic; wrappers for formatting.
-Used Custom Object Product_Fee__c for storing the Product data, we could also use Custom Metadadata


