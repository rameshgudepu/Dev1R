@isTest
public class ARVaultRestoreControllerTest       {
    
    static testMethod void test_getCompletedBackups_UseCase1(){
        
        
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> backupList = ARVaultRestoreController.getCompletedBackups('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ');
        System.assertNotEquals(null, backupList);
    }
    
    static testMethod void test_getBackupsForDates_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String backupObjects = '[ { "backupId": 1509, "idCfgBakup": "043a31833efe4770be58d4749513d90a", "bkpLabel": "ARV_Backup_14-Feb-18 8:07 PM", "liveStatus": "Transferring retrieved records to backup environment", "flBakupTyp": "FORCED", "idUser": "194cfb4c5aa442519fc204228e5da457", "strTotDuration": 0,"nbrTotApi": null, "nbrTotRecords": 10,"successCount": 10,"metaSuccessCount": 2,"metaTotalCount": 2,"metaTotDuration": 10,"objProcStatus": "COMPLETED","isFullDataBackup": "no","isFullMetaBackup": "no","metaResultCriteria": null,"resultCriteria": null,"mailId": null, "tmStamp": 1518619077000 }, {  "backupId": 1510, "idCfgBakup": "043a31833efe4770be58d4749513d90a", "bkpLabel": "ARV_Backup_14-Feb-18 8:07 PM","liveStatus": "Transferring retrieved records to backup environment","flBakupTyp": "FORCED","idUser": "194cfb4c5aa442519fc204228e5da457","strTotDuration": 0,"nbrTotApi": null,"nbrTotRecords": null,     "successCount": null,"metaSuccessCount": null,"metaTotalCount": null,"metaTotDuration": null, "objProcStatus": "FAILED","isFullDataBackup": "no",   "isFullMetaBackup": "yes","metaResultCriteria": null,"resultCriteria": null, "mailId": null,"tmStamp": 1518619119000 }]';
        List<Object> backupList = ARVaultRestoreController.getBackupsForDates(backupObjects,'2018-01-01','2018-02-28');        
        System.assertNotEquals(null, backupList);
    }
    
    static testMethod void test_getRecordsFromBackup_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> recordList = ARVaultRestoreController.getRecordsFromBackup('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2',1527,'Account');
        System.assertNotEquals(null, recordList);
    }
    
    static testMethod void test_getChangeViewRecords_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String columns='["Id","Name","LastModifiedDate","AccountNumber","Industry"]';
        List<Object> recordColumns =(List<Object>) JSON.deserializeUntyped(columns);             
        List<Object> changeColList = ARVaultRestoreController.getChangeViewRecords('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2',1527,'Account', recordColumns);
        System.assertNotEquals(null, changeColList);
    }
    static testMethod void test_getBackupObject_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String, Object> backupObj = ARVaultRestoreController.getBackupObject('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', 1521);
        System.assertNotEquals(0, backupObj.size());
    }
    
    static testMethod void test_sendEmailNotification_UseCase1(){
        String sample = '[{"backupId":1719,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP05-Mar-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":224,"nbrTotApi":252,"nbrTotRecords":9,"successCount":9,"metaSuccessCount":906,"metaTotalCount":624,"metaTotDuration":62,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1520254800000},{"backupId":1687,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP27-Feb-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":224,"nbrTotApi":254,"nbrTotRecords":883,"successCount":883,"metaSuccessCount":906,"metaTotalCount":624,"metaTotDuration":56,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1519736400000},{"backupId":1226,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP04-Feb-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":215,"nbrTotApi":259,"nbrTotRecords":19,"successCount":19,"metaSuccessCount":770,"metaTotalCount":559,"metaTotDuration":50,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1517749200000}]';
        String sendEmail = ARVaultRestoreController.sendEmailNotification('00D1I000000kyuFUAQ',sample,'jayashree.j@autorabit.com','Restore');
        System.assertEquals('Success', sendEmail);
    }
    
    static testMethod void test_isEmailAttachment_UseCase1(){
        String sample = '[{"backupId":1719,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP05-Mar-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":224,"nbrTotApi":252,"nbrTotRecords":9,"successCount":9,"metaSuccessCount":906,"metaTotalCount":624,"metaTotDuration":62,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1520254800000},{"backupId":1687,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP27-Feb-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":224,"nbrTotApi":254,"nbrTotRecords":883,"successCount":883,"metaSuccessCount":906,"metaTotalCount":624,"metaTotDuration":56,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1519736400000},{"backupId":1226,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP04-Feb-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":215,"nbrTotApi":259,"nbrTotRecords":19,"successCount":19,"metaSuccessCount":770,"metaTotalCount":559,"metaTotDuration":50,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1517749200000}]';
        boolean isExists = ARVaultRestoreController.isEmailAttachment('00D1I000000kyuFUAQ',sample,'Restore');
        System.assertEquals(true, isExists);
    }
   
    static testMethod void test_getListOfRestores_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String,Object> restoreData = ARVaultRestoreController.getListOfRestores('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ');
        System.assertNotEquals(0, restoreData.size());
    }
    
    static testMethod void test_getRestoreObject_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String, Object> restoreObj = ARVaultRestoreController.getRestoreObject('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2',10);
        System.assertNotEquals(null, restoreObj);
    }
    
    static testMethod void test_startRestore_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String response = ARVaultRestoreController.startRestore('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2',1521, '00D1I000000kyuFUAQ', '00D1I000000kyuFUAQ',
                                                                NULL, NULL, NULL, NULL);
        System.assertNotEquals('', response);
    }
}
