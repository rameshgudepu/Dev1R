public with sharing class ARVaultUserController {
    
    @AuraEnabled
    public static List<Object> getAllUsers(String idUser, String txARVault){
    	return ARVaultService.getAllUsers(idUser, txARVault);
    }

    @AuraEnabled
    public static String addNewUser(String firstName, String lastName, String middleName, String country, String mobile, 
                                         String timeZone, String email, String designation, String description, String roles){
        return ARVaultService.addNewUser(firstName, lastName, middleName, country, mobile, timeZone, email, designation, description, roles);
    }
    
    @AuraEnabled
    public static Map<String, Object> getUserByUserID(String idUser, String txARVault, String userId) {
        return ARVaultService.getUserObject(idUser, txARVault, userId);
    }

    @AuraEnabled
    public static String updateExistingUser(String idUser, String txARVault, String userID, String firstName, String lastName, String middleName, String country, 
                                            String email, Integer mobile, String designation, String  timezone, String role) {
        return ARVaultService.saveEditUser(idUser, txARVault, userID, firstName, lastName, middleName, country, email, mobile, designation, timezone, role);
    }    
    
    @AuraEnabled
    public static List<Object> getAllRoles(String idUser, String txARVault){
    	return ARVaultService.getAllRoles(idUser, txARVault);
    }
    
    @AuraEnabled
    public static String addNewRole(String idUser, String txARVault, String roleName, String roleDesc, String permissions) {
        return ARVaultService.addNewRole(idUser, txARVault, roleName, roleDesc, permissions);
    }
    
    @AuraEnabled
    public static Map<String, Object> getUserRole(String idUser, String txARVault, String roleId) {
        return ARVaultService.getUserRole(idUser, txARVault, roleId);
    }
    
    @AuraEnabled
    public static String updateExistingRole(String idUser, String txARVault, String roleId, String roleName, String roleDesc, String permissions) {
        return ARVaultService.saveEditRole(idUser, txARVault, roleId, roleName, roleDesc, permissions);
    }
    
    @AuraEnabled
    public static String deleteExistingRole(String idUser, String txARVault, String roleId) {
        return ARVaultService.deleteRole(idUser, txARVault, roleId);
    }
}