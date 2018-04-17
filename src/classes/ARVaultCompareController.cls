public with sharing class ARVaultCompareController {
    
    @AuraEnabled
    public static List<Object> getListOfCompareBackups (String idUser, String txARVault, String sfOrgID) {        
        return ARVaultService.getListOfCompareBackups(idUser, txARVault, sfOrgID);        
    }

    @AuraEnabled
    public static List<Object> getCompareBackups(String idUser, String txARVault, Integer fbackupID, Integer sbackupID){
        return ARVaultService.getMultipleBackupObjects(idUser, txARVault, fbackupID, sbackupID);
    }
    
    @AuraEnabled
    public static List<Object> getCompareChangeView (String snapshotRec1, String snapshotRec2, String objName, List<Object> recordColumns) {
    	return ARVaultService.getCompareChangeView(snapshotRec1, snapshotRec2, objName, recordColumns);
    }    
    
    @AuraEnabled
    public static List<Object> getRecordsForCompare (String idUser, String txARVault, Integer fbackupID, Integer sbackupID, String objName) {
    	return ARVaultService.getRecordsForCompare(idUser, txARVault, fbackupID, sbackupID, objName);
    }   
    
    @AuraEnabled
    public static List<Object> fetchTypeMembers(String metadata1, String metadata2, String typeName){        
        return ARVaultService.loadTypeMembers(metadata1, metadata2, typeName);
    } 
    
    @AuraEnabled
    public static List<Object> getCompareMembers(String idUser, String txARVault, Integer fbackupID,Integer sbackupID, String memType, String memName){        
        return ARVaultService.getCompareMembers(idUser, txARVault, fbackupID, sbackupID, memType, memName);
    } 
}