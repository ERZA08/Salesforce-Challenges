public with sharing class CaseService {

    public static void closeCases (Set<Id> caseIDs, String closeReason){

        List<Case> casesList = new List<Case>();

        //Validate parameters
        if(caseIds == null || caseIDs.size() == 0)
            throw new CaseServiceException('Cases not especified.');

        //Validate parameters
        if(closeReason == null || closeReason == '')
            throw new CaseServiceException('Close reason not especified.');

        for(Case row: [SELECT Id FROM Case WHERE id IN :caseIDs]){
            row.Reason = closeReason;
            row.Status = 'Closed';

            casesList.add(row);
        }
 
        try {
           DataBase.Update(casesList, false);
        } catch (Exception ex) {
           throw new CaseServiceException('Something was wrong, try again later or contact your Admin');
        }
    
    }

    public class CaseServiceException extends Exception{}
}