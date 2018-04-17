public with sharing class ValidateOAuth {    
    
	private ApexPages.StandardController controller {get; set;}
    public String oauthcode {
        get;
        set {
            oauthcode = value;
        }
    }
    
    public String refreshToken {
        get;
        set {
            refreshToken = value;            
        }
    }
    
    public String instanceURL {
        get;
        set {
            instanceURL = value;
        }
    }
    
    public String sfOrgID {
        get;
        set {
            sfOrgID = value;
        }
    }
    public String stateData {
        get;
        set {
            stateData = value;
        }
    }
    
   public String successMessage {
        get;
        set {
            successMessage = value;
        }
    }   

    // initialize the controller
    public ValidateOAuth(ApexPages.StandardController controller) {
        this.controller = controller;        
    }
    
    
    public ValidateOAuth(){
        
    }
    
    public PageReference onLoadCode(){
        String stateStr = ApexPages.currentPage().getParameters().get('state');
        String codeStr = ApexPages.currentPage().getParameters().get('code');
        if(stateStr != null && stateStr != ''){
            successMessage = 'Your salesforce org will be registered. ';
        	String[] userArr = stateStr.split('\\|');
            String orgTitle = '';
            String userName = '';
            String idSfOrg = '';
            if(userArr != null && userArr.size() > 0){
                orgTitle = userArr[0];
                userName = userArr[1];  
                idSfOrg = userArr[2];  
            }
            successMessage += '		Org Title : '+orgTitle;
            successMessage += '  	User Name: '+ userName;
            //successMessage += '  	idSfOrg: '+ idSfOrg;
        }
        return null;
    }

    public PageReference redirect(){
        
        List<String> userArr = new List<String>();
        if(stateData != null && stateData.length() > 0){
         	userArr = stateData.split('\\|');   
        }
        String orgTitle, idUser, txARVault,userName, idSfOrg, loginURL  = '';
        if(userArr != null && userArr.size() > 0){
        	orgTitle = userArr.get(0);
        	userName = userArr.get(1);  
            idSfOrg = userArr.get(2);  
            idUser = userArr.get(3);
            txARVault = userArr.get(4);
            loginURL = userArr.get(5);
        }
        System.debug('orgTitle:'+orgTitle+'userName:'+userName);
        
        String serviceURL = loginURL + '/services/oauth2/token';
        Http h = new Http();     
        System.debug('code:'+oauthcode);
        String reqBody = 'grant_type=authorization_code'
            +'&client_id=3MVG9zlTNB8o8BA2YHUasMGhWsHJ9u4WDfkdIrAoaZiogfGpjkSg1x36V0gIfgJUGp.6HL4QmyHftw5GDi..g&client_secret=6452851928561691716'
            +'&redirect_uri=https://arvaultdev-developer-edition.na59.force.com/apex/testOAuthVfp'
            +'&code='+oauthcode;
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(serviceURL);
        req.setBody(reqBody);
        req.setMethod('POST');
		req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        HttpResponse res = h.send(req);
        System.debug('res.body:'+res.getBody());
        Map<String, Object> s1 = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        System.debug('s1:'+s1);
        if(s1 != null && s1.size() > 0){
            refreshToken = (String) s1.get('refresh_token');
            instanceURL = (String) s1.get('instance_url');
        }
        System.debug('refreshToken:'+refreshToken+':instanceURL:'+instanceURL);
        System.debug('stateData:'+stateData);
        String retStr = '';
        if(idSfOrg != 'undefined' && idSfOrg != '' ){
            retStr = new ValidateOAuth().updateSfOrg(idUser, txARVault, idSfOrg, orgTitle, userName,'', '', 'oauth', refreshToken, instanceURL);
            if(retStr == 'true'){
            	sfOrgID =  idSfOrg;
            }            
        }else{
            retStr = new ValidateOAuth().basicAuthCallout(idUser, txARVault, orgTitle, userName, '', '', 'oauth', refreshToken, instanceURL);
            sfOrgID = retStr;
        }
        if(sfOrgID != ''){
            successMessage = 'Org has been successfully registered with ARVault';
        }else{
            successMessage = 'InvalidOrg, Please verify your credentials.';
        }
		System.debug('retStr:'+retStr);
        return null;
   }    
    
    public String basicAuthCallout(String idUser, String txARVault, String orgName, String userName, String pwd, String sfSecToken, String sfAuthType,
                                          			String refreshToken, String instanceURL)
    {
 
        String userInfo = '{"nmLable":"'+orgName
            +'", "sfNmUser":"'+userName
            +'","sfTxPwd":"'+pwd
            +'","sfSecToken":"'+sfSecToken
            +'","sfAuthType":"'+sfAuthType
            +'", "idUser":"'+idUser
            +'", "sfAccessToken":"'
            +'", "sfRefreshToken":"'+refreshToken
            +'", "sfInstanceUrl":"'+instanceURL
            +'"}';        
        String serviceURL = '/addSforgEnvi';        
        return generateResponseStr(idUser, txARVault, serviceURL, userInfo);           
   }
    

    public String updateSfOrg(String idUser, String txARVault, String idSforg, String nmLable, String sfNmUser,String sfTxPwd, String sfSecToken, 
                                     String sfAuthType, String refreshToken, String instanceURL)
    {
			String userInfo = '{"idSforg":"'+idSforg
                +'","nmLable":"'+nmLable
                +'", "sfNmUser": "'+sfNmUser
                +'","sfTxPwd":"'+sfTxPwd
                +'","sfSecToken":"' +sfSecToken
                +'","sfAuthType":"'+sfAuthType
                +'", "idUser": "'+idUser
                +'", "sfAccessToken":"'+
                +'", "sfRefreshToken":"'+refreshToken
                +'", "sfInstanceUrl":"'+instanceURL         
                +'"}';
            System.debug('jsonInput:'+userInfo);
			String serviceURL = '/updateSforgEnvi';
            return generateResponseStr(idUser, txARVault, serviceURL, userInfo); 
     }                                             
    
     public String generateResponseStr(String idUser, String txARVault, String serviceURL, String jsonInput){
        List<CustomSetting__c> pos = [SELECT EndPoint_URL__c FROM CustomSetting__c where name= 'WEBSERVICE_URL'];
        String baseURL = '';
        if(pos != null  && pos.size() > 0){
             baseURL = pos.get(0).EndPoint_URL__c; 
        }
        
         
        HttpRequest req = new HttpRequest();
        req.setEndpoint(baseURL + serviceURL);
        req.setMethod('POST');
        req.setHeader('Content-type', 'application/json');
        
        //Blob headerValue = Blob.valueOf(idUser + ':' + EncodingUtil.base64Decode(txARVault).toString());
        String authorizationHeader = 'Bearer ' + txARVault;//EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        req.setBody(jsonInput);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String responseObjects = '';
        if(res.getStatusCode() == 200)
        { 
            system.debug('Authentication success!!!' + res);
            System.debug(res.getBody());
            responseObjects =(String)res.getBody();                      
        } 
        else
        {
            system.debug('Authentication failed!!!' + res + res.getStatusCode());
  			responseObjects = (String)res.getBody();                               	
        }
        return responseObjects;
    }  
}