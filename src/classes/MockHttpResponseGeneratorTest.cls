@isTest
public class MockHttpResponseGeneratorTest {

    static  void test_respond_UseCase1(){
        List<CustomSetting__c> pos = [SELECT EndPoint_URL__c FROM CustomSetting__c where name= 'WEBSERVICE_URL'];
        String baseURL = '';
        if(pos != null  && pos.size() > 0){
            baseURL = pos.get(0).EndPoint_URL__c; 
        }
        
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint(baseURL+ '/getSforgBakupCfg');
        request.setMethod('POST');
        request.setHeader('Content-type', 'application/json');
        HTTPResponse response = new MockHttpResponseGenerator().respond(request);
        System.assertEquals(null, response);
    }
}