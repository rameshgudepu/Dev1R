public with sharing class ARVaultSetupController {
            
    @AuraEnabled
    public static Map<String, Object>  getOrgBackupConfig(String idUser, String txARVault, String sfOrgId){        
        return  ARVaultService.getOrgBackupConfig(idUser, txARVault, sfOrgId);
    }
    
    @AuraEnabled
    public static List<Object> getOrgsList(String idUser, String txARVault){
    	return ARVaultService.getOrgsList(idUser, txARVault);
    }

    @AuraEnabled
    public static Map<String, Object> getOrgsDetails(String idUser, String txARVault, String sfOrgId){    	
        return ARVaultService.getOrgsDetails(idUser, txARVault, sfOrgId);
    }
    
    @AuraEnabled
    public static String basicAuthCallout(String idUser, String txARVault, String orgName, String userName, String pwd, String sfSecToken, 
                                          String sfAuthType, String refreshToken, String instanceURL)
    {
        return ARVaultService.basicAuthCallout(idUser, txARVault, orgName, userName, pwd, sfSecToken, sfAuthType, 
                                               refreshToken, instanceURL);
    }
    
    @AuraEnabled
    public static String saveBackupConfig(String idUser, String txARVault, String idSforg, String flScdFrq, String dtScd, String tmScd, String dayScd, String objCriteria, 
                                          String metadataTypes, String isFullDataBackup, String isFullMetaDataBackup){                                              
		return ARVaultService.saveBackupConfig(idUser, txARVault, idSforg, flScdFrq, dtScd, tmScd, dayScd, objCriteria, metadataTypes, isFullDataBackup, isFullMetaDataBackup);
    }
    
    @AuraEnabled
    public static String testSfConnection(String idUser, String txARVault, String sfOrgID){
        return ARVaultService.testSfConnection(idUser, txARVault, sfOrgID);
    }
    
    @AuraEnabled
    public static String updateSfOrg(String idUser, String txARVault, String idSforg, String nmLable, String sfNmUser, String sfTxPwd, 
                                     String sfSecToken, String accessToken, String sfAuthType, String instanceURL)
    {
    	return ARVaultService.updateSfOrg(idUser, txARVault, idSforg, nmLable, sfNmUser, sfTxPwd, sfSecToken, 
                                          accessToken, sfAuthType, instanceURL);
    }
    
    @AuraEnabled
    public static String testNewSfConnection(String idUser, String txARVault, String userName, String password, String secToken, String authType, String instanceURL){
    	return ARVaultService.testNewSfConnection(idUser, txARVault, userName, password, secToken, authType, instanceURL);
    }
    
    @AuraEnabled
    public static Map<String, Object> getOAuthOrg(String idUser, String txARVault, String orgTitle, String userName){ 
        System.debug('idUser:'+idUser+':'+txARVault+':'+orgTitle+':'+userName);
    	return ARVaultService.fetchOAuthOrg(idUser, txARVault, orgTitle, userName);
    }

    @AuraEnabled
    public static List<Object> getMetadataTypes(String idUser, String txARVault, String sfOrgId, String metadata){ 
    	return ARVaultService.getMetadataTypes(idUser, txARVault, sfOrgId, metadata);
    }
    
    @AuraEnabled
    public static List<Object> getSfObjects(String idUser, String txARVault, String sfOrgID){
    	return ARVaultService.getSfObjects(idUser, txARVault, sfOrgID);
    }
    
    @AuraEnabled
    public static List<Object> getSfFields(String idUser, String txARVault, String sfOrgID, String sfObjName){
        return ARVaultService.getSfFields(idUser, txARVault, sfOrgID, sfObjName);
    }
}