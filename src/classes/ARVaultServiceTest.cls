@isTest
public class ARVaultServiceTest {
    
    static testMethod void test_getOrgBackupConfig_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String, Object> backupConfig = ARVaultService.getOrgBackupConfig('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ');
        System.assertNotEquals(0, backupConfig.size());
    }
    
    static testMethod void test_saveBackupConfig_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String objCriteriaString = '[{ "0": { "name": "ActionLinkGroupTemplate", "label": "Action Link Group Template", "isExisted": true }, "1": { "name": "ApexClass", "label": "Apex Class", "isExisted": true },'+
                     '"2": { "name": "ApexComponent", "label": "Visualforce Component", "isExisted": true },"3": { "name": "ApexPage", "label": "Visualforce Page", "isExisted": true }, '+
                     '"4": { "name": "ApexTestSuite", "label": "Apex Test Suite", "isExisted": true }, "5": { "name": "ApexTrigger", "label": "Apex Trigger", "isExisted": true },'+
                     '"6": { "name": "AuraDefinition", "label": "Lightning Component Definition", "isExisted": true },"7": { "name": "AuraDefinitionBundle", "label": "Lightning Component Bundle", "isExisted": true} }]';
                    
        String responseString = ARVaultService.saveBackupConfig('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ', 'D','', '02:00', '', objCriteriaString,
                    '["ActionLinkGroupTemplate","AnalyticSnapshot","ApexClass","ApexComponent","ApexPage","ApexTestSuite","ApexTrigger","AuraDefinition","AuraDefinitionBundle"]',
                    'no','yes');
        System.assertEquals('true', responseString);
    }
    
    static testMethod void test_getOrgsList_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> orgList = ARVaultService.getOrgsList('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2');
        System.assertNotEquals(0, orgList.size());
    }
    
    static testMethod void test_getOrgsDetails_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String, Object> orgConfig = ARVaultService.getOrgsDetails('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', '00D1I000000kyuFUAQ');
        System.assertNotEquals(0, orgConfig.size());
    }   
    
    static testMethod void test_basicAuthCallout_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String addSfOrgEnv = ARVaultService.basicAuthCallout('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', 'ARVaultDemoQAFeb11', 'ashok.qa3@autorabit.com', 'Jan@2018', 'oAsvcABgrcT3SiLFJWIxrgP0w','standard', '','https://login.salesforce.com');
        System.assertEquals('true', addSfOrgEnv);
    }
    
    static testMethod void test_testNewSfConnection_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String testSfOrgEnv = ARVaultService.testNewSfConnection('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', 'arvaultprod@autorabit.com', '', '', 'oauth', 'https://arvault-prod-dev-ed.my.salesforce.com');
        System.assertEquals('Success', testSfOrgEnv);
    }
    
    static testMethod void test_testSfConnection_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String testSfOrgEnv = ARVaultService.testSfConnection('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ');
        System.assertEquals('Success', testSfOrgEnv);
    }
    
    static testMethod void test_updateSfOrg_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String updateSfOrgEnv = ARVaultService.updateSfOrg('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ','Prod org', 'arvaultprod@autorabit.com', '','','','oauth','https://arvault-prod-dev-ed.my.salesforce.com');
        System.assertEquals('true', updateSfOrgEnv);
    }
    
    static testMethod void test_getSfObjects_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> objList = ARVaultService.getSfObjects('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ');
        System.assertNotEquals(0, objList.size());
    }
    static testMethod void test_getSfFields_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> objList  = ARVaultService.getSfFields('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ','Account');
        System.assertNotEquals(0, objList.size());
    }
    
    static testMethod void test_getListOfBackups_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> objList  = ARVaultService.getListOfBackups('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ');
        System.assertNotEquals(0, objList.size());        
    }
    
    static testMethod void test_getBackupObject_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String, Object> backupObj = ARVaultService.getBackupObject('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', 1521);
        System.assertNotEquals(0, backupObj.size());
    }
    
    static testMethod void test_getBackupsLog_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<String> backupLog = ARVaultService.getBackupsLog ('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', 1521);
        System.assertNotEquals(null, backupLog);
    }
        
    static testMethod void test_getBackupsForDates_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String backupObjects = '[ { "backupId": 1509, "idCfgBakup": "043a31833efe4770be58d4749513d90a", "bkpLabel": "ARV_Backup_14-Feb-18 8:07 PM", "liveStatus": "Transferring retrieved records to backup environment", "flBakupTyp": "FORCED", "idUser": "194cfb4c5aa442519fc204228e5da457", "strTotDuration": 0,"nbrTotApi": null, "nbrTotRecords": 10,"successCount": 10,"metaSuccessCount": 2,"metaTotalCount": 2,"metaTotDuration": 10,"objProcStatus": "COMPLETED","isFullDataBackup": "no","isFullMetaBackup": "no","metaResultCriteria": null,"resultCriteria": null,"mailId": null, "tmStamp": 1518619077000 }, {  "backupId": 1510, "idCfgBakup": "043a31833efe4770be58d4749513d90a", "bkpLabel": "ARV_Backup_14-Feb-18 8:07 PM","liveStatus": "Transferring retrieved records to backup environment","flBakupTyp": "FORCED","idUser": "194cfb4c5aa442519fc204228e5da457","strTotDuration": 0,"nbrTotApi": null,"nbrTotRecords": null,     "successCount": null,"metaSuccessCount": null,"metaTotalCount": null,"metaTotDuration": null, "objProcStatus": "FAILED","isFullDataBackup": "no",   "isFullMetaBackup": "yes","metaResultCriteria": null,"resultCriteria": null, "mailId": null,"tmStamp": 1518619119000 }]';
        List<Object> backupList = ARVaultService.getBackupsForDates(backupObjects,'2018-01-01','2018-02-28');        
        System.assertNotEquals(null, backupList);
    }
    
    static testMethod void test_getCompletedBackups_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> backupList = ARVaultService.getCompletedBackups('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ');
        System.assertNotEquals(null, backupList);
    }
    
    static testMethod void test_getRecordsFromBackup_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> recordList = ARVaultService.getRecordsFromBackup('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', 1527,'Account');
        System.assertNotEquals(null, recordList);
    }
    
    static testMethod void test_getChangeViewRecords_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String columns='["Id","Name","LastModifiedDate","AccountNumber","Industry"]';
        List<Object> recordColumns =(List<Object>) JSON.deserializeUntyped(columns);             
        List<Object> changeColList = ARVaultService.getChangeViewRecords('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2',1527,'Account', recordColumns);
        System.assertNotEquals(null, changeColList);
    }

    static testMethod void test_startBackup_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String backupSuccess = ARVaultService.startBackup('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ', 'forced', 'yes',  'no', 'TESTQA') ;
        System.assertEquals('Success', backupSuccess);
    }
   
    static testMethod void test_RegisterNewUser_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String newUserReg = ARVaultSettingsController.RegisterNewUser('Jayashree', 'Jampana', 'S', 'jayashree.j@autorabit.com', 'AutoRabit', 'SWE', 'US', '');
        if(newUserReg.containsIgnoreCase('activation')){
            String successMessage ='Thanks for Registering with ARVault. you will receive activation mail to your registered mailId.(Note: please check in spam folder also)';
            System.assertEquals(successMessage, newUserReg);                
        }else{
        	System.assertEquals('', newUserReg);
        }                
    }
    
    static testMethod void test_Login_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String, Object> responseObj = ARVaultService.Login('leelapavan.a@autorabit.com','Leela@345');
        System.assertNotEquals(null, responseObj);
    }
    
    static testMethod void test_getListOfCompareBackups_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> responseObj = ARVaultService.getListOfCompareBackups('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ');
        System.assertNotEquals(null, responseObj);
    }
    
    static testMethod void test_getMultipleBackupObjects_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> selBackups = ARVaultService.getMultipleBackupObjects('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', 1527, 1588);
        System.assertNotEquals(0, selBackups.size());
    }
    
    static testMethod void test_getCompareChangeView_UseCase1(){
        String s1='[[{"diff":"false","name":"City","value":"Boardman"},{"diff":"false","name":"Country","value":"United States"}]]';
        String column='["City","Country"]';
        List<Object> columns =(List<Object>) JSON.deserializeUntyped(column);
        List<Object> changeColumns = ARVaultService.getCompareChangeView(s1,s1,'LoginGeo',columns);             
        System.assertNotEquals(0, changeColumns.size());   
    }
    
    static testMethod void test_getRecordsForCompare_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> records = ARVaultService.getRecordsForCompare('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', 1527,1588,'Account');
        System.assertNotEquals(0, records.size());   
    }
    
    static testMethod void test_getMetadataTypes_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String selTypes='["ApexClass","ApexPage"]';
        List<Object> metadataTypes = ARVaultService.getMetadataTypes('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', '00D1I000000kyuFUAQ',selTypes);
        System.assertNotEquals(0, metadataTypes.size());
    }
    
    static testMethod void test_fetchOAuthOrg_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String, Object> oauthOrg = ARVaultService.fetchOAuthOrg('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','Dev4', 'arvaultdev2017@autorabit.com');
        System.assertNotEquals(null, oauthOrg);
    }
    
    static testMethod void test_loadTypeMembers_UseCase1(){
        String metadata1 = '[{"successcount":9,"members":["Account","Asset","Campaign","Case","Contact","Lead","Opportunity","Order","User"],"type":"SharingRules","totmembercount":9},{"successcount":0,"members":[],"type":"Scontrol","totmembercount":0},{"successcount":1,"members":["CustomLabels"],"type":"CustomLabels","totmembercount":1},{"successcount":0,"members":[],"type":"Settings","totmembercount":26},{"successcount":15,"members":["ARVault_UtilityBar","Backup","Compare","Compare1","Configuration","LightningSalesConsole_UtilityBar","LightningService_UtilityBar","PracticeApp","PracticeApp_UtilityBar","Restore","Restore1","Settings","Setup","Testing","Trailblazer_UtilityBar"],"type":"FlexiPage","totmembercount":15},{"successcount":64,"members":["ARVa__c","Account","AccountCleanInfo","AccountContactRole","Activity","Asset","AssetRelationship","AssistantProgress","Campaign","CampaignMember","Case","CaseContactRole","CaseMilestone","CollaborationGroup","CollaborationGroupMember","Contact","ContactCleanInfo","ContentVersion","Contract","ContractContactRole","ContractLineItem","DandBCompany","DuplicateRecordItem","DuplicateRecordSet","EmailMessage","Entitlement","EntitlementContact","Event","ExchangeUserMapping","FeedItem","ForecastingCategoryMapping","Idea","Lead","LeadCleanInfo","Macro","MacroAction","MacroInstruction","Opportunity","OpportunityCompetitor","OpportunityContactRole","OpportunityLineItem","Order","OrderItem","OrgDeleteRequest","PartnerRole","Pricebook2","PricebookEntry","Product2","QuickText","RestoreObject__c","Scorecard","ScorecardAssociation","ScorecardMetric","ServiceContract","Site","SocialPersona","Solution","StreamingChannel","Task","Topic","TopicAssignment","User","UserProvisioningRequest","Waypoint__c"],"type":"CustomObject","totmembercount":64},{"successcount":1,"members":["Internal Zone"],"type":"Community","totmembercount":1},{"successcount":0,"members":[],"type":"CspTrustedSite","totmembercount":0}]';
        String metadata2 = '[{"successcount":9,"members":["Account","Asset","Campaign","Case","Contact","Lead","Opportunity","Order","User"],"type":"SharingRules","totmembercount":9},{"successcount":0,"members":[],"type":"Scontrol","totmembercount":0},{"successcount":1,"members":["CustomLabels"],"type":"CustomLabels","totmembercount":1},{"successcount":0,"members":[],"type":"Settings","totmembercount":26},{"successcount":17,"members":["ARVault_Home_UtilityBar","ARVault_UtilityBar","Backup","Compare","Compare1","Configuration","Home","LightningSalesConsole_UtilityBar","LightningService_UtilityBar","PracticeApp","PracticeApp_UtilityBar","Restore","Restore1","Settings","Setup","Testing","Trailblazer_UtilityBar"],"type":"FlexiPage","totmembercount":17},{"successcount":65,"members":["ARVa__c","Account","AccountCleanInfo","AccountContactRole","Activity","Asset","AssetRelationship","AssistantProgress","Campaign","CampaignMember","Case","CaseContactRole","CaseMilestone","CollaborationGroup","CollaborationGroupMember","Contact","ContactCleanInfo","ContentVersion","Contract","ContractContactRole","ContractLineItem","CustomSetting__c","DandBCompany","DuplicateRecordItem","DuplicateRecordSet","EmailMessage","Entitlement","EntitlementContact","Event","ExchangeUserMapping","FeedItem","ForecastingCategoryMapping","Idea","Lead","LeadCleanInfo","Macro","MacroAction","MacroInstruction","Opportunity","OpportunityCompetitor","OpportunityContactRole","OpportunityLineItem","Order","OrderItem","OrgDeleteRequest","PartnerRole","Pricebook2","PricebookEntry","Product2","QuickText","RestoreObject__c","Scorecard","ScorecardAssociation","ScorecardMetric","ServiceContract","Site","SocialPersona","Solution","StreamingChannel","Task","Topic","TopicAssignment","User","UserProvisioningRequest","Waypoint__c"],"type":"CustomObject","totmembercount":65}]';
        List<Object> members = ARVaultService.loadTypeMembers(metadata1, metadata2, 'CustomObject');
        System.assertNotEquals(null, members);
    }
    
    static testMethod void test_forgotPassword_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String pwd = ARVaultService.forgotPassword('jayashree.j@autorabit.com');
        System.assertEquals('Please click the link send to your mentioned Email to regenerate password.', pwd);
    }
    
    static testMethod void test_getSettings_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String, Object> settings = ARVaultService.getSettings('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2');
        System.assertNotEquals(null, settings);
    }
    
    static testMethod void test_changePassword_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String pwd = ARVaultService.changePassword('sdfsdf','Leela@345', '0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2');
        System.assertEquals('', pwd);
    }
    
    
    static testMethod void test_addAWSEnvi_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());       
        String addAWSReponse = ARVaultService.addAWSEnvi('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','', 'Y','', '','', '');
        //{"defaultSettings":"Y","nmLable":"", "s3IdAcckey": "", "s3IdSeckey":"", "idUser": "", "s3Region": "", "s3EncryptionEnabled": ""}
       System.assertEquals('AWS client is registerd successfully', addAWSReponse);
    }
    
    static testMethod void test_getCompareMembers_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> diffFiles = ARVaultService.getCompareMembers('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', 1527, 1689, 'CustomObject', 'Account');
        System.assertNotEquals(0, diffFiles.size()); 
    }
    
    static testMethod void test_sendEmailNotification_UseCase1(){
         String sample = '[{"backupId":1719,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP05-Mar-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":224,"nbrTotApi":252,"nbrTotRecords":9,"successCount":9,"metaSuccessCount":906,"metaTotalCount":624,"metaTotDuration":62,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1520254800000},{"backupId":1687,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP27-Feb-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":224,"nbrTotApi":254,"nbrTotRecords":883,"successCount":883,"metaSuccessCount":906,"metaTotalCount":624,"metaTotDuration":56,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1519736400000},{"backupId":1226,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP04-Feb-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":215,"nbrTotApi":259,"nbrTotRecords":19,"successCount":19,"metaSuccessCount":770,"metaTotalCount":559,"metaTotDuration":50,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1517749200000}]';
         String sendEmail = ARVaultService.sendEmailNotification('00D1I000000kyuFUAQ',sample,'jayashree.j@autorabit.com','Backup');
         System.assertEquals('Success', sendEmail);
    }
    
    static testMethod void test_isEmailAttachment_UseCase1(){
         String sample = '[{"backupId":1719,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP05-Mar-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":224,"nbrTotApi":252,"nbrTotRecords":9,"successCount":9,"metaSuccessCount":906,"metaTotalCount":624,"metaTotDuration":62,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1520254800000},{"backupId":1687,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP27-Feb-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":224,"nbrTotApi":254,"nbrTotRecords":883,"successCount":883,"metaSuccessCount":906,"metaTotalCount":624,"metaTotDuration":56,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1519736400000},{"backupId":1226,"idCfgBakup":"7a6f008215a14fa488f6be78f2c2b323","bkpLabel":"SCHEDULEDBACKUP04-Feb-2018 13-00-00","liveStatus":"Transferring retrieved records to backup environment","flBakupTyp":"SCHEDULED","idUser":"f939bec89dc549d9bb2a5ef164ac0eb5","strTotDuration":215,"nbrTotApi":259,"nbrTotRecords":19,"successCount":19,"metaSuccessCount":770,"metaTotalCount":559,"metaTotDuration":50,"objProcStatus":"COMPLETED","isFullDataBackup":"no","isFullMetaBackup":"yes","tmStamp":1517749200000}]';
         boolean isExists = ARVaultService.isEmailAttachment('00D1I000000kyuFUAQ',sample,'Backup');
         System.assertEquals(true, isExists);
    }
    
    /* public static testMethod void test1(){

         String sample='[resultCriteria:{{"0":{"name":"AcceptedEventRelation","label":"Accepted Event Relation","isExisted":true},"1":{"name":"Account","label":"Account","isExisted":true}}},metaResultCriteria:{{ "0" : "ActionLinkGroupTemplate",  "1" : "ApexClass"}}}]';
         sample='[{"name":"AcceptedEventRelation","label":"Accepted Event Relation","isExisted":true},{"name":"Account","label":"Account","isExisted":true}]';
         //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());         
         try{
             List<Object> recordIDs =(List<Object>) JSON.deserializeUntyped('["123","123","13221"]');
             ARVaultService.startRestore(1406, '00D1I000000kyuFUAQ','00D1I000000kyuFUAQ', 'Account', recordIDs, 'f939bec89dc549d9bb2a5ef164ac0eb5');}catch(Exception e){}                           
         try{ARVaultService.addCompanySettings('autorabit.com','ipRange', 'f939bec89dc549d9bb2a5ef164ac0eb5');}catch(Exception e){}
         try{ARVaultService.addSforgEnviSettings('00D1I000000kyuFUAQ','yes','yes', 'yes','yes', '2000', 'f939bec89dc549d9bb2a5ef164ac0eb5');}catch(Exception e){}                         
         try{ARVaultService.getListOfRestores('00D1I000000kyuFUAQ');}catch(Exception e){}
         //try{ARVaultService.startup('00D1I000000kyuFUAQ', 'f939bec89dc549d9bb2a5ef164ac0eb5', 'force', 'none',  'full', 'TESTQA') ;}catch(Exception e){}         
         //try{ARVaultService.getCompareBackups('00D1I000000kyuFUAQ',22, 25);}catch(Exception e){}         
         try{ARVaultService.getRestoreObject(2);}catch(Exception e){}
         try{ARVaultService.getRecordList(1527,1588,'Account');}catch(Exception e){}                                    
         //try{ARVaultService.formatDateValue('2011-01-10T00:00');}catch(Exception e){}        
         try{ARVaultService.isEmailAttachment('00D1I000000kyuFUAQ',sample,'Restore');}catch(Exception e){}        
         try{ARVaultService.sendEmailNotification('00D1I000000kyuFUAQ',sample,'leelapavan.a@autorabit.com','Restore');}catch(Exception e){}        
     }*/
}