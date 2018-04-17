@isTest
public class ARVaultSetupControllerTest {
    
    static testMethod void test_getOrgBackupConfig_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String, Object> backupConfig = ARVaultSetupController.getOrgBackupConfig('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ');
        System.assertNotEquals(0, backupConfig.size());
    }
    static testMethod void test_getOrgsList_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> orgList = ARVaultSetupController.getOrgsList('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2');
        System.assertNotEquals(0, orgList.size());
    }
    static testMethod void test_getOrgsDetails_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String, Object> orgConfig = ARVaultSetupController.getOrgsDetails('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ');
        System.assertNotEquals(0, orgConfig.size());
    }
    static testMethod void test_basicAuthCallout_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String addSfOrgEnv = ARVaultSetupController.basicAuthCallout('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2', 'Naresh Test Dev', 
                                                                     'nareshtestdev143@autorabit.com',
                                                                     'Naresh@7','NukwuYRFng5fuAMV9MPW5FKaW',
                                                                     'standard' ,'', 'https://login.salesforce.com');
        System.assertEquals('true', addSfOrgEnv);
    }
    
    static testMethod void test_saveBackupConfig_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String objCriteriaString = '[{ "0": { "name": "ActionLinkGroupTemplate", "label": "Action Link Group Template", "isExisted": true }, "1": { "name": "ApexClass", "label": "Apex Class", "isExisted": true },'+
            '"2": { "name": "ApexComponent", "label": "Visualforce Component", "isExisted": true },"3": { "name": "ApexPage", "label": "Visualforce Page", "isExisted": true }, '+
            '"4": { "name": "ApexTestSuite", "label": "Apex Test Suite", "isExisted": true }, "5": { "name": "ApexTrigger", "label": "Apex Trigger", "isExisted": true },'+
            '"6": { "name": "AuraDefinition", "label": "Lightning Component Definition", "isExisted": true },"7": { "name": "AuraDefinitionBundle", "label": "Lightning Component Bundle", "isExisted": true} }]';
        
        String responseString = ARVaultSetupController.saveBackupConfig('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ', 'D','', '02:00', '', objCriteriaString,
                                                                '["ActionLinkGroupTemplate","AnalyticSnapshot","ApexClass","ApexComponent","ApexPage","ApexTestSuite","ApexTrigger","AuraDefinition","AuraDefinitionBundle"]',
                                                                'no','yes');
         System.assertEquals('true', responseString);
    }
    static testMethod void test_testSfConnection_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String testSfOrgEnv = ARVaultSetupController.testSfConnection('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ');
        System.assertEquals('Success', testSfOrgEnv);
    }
    static testMethod void test_updateSfOrg_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String updateSfOrgEnv = ARVaultSetupController.updateSfOrg('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ','Naresh Test Dev', 
                                           'nareshtestdev143@autorabit.com',
                                           'Naresh@7','NukwuYRFng5fuAMV9MPW5FKaW','', 'standard','https://login.salesforce.com');
        System.assertEquals('true', updateSfOrgEnv);
    }
    static testMethod void test_testNewSfConnection_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String testSfOrgEnv = ARVaultSetupController.testNewSfConnection('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','nareshtestdev143@autorabit.com',
                                                   'Naresh@7','NukwuYRFng5fuAMV9MPW5FKaW'
                                                   , 'standard','https://login.salesforce.com');
        System.assertEquals('Success', testSfOrgEnv);
    }
    static testMethod void test_getOAuthOrg_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String, Object> oauthOrg = ARVaultSetupController.getOAuthOrg('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','Dev4', 'arvaultdev2017@autorabit.com');
        System.assertNotEquals(null, oauthOrg);
    }
    static testMethod void test_getMetadataTypes_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String selTypes='["ApexClass","ApexPage"]';
        List<Object> metadataTypes = ARVaultSetupController.getMetadataTypes('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ',selTypes);
        System.assertNotEquals(0, metadataTypes.size());
    }
    static testMethod void test_getSfObjects_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> objList = ARVaultSetupController.getSfObjects('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ');
        System.assertNotEquals(0, objList.size());
    }
    static testMethod void test_getSfFields_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Object> objList  = ARVaultSetupController.getSfFields('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','00D1I000000kyuFUAQ','Account');
        System.assertNotEquals(0, objList.size());
    }
}