public with sharing class ARVaultRestoreController {

    @AuraEnabled
    public static List<Object> getCompletedBackups (String idUser, String txARVault, String sfOrgID) {
    	return ARVaultService.getCompletedBackups(idUser, txARVault, sfOrgID);
    }
    
    @AuraEnabled
    public static List<Object> getBackupsForDates (String backupObjects, String sFromDate, String sToDate) {
    	return ARVaultService.getBackupsForDates(backupObjects, sFromDate, sToDate);
    }
    
    @AuraEnabled
    public static List<Object> getRecordsFromBackup (String idUser, String txARVault, Integer backupID, String objName) { 
        System.debug('backupID:'+backupID+':objName:'+objName);
    	return ARVaultService.getRecordsFromBackup(idUser, txARVault, backupID, objName);        
    }
    
    @AuraEnabled
    public static List<Object> getChangeViewRecords (String idUser, String txARVault, Integer backupID, String objName, List<Object> recordColumns) {
    	return ARVaultService.getChangeViewRecords(idUser, txARVault, backupID, objName, recordColumns);
    }
    
    @AuraEnabled
    public static Map<String, Object> getBackupObject (String idUser, String txARVault, Integer backupID)  {
    	return ARVaultService.getBackupObject(idUser, txARVault, backupID);
    }
    
    @AuraEnabled
    public static String sendEmailNotification(String sfOrgId, String objects, String mMail, String subject){
        return ARVaultService.sendEmailNotification(sfOrgId, objects, mMail, subject);
    }

    @AuraEnabled 
    public static boolean isEmailAttachment(String sfOrgId, String objects, String subject){
        return ARVaultService.isEmailAttachment(sfOrgId, objects, subject);
    }
    
    @AuraEnabled
    public static List<Object> getListOfRestores (String idUser, String txARVault, String sfOrgId) {
        return ARVaultService.getListOfRestores(idUser, txARVault,sfOrgId);
    }
    
    @AuraEnabled
    public static Map<String, Object> getRestoreObject (String idUser, String txARVault, Integer restoreID) {
        return ARVaultService.getRestoreObject(idUser, txARVault, restoreID);
    }
    
    @AuraEnabled
    public static String startRestore (String idUser, String txARVault, Integer backupId, String srcSfOrgId, String destSfOrgId, 
                                       String metadataTypes, String metadata, String dataObjects, String data) 
    {
        return ARVaultService.startRestore(idUser, txARVault, backupId, srcSfOrgId, destSfOrgId, metadataTypes, metadata, dataObjects, data);
    }
    
     @AuraEnabled
    public static String startBackupRestore (String idUser, String txARVault, Integer backupId, String srcSfOrgId, String destSfOrgId, 
                                       String metadataTypes, String dataObjects) 
    {
        return ARVaultService.startBackupRestore(idUser, txARVault, backupId, srcSfOrgId, destSfOrgId, metadataTypes, dataObjects);
    }


    
}