public class NewCaseListController {
    
    public List<Case> getNewCases(){
        
        List<Case> result = [Select Id, CaseNumber From Case Where Status = 'New'];
        
        return result;
    }

}