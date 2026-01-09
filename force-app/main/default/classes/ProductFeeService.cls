public class ProductFeeService {

public static List<Product_Fee__c> getPricingForContact(String externalUuid) {
        Contact con = [SELECT Product__c, Home_Country__c 
                       FROM Contact 
                       WHERE External_UUID__c = :externalUuid 
                       LIMIT 1];
        
        if (con.Product__c == null || con.Home_Country__c == null) {
            return new List<Product_Fee__c>();
        }
        
        return [SELECT Product__c, Country__c, Monthly_Fee__c, ATM_Fee__c, Card_Replacement__c
                FROM Product_Fee__c 
                WHERE Product__c = :con.Product__c AND Country__c = :con.Home_Country__c];
    }

}