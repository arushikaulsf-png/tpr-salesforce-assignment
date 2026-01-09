global class productWrapper {  // global class (was public)
    @AuraEnabled 
    global String product;      // global fields (was public)
    @AuraEnabled 
    global String country;
    @AuraEnabled 
    global Decimal monthlyFee;
    @AuraEnabled 
    global Decimal atmFee;
    @AuraEnabled 
    global Decimal cardReplacement;
    
    global productWrapper(Product_Fee__c fee) {  // global constructor
        this.product = fee.Product__c;
        this.country = fee.Country__c;
        this.monthlyFee = fee.Monthly_Fee__c;
        this.atmFee = fee.ATM_Fee__c;          //fee.ATM_Fee__c?.multiply(100);
        this.cardReplacement = fee.Card_Replacement__c;
    }
}