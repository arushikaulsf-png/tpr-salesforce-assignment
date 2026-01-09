public with sharing class PricingInfoClass {
    
    @AuraEnabled(cacheable=true)
    public static List<ProductFeeDisplay> getPricingForCase(Id caseId) {
        Case c = [
            SELECT ContactId, Contact.Product__c, Contact.Home_Country__c
            FROM Case WHERE Id = :caseId LIMIT 1
        ];
        
        if (c.ContactId == null || c.Contact.Product__c == null || c.Contact.Home_Country__c == null) {
            return new List<ProductFeeDisplay>();
        }
        
        List<Product_Fee__c> fees = [
            SELECT Product__c, Country__c, Monthly_Fee__c, ATM_Fee__c, Card_Replacement__c
            FROM Product_Fee__c 
            WHERE Product__c = :c.Contact.Product__c 
              AND Country__c = :c.Contact.Home_Country__c
        ];
        System.debug('fees is++'+fees);
     
        List<ProductFeeDisplay> displayList = new List<ProductFeeDisplay>();
        for (Product_Fee__c fee : fees) {
            displayList.add(new ProductFeeDisplay(fee));
        }
        System.debug('Display List is++'+displayList);
        return displayList;
    }
    
   
    public class ProductFeeDisplay {
        @AuraEnabled public String product;
        @AuraEnabled public String country;
        @AuraEnabled public String monthlyFee;     
        @AuraEnabled public String atmFee;          
        @AuraEnabled public String cardReplacement; 
        
        public ProductFeeDisplay(Product_Fee__c fee) {
            this.product = fee.Product__c;
            this.country = fee.Country__c;
            
            
            this.monthlyFee = formatCurrency(fee.Monthly_Fee__c);
            this.cardReplacement = formatCurrency(fee.Card_Replacement__c);
            
            
            this.atmFee = formatPercent(fee.ATM_Fee__c);
        }
        
        private String formatCurrency(Decimal val) {
            return val != null ? val.setScale(2).toPlainString() + ' €' : '0.00 €';
        }
        
        private String formatPercent(Decimal val) {
            return val != null ? (val * 100).setScale(2).toPlainString() + '%' : '0.00%';
        }
    }
}