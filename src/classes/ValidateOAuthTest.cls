@isTest
public class ValidateOAuthTest {
    
    static testMethod void test_basicAuthCallout_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String addSfOrgEnv = new ValidateOAuth().basicAuthCallout('bac6730f-806c-4922-b219-6890b37db4ad', 'QHJuYXZAMjAxNA==',
                                                                  'ARVaultDemoQAFeb11', 'ashok.qa3@autorabit.com', 'Jan@2018', 'oAsvcABgrcT3SiLFJWIxrgP0w','standard','','https://login.salesforce.com');
        System.assertEquals('true', addSfOrgEnv);
    }

    static testMethod void test_updateSfOrg_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String updateSfOrgEnv = new ValidateOAuth().updateSfOrg('bac6730f-806c-4922-b219-6890b37db4ad', 'QHJuYXZAMjAxNA==',
                                                                '00D1I000000kyuFUAQ','Prod org', 'arvaultprod@autorabit.com', '','', '','oauth','https://arvault-prod-dev-ed.my.salesforce.com');
        System.assertEquals('true', updateSfOrgEnv);
    }
   
    /*static testMethod void test_redirect_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        //new ValidateOAuth().onLoadCode();
        PageReference pageRef = new ValidateOAuth().redirect();
        System.assertEquals(null, pageRef);
    }*/
}