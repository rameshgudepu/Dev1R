public with sharing class ARVaultBackupController {
    
    @AuraEnabled
    public static String startBackup (String idUser, String txARVault, String sfOrgID, String backupType, String metadataBackup, String dataBackup, String bkpLabel) {
    	return ARVaultService.startBackup(idUser, txARVault, sfOrgID, backupType, metadataBackup, dataBackup, bkpLabel);
    }
    
    @AuraEnabled
    public static List<Object> getListOfBackups (String idUser, String txARVault, String sfOrgID) {
    	return ARVaultService.getListOfBackups(idUser, txARVault, sfOrgID);
    }
	
    @AuraEnabled
    public static Map<String, Object> getBackupObject (String idUser, String txARVault, Integer backupID) {
    	return ARVaultService.getBackupObject(idUser, txARVault, backupID);
    }
    
    @AuraEnabled
    public static List<String> getBackupsLog (String idUser, String txARVault, Integer backupID) {
    	return ARVaultService.getBackupsLog(idUser, txARVault, backupID);
    }
    
    @AuraEnabled
    public static String sendEmailNotification(String sfOrgId, String objects, String mMail, String subject){
        return ARVaultService.sendEmailNotification(sfOrgId, objects, mMail, subject);
    }
    
    @AuraEnabled 
    public static boolean isEmailAttachment(String sfOrgId, String objects, String subject){
        return ARVaultService.isEmailAttachment(sfOrgId, objects, subject);
    }

}