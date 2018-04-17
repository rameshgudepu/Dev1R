@isTest
public class ARVaultBackupControllerTest {

   static testMethod void test_startBackup_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String backupSuccess = ARVaultBackupController.startBackup('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ','forced', 'yes',  'no', 'TESTQA') ;
        System.assertEquals('Success', backupSuccess);
    }
       
    static testMethod void test_getListOfBackups_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> objList  = ARVaultBackupController.getListOfBackups('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', '00D1I000000kyuFUAQ');
        System.assertNotEquals(0, objList.size());        
    }
    
    static testMethod void test_getBackupObject_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String, Object> backupObj = ARVaultBackupController.getBackupObject('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', 1521);
        System.assertNotEquals(0, backupObj.size());
    }
    
    static testMethod void test_getBackupsLog_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<String> backupLog = ARVaultBackupController.getBackupsLog ('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', 1521);
        System.assertNotEquals(null, backupLog);
    }

    
    static testMethod void test_sendEmailNotification_UseCase1(){
         String sample = '[{"backupId":1719,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP05-Mar-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":224,"nbrTotApi":252,"nbrTotRecords":9,"successCount":9,"metaSuccessCount":906,"metaTotalCount":624,"metaTotDuration":62,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1520254800000},{"backupId":1687,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP27-Feb-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":224,"nbrTotApi":254,"nbrTotRecords":883,"successCount":883,"metaSuccessCount":906,"metaTotalCount":624,"metaTotDuration":56,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1519736400000},{"backupId":1226,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP04-Feb-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":215,"nbrTotApi":259,"nbrTotRecords":19,"successCount":19,"metaSuccessCount":770,"metaTotalCount":559,"metaTotDuration":50,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1517749200000}]';
         String sendEmail = ARVaultBackupController.sendEmailNotification('00D1I000000kyuFUAQ',sample,'jayashree.j@autorabit.com','Backup');
         System.assertEquals('Success', sendEmail);
    }
    
    static testMethod void test_isEmailAttachment_UseCase1(){
         String sample = '[{"backupId":1719,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP05-Mar-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":224,"nbrTotApi":252,"nbrTotRecords":9,"successCount":9,"metaSuccessCount":906,"metaTotalCount":624,"metaTotDuration":62,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1520254800000},{"backupId":1687,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP27-Feb-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":224,"nbrTotApi":254,"nbrTotRecords":883,"successCount":883,"metaSuccessCount":906,"metaTotalCount":624,"metaTotDuration":56,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1519736400000},{"backupId":1226,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP04-Feb-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":215,"nbrTotApi":259,"nbrTotRecords":19,"successCount":19,"metaSuccessCount":770,"metaTotalCount":559,"metaTotDuration":50,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1517749200000}]';
         boolean isExists = ARVaultBackupController.isEmailAttachment('00D1I000000kyuFUAQ',sample,'Backup');
         System.assertEquals(true, isExists);
    }
}