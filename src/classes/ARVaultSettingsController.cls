public with sharing class ARVaultSettingsController {
        
    @AuraEnabled
    public static Map<String, Object> Login(String userId,String password) {
        return ARVaultService.Login(userId, password);
    }
    
    @AuraEnabled
    public static String RegisterNewUser(String firstName, String lastName, String middleName, String email, String company, 
                                         String designation, String country, String mobile)       
    {        
        return ARVaultService.RegisterNewUser(firstName, lastName, middleName, email, company, designation, country, mobile);                                                        
	}
    
    @AuraEnabled
    public static String forgotPassword (String emailId){
        return ARVaultService.forgotPassword(emailId);
    }

    @AuraEnabled
    public static String changePassword (String existingPWD, String txPWD, String idUser, String txARVault){
        return ARVaultService.changePassword(existingPWD, txPWD, idUser, txARVault);
    }
    
    @AuraEnabled
    public static String addAWSEnvi (String idUser, String txARVault, String nmLable, String defaultSettings, 
                                     String s3IdAcckey, String s3IdSeckey,
                                     String s3Region, String s3EncryptionEnabled)
    {
        return ARVaultService.addAWSEnvi(idUser, txARVault, nmLable, defaultSettings, s3IdAcckey, s3IdSeckey, s3Region, s3EncryptionEnabled);
    }
    
    @AuraEnabled
    public static Map<String, Object> getSettings (String idUser, String txARVault){
        return ARVaultService.getSettings(idUser, txARVault);
    }
    
    @AuraEnabled
    public static String addServiceURL(){
        List<CustomSetting__c> pos = [SELECT EndPoint_URL__c FROM CustomSetting__c where name= 'WEBSERVICE_URL'];
        if(pos.size() == 0){
            CustomSetting__c objdlt = new CustomSetting__c();
            if(Schema.sObjectType.CustomSetting__c.fields.name.isCreateable()){
                objdlt.name = 'WEBSERVICE_URL';    
            }
            if(Schema.sObjectType.CustomSetting__c.fields.EndPoint_URL__c.isCreateable()){
                objdlt.EndPoint_URL__c = 'http://34.216.101.81:8080/ARVault';    
            }            
            insert objdlt;  
            return 'ADDED';
        }else{
            return 'NOTADDED';
        }
        
    }
}