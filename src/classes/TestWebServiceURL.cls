public class TestWebServiceURL {

    public static List<Object> getListOfBackups (String sfOrgID) {
        String jsonInput = '{"sfOrgId": "'+sfOrgID+'"}';
        String serviceURL = '/getAllSforgBakupStatus';
        return generateListResponse(serviceURL, jsonInput);              
    }
    
        public static List< Object> generateListResponse(String serviceURL, String jsonInput){
        
        List<CustomSetting__c> pos = [SELECT EndPoint_URL__c FROM CustomSetting__c where name= 'WEBSERVICE_URL'];
        String baseURL = 'https://arvault-apac-poc.autorabit.com:8443/ARVault';// 'https://54.66.202.202:8443/ARVault';
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(baseURL + serviceURL);
        req.setMethod('POST');
        req.setHeader('Content-type', 'application/json');
        
        // Specify the required user name and password to access the endpoint
        // As well as the header and header information
        
        String username = '0f913a9c-a99e-45fb-adc2-d7c4a9713dce';
        String password = '123456';
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        req.setBody(jsonInput);
        
        // Create a new http object to send the request object
        // A response object is generated as a result of the request  
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        List<Object> responseObjects = new List<Object>();
        if(res.getStatusCode() == 200)
        { 
            system.debug('Authentication success!!!' + res);
            System.debug(res.getBody());
            responseObjects = (List<Object>) JSON.deserializeUntyped(res.getBody());                         
        } 
        else
        {
            system.debug('Authentication failed!!!' + res + res.getStatusCode());
            responseObjects = (List<Object>) JSON.deserializeUntyped(res.getBody());                                
        }
        return responseObjects;
    }
    
}