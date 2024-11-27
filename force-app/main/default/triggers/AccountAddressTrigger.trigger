trigger AccountAddressTrigger on Account (before insert) {

     
    for (Account a : Trigger.New) {
                    if(a.BillingPostalCode != Null 
                                && a.Match_Billing_Address__c == True ){
                       a.ShippingPostalCode = a.BillingPostalCode;
                    }
                }

}