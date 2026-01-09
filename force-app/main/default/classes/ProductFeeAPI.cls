@RestResource(urlMapping='/n26/ProductFee/*')
global class ProductFeeAPI {

    @HttpGet
    global static List<productWrapper> getProductFee() {
        RestRequest req = RestContext.request;
        String uuid = req.requestURI.substringAfterLast('/'); 
        System.debug('API HIT');
        System.debug('URI: ' + req.requestURI);
        System.debug('UUID: ' + uuid);
       
        try {
            List<Product_Fee__c> fees = ProductFeeService.getPricingForContact(uuid);
            List<productWrapper> response = new List<productWrapper>();
            
            for (Product_Fee__c fee : fees) {
                response.add(new productWrapper(fee));
            }
            
            return response;
        } catch (QueryException e) {
            throw new CustomException('Product not found for UUID: ' + uuid);
        }
    }
    
    global class CustomException extends Exception {}

}