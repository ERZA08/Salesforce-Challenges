public class VFTestController {
    
    public string recordId {get; set;}
    
    public VFTestController(ApexPages.StandardController  controller){
        
    }
    
    public static void sendPDf()
    {
       PageReference PDf =  Page.PruebaVF_2;//Replace attachmentPDf with the page you have rendered as PDF
        //PDf.getParameters().put('Id',apexpages.currentpage().getparameters().get('id') );
        //PDf.setRedirect(true);
        Attachment attach = new Attachment();
        Blob b ;
        b = PDf.getContentAsPDF();
        attach.Body = b;
        attach.Name = 'Confirmation of product';
        attach.IsPrivate = false;
        attach.ParentId = apexpages.currentpage().getparameters().get('id') ;
        //insert attach;
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName('Confirmation of product.PDf');
        efa.setBody(b);
		List<String> listAddress = new List<String>();
        listAddress.add('ersa181293@hotmail.com');
        Messaging.SingleEmailMessage emailTobeSent = new Messaging.SingleEmailMessage();
        emailTobeSent.setToAddresses( new String[] { 'ersa181293@hotmail.com', 'erza181293@gmail.com' });
        emailTobeSent.setSubject('Confirmation of product');
        emailTobeSent.setHtmlBody('Hi');
        emailTobeSent.setFileAttachments(new Messaging.EmailFileAttachment[] {efa}); // Sends the email
        
        Messaging.SendEmailResult [] r1 = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emailTobeSent});
        
        if (r1[0].success) {
            System.debug('The email was sent successfully.' + r1[0]);
        } else {
            System.debug('The email failed to send: ' + r1[0].errors[0].message);
        }
    }
    

}