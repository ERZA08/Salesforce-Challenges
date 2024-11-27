public class MyCampingListController {
    
    @AuraEnabled
    public static void packItem (Id recordId) {
        Camping_Item__c camItem = new Camping_Item__c();
        camItem.Id = recordId;
        camItem.Packed__c = true;
       	update camItem;
    }
    
    @AuraEnabled
    public static List<Camping_Item__c> getCampings() {
       return [Select Id, Name, Quantity__c, Price__c, Packed__c From Camping_Item__c];
    }


}