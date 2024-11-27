public class ToyotaDemoController {
    
     @AuraEnabled
        public static Auto__c getItem (String param) {
            
            // Check to make sure all fields are accessible to this user
            String[] fieldsToCheck = new String[] {
                'Name', 'Vehiculo__c', 'Placas__c', 
                'Modelo__c', 'KM__c'
            };
            
            Map<String,Schema.SObjectField> fieldDescribeTokens = 
                Schema.SObjectType.Auto__c.fields.getMap();
            
            for(String field : fieldsToCheck) {
                if( ! fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                    throw new System.NoAccessException();
                }
            }
            System.debug('Param' + param);
            // OK, they're cool, let 'em through
            return [SELECT Name, Vehiculo__c, Placas__c, Modelo__c, KM__c 
                    FROM Auto__c WHERE Placas__c =:param LIMIT 1];
        }

}