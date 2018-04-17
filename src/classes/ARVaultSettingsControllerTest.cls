@isTest
public class ARVaultSettingsControllerTest {

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
        Map<String, Object> responseObj = ARVaultSettingsController.Login('leelapavan.a@autorabit.com','Leela@345');
        System.assertNotEquals(null, responseObj);
    }
    
    
    static testMethod void test_forgotPassword_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String pwd = ARVaultSettingsController.forgotPassword('jayashree.j@autorabit.com');
        System.assertEquals('Please click the link send to your mentioned Email to regenerate password.', pwd);
    }
    static testMethod void test_getSettings_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Map<String, Object> settings = ARVaultSettingsController.getSettings('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2');
        System.assertNotEquals(null, settings);
    }
    
    static testMethod void test_changePassword_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String pwd = ARVaultSettingsController.changePassword('sdfsdf','Leela@345','0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2');
        System.assertEquals('', pwd);
    }
    
    static testMethod void test_addAWSEnvi_UseCase1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());       
        String addAWSReponse = ARVaultSettingsController.addAWSEnvi('0f913a9c-a99e-45fb-adc2-d7c4a9713dce', 'MTIzNDU2','', 'Y','', '','', '');
        System.assertEquals('AWS client is registerd successfully', addAWSReponse);
    }
    
    static testMethod void test_addServiceURL_UseCase1(){
        String addURL = ARVaultSettingsController.addServiceURL();
        System.assertNotEquals('', addURL);
    }
    
    
}