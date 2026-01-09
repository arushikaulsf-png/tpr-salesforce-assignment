public with sharing class PricingInfoClass {

    @AuraEnabled(cacheable=true)
    public static List<Product_Fee__c> getPricingForCase(Id caseId) {

        Case c = [
            SELECT ContactId,
                   Contact.Product__c,
                   Contact.Home_Country__c
            FROM Case
            WHERE Id = :caseId
            LIMIT 1
        ];

        if (c.ContactId == null ||
            c.Contact.Product__c == null ||
            c.Contact.Home_Country__c == null) {
            return new List<Product_Fee__c>();
        }

        List<Product_Fee__c> fees = [
            SELECT Id,
                   Name,
                   Product__c,
                   Country__c,
                   Monthly_Fee__c,
                   ATM_Fee__c,
                   Card_Replacement__c
            FROM Product_Fee__c
            WHERE Product__c = :c.Contact.Product__c
              AND Country__c = :c.Contact.Home_Country__c
            ORDER BY Product__c
        ];

        return fees;
    }
}
