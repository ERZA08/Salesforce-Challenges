public class CampingListController {
    
      @AuraEnabled
        public static List<Camping_Item__c> getItems () {
            
            // Check to make sure all fields are accessible to this user
            String[] fieldsToCheck = new String[] {
                'Id', 'Name', 'Quantity__c', 'Price__c', 
                'Packed__c', 'CreatedDate'
            };
            
            Map<String,Schema.SObjectField> fieldDescribeTokens = 
                Schema.SObjectType.Camping_Item__c.fields.getMap();
            
            for(String field : fieldsToCheck) {
                if( ! fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                    throw new System.NoAccessException();
                }
            }
            
            // OK, they're cool, let 'em through
            return [SELECT Id, Name, Quantity__c, Price__c, 
                           Packed__c, CreatedDate 
                    FROM Camping_Item__c];
        }
    
        @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c item) {
        // Perform isUpdatable() checking first, then
        upsert item;
        return item;
    }

}