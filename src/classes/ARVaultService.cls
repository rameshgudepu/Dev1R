public with sharing class ARVaultService {
    
    
    public static Map<String, Object>  getOrgBackupConfig(String idUser, String txARVault, String sfOrgId){
        String userInfo = '{"sfOrgId":"'+sfOrgId +'"}';
        String serviceURL = '/getSforgBakupCfg';        
        Map<String, Object> responseList =  generateResponse(idUser, txARVault, serviceURL, userInfo);
        System.debug(''+responseList);
        if(responseList != null && responseList.size() > 0){
            Map<String, Object> objCriteria = (Map<String, Object> ) responseList.get('objCriteria');       
            Map<String, Object> metadataMap = (Map<String, Object> ) objCriteria.get('metadata');
            List<Object> metadataList = new List<Object>();
            if(metadataMap != null && metadataMap.size() > 0){
                for(String key:metadataMap.keySet()){
                    String colName = (String) metadataMap.get(key);
                    metadataList.add(colName);               
                }
            }
            Map<String, Object> dataList = (Map<String, Object>) objCriteria.get('data');
            responseList.put('objCriteria', dataList);
            responseList.put('metadata', metadataList);            
        }        
        return responseList;
    }
    
    public static String saveBackupConfig(String idUser, String txARVault, String idSforg, String flScdFrq, String dtScd, String tmScd, String dayScd, String objCriteria, 
                                          String metadataTypes, String isFullDataBackup, String isFullMetaDataBackup)
    {        
        String objCriteriaStr = '{"metadata" : {';
        List<Object> metadataTypeList = (List<Object>) JSON.deserializeUntyped(metadataTypes); 
        System.debug('saveBackupConfig:metadataTypeList<'+metadataTypeList);
        if(metadataTypeList != null && metadataTypeList.size() > 0){
            integer i = 0;
            for(Object o: metadataTypeList){
                
                String s1 = (String) o;
                objCriteriaStr += ' "'+i +'" : ';
                objCriteriaStr += '"' + s1+ '"';
                if(i < metadataTypeList.size() -1 ){
                    objCriteriaStr += ', ';
                }
                i++;
            }
        }
        objCriteriaStr += '}, ';
        objCriteriaStr += '"data" : '+objCriteria+'}';

        String jsonInput = '{"idSforg": "'+idSforg
            +'","flScdFrq": "'+flScdFrq
            +'","dtScd": "'+dtScd
            +'","tmScd": "'+tmScd
            +'","dayScd": "'+dayScd
            +'","objCriteria": '+  objCriteriaStr //objCriteria
            +',"idUser": "'+idUser+'"'
            +', "isFullMetaDataBackup": "'+isFullMetaDataBackup+'"'
            +', "isFullDataBackup": "'+isFullDataBackup+'"}';
        String serviceURL = '/addSforgBakupCfg';
		System.debug('jsonInput:'+jsonInput);
        return generateResponseStr('POST', idUser, txARVault, serviceURL, jsonInput);         
    }
    
    public static String generateResponseStr(String requestMethod, String idUser, String txARVault, String serviceURL, String jsonInput){

        List<CustomSetting__c> pos = [SELECT EndPoint_URL__c FROM CustomSetting__c where name= 'WEBSERVICE_URL'];
        String baseURL = '';
        if(pos.size() > 0){
            baseURL = pos.get(0).EndPoint_URL__c; 
        }
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(baseURL + serviceURL);
        req.setMethod(requestMethod);
        req.setHeader('Content-type', 'application/json');       
        
        //Blob headerValue = Blob.valueOf(idUser + ':' + EncodingUtil.base64Decode(txARVault).toString());
        String authorizationHeader = 'Bearer ' + txARVault; //EncodingUtil.base64Encode(headerValue);
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
    
    public static List<Object> getOrgsList(String idUser, String txARVault){
        String jsonInput = '{"idUser": "'+idUser+'"}';
        String serviceURL = '/getAllSforgEnviInfoOfUser';
        return generateListResponse(idUser, txARVault, serviceURL, jsonInput);            
    }
    
    public static Map<String, Object> getOrgsDetails(String idUser, String txARVault, String sfOrgId){
        
        String jsonInput = '{"sfOrgId":"'+sfOrgId+'"}';//'{"sfOrgId":"00D6F000001OOISUA4"}';
        String serviceURL = '/getSforgEnvi';
        return generateResponse(idUser, txARVault, serviceURL, jsonInput);
    }
    
    public static List< Object> generateListResponse(String idUser, String txARVault, String serviceURL, String jsonInput){
        
        List<CustomSetting__c> pos = [SELECT EndPoint_URL__c FROM CustomSetting__c where name= 'WEBSERVICE_URL'];
        String baseURL = ''; //'https://54.66.202.202:8443/ARVault';
        if(pos.size() > 0){
            baseURL = pos.get(0).EndPoint_URL__c; 
        }                 
        HttpRequest req = new HttpRequest();
        req.setEndpoint(baseURL + serviceURL);
        req.setMethod('POST');
        req.setHeader('Content-type', 'application/json');
        
        // Specify the required user name and password to access the endpoint
        // As well as the header and header information
        //Blob headerValue = Blob.valueOf(idUser + ':' + EncodingUtil.base64Decode(txARVault).toString());
        String authorizationHeader = 'Bearer ' + txARVault; //EncodingUtil.base64Encode(headerValue);
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
    
    public static String basicAuthCallout(String idUser, String txARVault,
                                          String orgName, 
                                          String userName, 
                                          String pwd, 
                                          String sfSecToken, 
                                          String sfAuthType,                                          
                                          String refreshToken, 
                                          String instanceURL)
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
        System.debug('jsonInput:'+userInfo);
        return generateResponseStr('POST', idUser, txARVault, serviceURL, userInfo);                
    }
    // Called on SetUp Page to test SF connection.
    public static String testNewSfConnection(String idUser, String txARVault, String userName, String password, String secToken, String authType, String instanceURL){
        String userInfo = '{"sfNmUser":"'+userName
            +'","sfTxPwd":"'+password
            +'", "sfSecToken": "'+secToken
            +'", "sfInstanceUrl":"'+ instanceURL
            +'"}';
        String serviceURL = '/testSfConnection';
        return generateResponseStr('POST', idUser, txARVault, serviceURL, userInfo);       
    }
    
    public static String testSfConnection(String idUser, String txARVault, String sfOrgID){
        String userInfo = '{"idSforg":"'+sfOrgID
            +'"}';
        String serviceURL = '/testSfConnection';
        return generateResponseStr('POST', idUser, txARVault, serviceURL, userInfo);                
    }
    
    public static String updateSfOrg(String idUser, String txARVault, String idSforg, 
                                     String nmLable, 
                                     String sfNmUser,
                                     String sfTxPwd, 
                                     String sfSecToken, 
                                     String accessToken, 
                                     String sfAuthType,
                                     String instanceURL)
    {
        String userInfo = '{"idSforg":"'+idSforg
            +'","nmLable":"'+nmLable
            +'", "sfNmUser": "'+sfNmUser
            +'","sfTxPwd":"'+sfTxPwd
            +'","sfSecToken":"' +sfSecToken
            +'", "idUser": "'+idUser
            +'", "sfAccessToken":"'+accessToken
            +'", "sfInstanceUrl":"'+instanceURL   
            +'","sfAuthType":"'+sfAuthType
            +'"}';
        
        String serviceURL = '/updateSforgEnvi';
        return generateResponseStr('POST', idUser, txARVault, serviceURL, userInfo); 
    }
    
    public static List<Object> getSfObjects(String idUser, String txARVault, String sfOrgID){
        String jsonInput = '{"sfOrgId": "'+sfOrgID+'"}';
        String serviceURL = '/getSfObjects';
        Map<String, Object> responseList = generateResponse(idUser, txARVault, serviceURL, jsonInput);
        List<Object> objList = (List<Object>) responseList.get('objects');
        return objList;    
    }
    
    public static List<Object> getSfFields(String idUser, String txARVault, String sfOrgID, String sfObjName){
        String jsonInput = '{"sfOrgId": "'+sfOrgID+'", "sfObjName": "'+sfObjName+'"}';
        String serviceURL = '/getSfFields';
        Map<String, Object> responseList = generateResponse(idUser, txARVault, serviceURL, jsonInput);
        List<Object> objList = (List<Object>) responseList.get('fields');
        return objList;
    }  
    public static Map<String, Object> generateResponse(String idUser, String txARVault, String serviceURL, String jsonInput){
        
        List<CustomSetting__c> pos = [SELECT EndPoint_URL__c FROM CustomSetting__c where name= 'WEBSERVICE_URL'];
        String baseURL = '';
        if(pos.size() > 0){
            baseURL = pos.get(0).EndPoint_URL__c;
        }
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(baseURL + serviceURL);
        req.setMethod('POST');
        req.setHeader('Content-type', 'application/json');
        
        //Blob headerValue = Blob.valueOf(idUser + ':' + EncodingUtil.base64Decode(txARVault).toString());
        String authorizationHeader = 'Bearer ' + txARVault;// EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        req.setBody(jsonInput);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        Map<String, Object> responseObjects = new Map<String, Object>();
        if(res.getStatusCode() == 200){
            
            system.debug('Authentication success!!!' + res);
            System.debug(res.getBody());
            responseObjects = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());                         
        }else{
            
            System.debug('Authentication failed!!!' + res + res.getStatusCode() + res.getBody());
            responseObjects.put('error', res.getBody());                                        
        }
        return responseObjects;
    }   
    
    public static List<Object> getListOfBackups (String idUser, String txARVault, String sfOrgID) {
        String jsonInput = '{"sfOrgId": "'+sfOrgID+'"}';
        String serviceURL = '/getAllSforgBakupStatus';
        return generateListResponse(idUser, txARVault, serviceURL, jsonInput);              
    }
    
    public static Map<String, Object> convertToObjectList(Map<String, Object> response){
        Map<String, Object> resultCritList =  (Map<String, Object>) response.get('resultCriteria');          
        Map<String, Object> metaResultCritList =  (Map<String, Object>) response.get('metaResultCriteria');                  
        if(resultCritList != null){                                                     
            List<Object> resultList = new List<Object>();
            for (String strKey : resultCritList.keyset() )  {
                Map<String, Object> mObj = (Map<String, Object>) resultCritList.get(strKey);
                resultList.add(mObj);
            }
            response.put('resultCriteria', resultList);        
        }  
        if(metaResultCritList != null){
            List<Object> metaResultList = new List<Object>();
            for (String strKey : metaResultCritList.keyset() )  {
                Map<String, Object> mObj = (Map<String, Object>) metaResultCritList.get(strKey);                
                metaResultList.add(mObj);
            }
            response.put('metaResultCriteria', metaResultList);        
        }
        return response;
    }
    
    public static Map<String, Object> getBackupObject (String idUser, String txARVault, Integer backupID) {
        String jsonInput = '{"backupId" : '+backupID+'}';
        String serviceURL = '/getSforgBakupStatus';        
        Map<String, Object> responseList = generateResponse(idUser, txARVault, serviceURL, jsonInput);
        return convertToObjectList(responseList);        
    }
    
    
    public static List<String> getBackupsLog (String idUser, String txARVault, Integer backupID) {
        String jsonInput = '{"backupId" : '+backupID+'}';
        String serviceURL = '/getBackupLog';
        String responseStr = generateResponseStr('POST', idUser, txARVault, serviceURL, jsonInput);
        List<String> responseString = new List<String>();
        if(responseStr != null)
            responseString = responseStr.split('\n');
        return responseString;
    }
       
                
    public static List<Object> getBackupsForDates (String backupObjects, String sFromDate, String sToDate) {                                                                                                                                                                                                                                                                                              
                                                                                                                                         
        List<Object> backupList = new List<Object>();
        if(backupObjects != null && backupObjects != ''){
        	backupList  = (List<Object>) JSON.deserializeUntyped(backupObjects);    
        }                
        List<Object> returnObjList = new List<Object>();
        for(Object bObject: backupList){
            Map<String, Object> mapObj = (Map<String, Object>) bObject;
            String procStatus =  (String) mapObj.get('objProcStatus');
                                                                                                                                
            if(procStatus.toUpperCase() == 'COMPLETED'){   
                mapObj = convertToObjectList(mapObj);
                DateTime backupDate = DateTime.newInstance( (Long) mapObj.get('tmStamp'));                                                                                                                                                                                                                                                                                                                             
                Date bDate =  backupDate.date();
                if(bDate > Date.valueOf(sFromDate) && bDate < Date.valueOf(sToDate))  {                    
                    returnObjList.add(mapObj);
                }                  
            }
        }        
        return returnObjList;
    }
    
    public static List<Object> getCompletedBackups (String idUser, String txARVault, String sfOrgID) {
        List<Object> backupList = getListOfBackups(idUser, txARVault, sfOrgID);
        List<Object> returnObjList = new List<Object>();
        for(Object bObject: backupList){
            Map<String, Object> mapObj = (Map<String, Object>) bObject;
            String procStatus =  (String) mapObj.get('objProcStatus');
            if(procStatus.toUpperCase() == 'COMPLETED'){   
                mapObj = convertToObjectList(mapObj);
                returnObjList.add(mapObj);                
            }
        }
        return returnObjList;
    }
    
    public static List<Object> getRecordsFromBackup (String idUser, String txARVault, Integer backupID, String objName) {
       
        String jsonInput = '{"backupId": '+backupID+', "objName" : "'+objName+'"}';
        String serviceURL = '/getRecordsFromBackup';
        List<Object> fieldList = new List<Object>(); 
        Map<String, Object> responseList = responseSpecTimeout(idUser, txARVault, serviceURL, jsonInput);
        List<Object> fields = getRecordFieldList(responseList);
        for(String strKey: responseList.keySet()){
            Map<String, Object> mapObj = (Map<String, Object>) responseList.get(strKey);
            Map<String, Object> newMapObj = new Map<String, Object>();
            Integer icount=0;
            for(Object key1: fields){
                String skey1 = (String) key1; 
                if(icount < 5){
                    String str1 = 'Column'+icount;                    
                    Object o = (Object) mapObj.get(skey1);
                    newMapObj.put(str1, o);                     
                }                
                icount++;
            }
            newMapObj.put('ColumnName', fields);
            newMapObj.put('Id', mapObj.get('Id'));
            fieldList.add(newMapObj);                                                        
        }   
        return fieldList;
    }
    
    public static List<Object> getChangeViewRecords (String idUser, String txARVault, Integer backupID, String objName, List<Object> recordColumns) {
        String jsonInput = '{"backupId": '+backupID+', "objName" : "'+objName+'"}';
        String serviceURL = '/getRecordsFromBackup';
        List<Object> fieldList = new List<Object>(); 
        Map<String, Object> responseList = responseSpecTimeout(idUser, txARVault, serviceURL, jsonInput);        
        for(String strKey: responseList.keySet()){
            Map<String, Object> mapObj = (Map<String, Object>) responseList.get(strKey);
            Map<String, Object> newMapObj = new Map<String, Object>();
            Integer icount =0;
            for(Object key1: recordColumns){
                String skey1 = (String) key1; 
                Object o = (Object) mapObj.get(skey1);
                String str1 = 'Column'+icount;                    
                newMapObj.put(str1, o);                                         
                icount++;
            }
            newMapObj.put('Id', mapObj.get('Id'));
            fieldList.add(newMapObj);                                                        
        }   
        return fieldList;
    }       

    public static String startBackup (String idUser, String txARVault, String sfOrgID, String backupType, String metadataBackup, String dataBackup, String bkpLabel) {
        String jsonInput = '{"sfOrgId": "'+sfOrgID+'","idUser": "'+idUser+'",'+'"backupType": "'+backupType
            +'","bkpLabel": "'+bkpLabel
            +'", "isFullMetaBackup": "'+metadataBackup
            +'", "isFullDataBackup": "'+dataBackup+'"}';
        String serviceURL = '/startBackup';
		System.debug('jsonInput:'+jsonInput);
        
        String responseString = generateResponseStr('POST', idUser, txARVault, serviceURL, jsonInput);  
        return 'Success';
    }
          
      public static String RegisterNewUser(String firstName, String lastName, String middleName, String email, String org, 
                                           String desig, String country, String mobile)  {
          
          String jsonInpit = '{ "nmFirstName": "'+firstName+'", "nmLastName": "'+lastName+'", "idEmail": "'+email+'",'
              + ' "organization": "'+org+'",  "productId": 1, "nmMiddleName": "'+middleName+'", '
              + ' "nmCountry": "'+country+ '", "nbrMobile": "'+mobile+ '", "nmDesignation": "'+desig+'", '
              + ' "desc": null, "licences": 20, "nmLicenceRange":"", "nmCountryCode":"+91" }';
          
          String userId = 'jayashree.j@autorabit.com';
		  String domain = 'autorabit.com';                                               
          String jsonInput = '{"nmUser": "'+userId +'",'
              +' "nmOrg": "'+domain+'", '
              +' "nmCountry" : "'+country+ '" , '
              +' "idEmail": "'+email+ '" , '
              +' "nbrMobile" : "'+mobile+ '",'
              +' "nmRole" : "'+domain+'"}';
          System.debug('jsonInput:'+jsonInput);
          String serviceURL = '/addUser';
          return responseNoAuth(serviceURL, jsonInput);          
    } 
   
    public static Map<String, Object> Login(String userId,String password) {
       String jsonInput = '{"idEmail": "'+userId +'",'
            +' "txPwd":  "'+password+'"}';
        
        String serviceURL = '/login';
        return responseMapNoAuth(serviceURL, jsonInput);       
    } 
    
    private static List<Object> getRecordFieldList ( Map<String, Object> responseList) {       
        List<Object> fieldList = new List<Object>();
        Set<Object> uniqueSet = new Set<Object>();
        for(String strKey: responseList.keySet()){
            Map<String, Object> mapObj = (Map<String, Object>) responseList.get(strKey);
            for(String fieldKey: mapObj.keySet()){
                uniqueSet.add(fieldKey);
            }
        }
        fieldList.addAll(uniqueSet);
        return fieldList;
    }
    
    @AuraEnabled
    public static List<Object> getListOfCompareBackups (String idUser, String txARVault, String sfOrgID){
        List<Object> responseList = getListOfBackups (idUser, txARVault,sfOrgID);
        List<Object> backupList = new List<Object>();         
        for(Object bObject: responseList){
            Map<String, Object> mapObj = (Map<String, Object>) bObject;
            if(mapObj != null && mapObj.size() > 0){
                String bStatus = (String) mapObj.get('objProcStatus');
                // Get Only Completed Backups
                if(bStatus.toUpperCase() == 'COMPLETED'){                    
                    backupList.add(mapObj);    
                }
            }
        }
        return backupList;
    }
        
    public static List<Object> getMultipleBackupObjects (String idUser, String txARVault, Integer fbackupID, Integer sbackupID) {          
        
        String jsonInput = '{"backupIds" : ['+fbackupID+','+sbackupID+']}';
        String serviceURL = '/getMultipleBackupStatuses';
        
        List<Object> responseList = generateListResponse(idUser, txARVault, serviceURL, jsonInput);
        List<Object> returnList = new List<Object>();
        System.debug('responseList:'+responseList);
        if(responseList != null && responseList.size() > 0){
            
            Map<String, Object> responseMap1 = (Map<String, Object>) responseList.get(0);
            Map<String, Object> responseMap2 = (Map<String, Object>) responseList.get(1);
                       
            returnList.add(convertToObjectList(responseMap1));
            returnList.add(convertToObjectList(responseMap2));              
        }
        System.debug('returnList:'+returnList);          
        return returnList;
    }
    
    public static List<Object> getCompareChangeView (String snapshotRec1, String snapshotRec2, String objName, List<Object> recordColumns) {
        System.debug('snapshotRec1:'+snapshotRec1);
        System.debug('snapshotRec2:'+snapshotRec2);
        // diff, name, value
        List<Object> snapshotList1 = (List<Object>)JSON.deserializeUntyped(snapshotRec1);
        List<Object> snapshotList2 = (List<Object>)JSON.deserializeUntyped(snapshotRec2);
        List<Object> li1 = new List<Object>();
        List<Object> li2 = new List<Object>();
        List<Object> fieldList1 = new List<Object>();
        for(Object o1: snapshotList1){            
            List<Object> snapshotRows = (List<Object>) o1;
            List<Object> newCollist = new List<Object>();           
            for(Object o2: snapshotRows){                
                Map<String, Object> snapshotCols = (Map<String, Object>) o2;
                String strColName = (String) snapshotCols.get('name');
                if(recordColumns.contains(strColName)){
                    for(Object key1: recordColumns){
                        String skey1 = (String) key1;                 
                        if(skey1 == strColName){
                            newCollist.add(snapshotCols);
                        } 
                    }    
                }                                            
            }
            if(newCollist != null && newCollist.size() > 0){
                fieldList1.add(newCollist);                    
            }            
        }
        
        List<Object> fieldList2 = new List<Object>();             
        for(Object o1: snapshotList2){          
            List<Object> snapshotRows = (List<Object>) o1;
            List<Object> newCollist = new List<Object>();          
            for(Object o2: snapshotRows){
                Map<String, Object> snapshotCols = (Map<String, Object>) o2;
                String strColName = (String) snapshotCols.get('name');
                for(Object key1: recordColumns){
                    String skey1 = (String) key1;                 
                    if(skey1 == strColName){
                        newCollist.add(snapshotCols); 
                    } 
                }                               
            }
            if(newCollist != null && newCollist.size() > 0){
                fieldList2.add(newCollist);                                     
            }                       
        }
        
        List<Object> li = new List<Object>();
        li.add(fieldList1);
        li.add(fieldList2);
        return li;                       
    }  
    
    public static List<Object> getRecordsForCompare (String idUser, String txARVault, Integer fbackupID, Integer sbackupID, String objName) {
        List<Object> backupList = new List<Object>();          
        List<Object> recordList = getRecordList (idUser, txARVault, fbackupID,sbackupID, objName);
        if(recordList != null && recordList.size() > 0){
            Map<String, Object> record1 = (Map<String, Object>) recordList.get(0);
            Map<String, Object> rec1 = (Map<String, Object> ) recordList.get(1);
            List<Object> fieldList = (List<Object> ) recordList.get(2);
            System.debug('fieldList:'+fieldList);
            backupList.add(rec1);
            backupList.add(fieldList);          
            backupList.add(record1);                          
        }
        return backupList;      
    }
    
    public static List<Object> getRecordList(String idUser, String txARVault, Integer fbackupID, Integer sbackupID, String objName){        
        String jsonInput = '{"readerList": [{"backupId": '+fbackupID+', "objName" : "'+objName+'"}, '+ '{"backupId": '+sbackupID+', "objName" : "'+objName+'"} ] }';
        
        String serviceURL = '/getComparedRecords';//'/getRecordsFromMultipleBackups';
        Map<String, Object> responseList = responseSpecTimeout(idUser, txARVault, serviceURL, jsonInput);
        System.debug('responseList:'+responseList);
        return formatRecordMap(responseList);
    }
    
    public static List<Object> formatRecordMap(Map<String, Object> mapObj){
        List<Object> li = new List<Object>();
        List<Object> fieldList = new List<Object>();
        Set<Object> uniqueFields = new Set<Object>();
        Map<String, Object> recordMap = new Map<String, Object>();
        Map<String, Object> displayRecordMap = new Map<String, Object>();
        for(String key: mapObj.keySet()){
            //backupID
            Map<String, Object> m1 = (Map<String, Object>) mapObj.get(key); 
            List<Object> rowlist = new List<Object>();
            List<Object> displayRowlist = new List<Object>();
            for(String k1: m1.keySet()){
                // rowID
                Map<String, Object> rowMap = (Map<String, Object>) m1.get(k1);                
                List<Object> collist = new List<Object>();
                List<Object> displayCollist = new List<Object>();               
                Integer icount=0;
                for(String rkey: rowMap.keySet()){
                    // colID
                    Map<String, Object> colMap = (Map<String, Object>) rowMap.get(rkey);
                    Map<String, Object> newMapObj = new Map<String, Object>();
                    String strColName = (String) colMap.get('name');
                    if('BillingAddress' == strColName || 'ShippingAddress' == strColName || 'MailingAddress' == strColName){
                        String sValue = (String) colMap.get('value');                        
                        String svalues = sValue.substringAfterLast('Address');
                    }
                    //if('BillingAddress' != strColName){ // remove this clause after testing
                    uniqueFields.add(strColName);
                    if(icount < 5){
                        displayCollist.add(colMap);                                                           
                    }
                    icount++; 
                    collist.add(colMap);
                    //}    // remove this after test                
                }
                rowlist.add(collist);
                displayRowlist.add(displayCollist);
            }
            
            recordMap.put(key, rowlist);
            displayRecordMap.put(key, displayRowlist);            
        }
        fieldList.addAll(uniqueFields);
        li.add(recordMap);
        li.add(displayRecordMap);
        li.add(fieldList);
        return li;
    }
    
    public static List<Object> getMetadataTypes(String idUser, String txARVault, String sfOrgId, String metadata){ 
        
        List<Object> metadataList = (List<Object>) JSON.deserializeUntyped(metadata);
        Set<Object> typeNameSet  = new Set<Object>();
        typeNameSet.addAll(metadataList);
        
        String jsonInput = '{"sfOrgId" : "'+sfOrgId+'"}';
        String serviceURL = '/getSfMetaTypes';
        Map<String, Object> responseMap = generateResponse(idUser, txARVault, serviceURL, jsonInput);
        List<Object> metadataTypes = new List<Object>();
        if(responseMap != null && responseMap.size() > 0){
            List<Object> respTypes = (List<Object>) responseMap.get('types');            
            for(Object allTypes:respTypes ){
                Map<String, Object> newResponseMap = new Map<String, Object>();
                String typeName = (String) allTypes;
                boolean isChecked = false;
                if(typeNameSet != null && typeNameSet.size() > 0){
                    if(typeNameSet.contains(typeName)){
                        isChecked = true;
                    }    
                }else{
                    // for a register new org
                    isChecked = true;
                }
                
                newResponseMap.put('name', typeName);
                newResponseMap.put('isChecked', isChecked);
                metadataTypes.add(newResponseMap);
            }
        }        
        return metadataTypes;
    }
    
    public static Map<String, Object> fetchOAuthOrg(String idUser, String txARVault, String orgTitle, String userName){ 
        List<Object> orgsList = getOrgsList(idUser, txARVault);
        
        if(orgsList != null && orgsList.size() > 0){
            for(Object org: orgsList){
                Map<String, Object> orgMap = (Map<String, Object>) org;
                if(orgMap != null && orgMap.size() > 0){
                    String title = (String) orgMap.get('nmLable');
                    String user = (String) orgMap.get('sfNmUser');
                    System.debug('title check:'+orgTitle+':'+title);
                    System.debug('username check:'+userName+':'+user);
                    if(userName == user && orgTitle == title){
                        return orgMap;
                    }
                }  
            }
        }
        return null;
    }

    public static List<Object> loadTypeMembers(String metadata1, String metadata2, String typeName){
        System.debug('metadata1:'+metadata1);
        System.debug('metadata2:'+metadata2);
        System.debug('typeName:'+typeName);
        List<Object> returnList = new List<Object>();
        
        if(metadata1 != null && metadata1.length() > 0){
            List<Object> snapshotList1 = (List<Object>)JSON.deserializeUntyped(metadata1);
            List<Object> metadataList1 = new List<Object>();
            for(Object o1: snapshotList1){
                Map<String, Object> metaCritMap1 = (Map<String, Object>) o1;
                if(metaCritMap1 != null && metaCritMap1.size() > 0){
                    if(typeName.equals(metaCritMap1.get('type'))){
                        metadataList1.add(metaCritMap1);
                    }
                }
            }
            returnList.add(metadataList1);            
        }
        
        if(metadata2 != null && metadata2.length() > 0){
            List<Object> snapshotList2 =  (List<Object>)JSON.deserializeUntyped(metadata2);
            List<Object> metadataList2 = new List<Object>();
            for(Object o2: snapshotList2){
                Map<String, Object> metaCritMap2 = (Map<String, Object>) o2;
                if(metaCritMap2 != null && metaCritMap2.size() > 0){
                    if(typeName.equals(metaCritMap2.get('type'))){
                        metadataList2.add(metaCritMap2);
                    }
                }
            }
            returnList.add(metadataList2);            
        }
        return returnList;
    }           
    
    public static Map<String, Object> responseSpecTimeout(String idUser, String txARVault, String serviceURL, String jsonInput){

        List<CustomSetting__c> pos = [SELECT EndPoint_URL__c FROM CustomSetting__c where name= 'WEBSERVICE_URL'];
        
        String baseURL = '';
        if(pos.size() > 0){
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
        req.setTimeout(60000);            
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        Map<String, Object> responseObjects = new Map<String, Object>();
        if(res.getStatusCode() == 200)
        { 
            system.debug('Authentication success!!!' + res);
            //System.debug(res.getBody());
            responseObjects = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());                         
        } 
        else
        {
            system.debug('Authentication failed!!!' + res + res.getStatusCode());
            responseObjects = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());                                 
        }
        return responseObjects;
    }

    public static String forgotPassword(String emailId){
        String userInfo = '{"idEmail":"'+emailId+'"}';        
        String serviceURL =  '/users/user/resetpassword';
        return responseNoAuth(serviceURL, userInfo);         
    }
    
 	public static String changePassword (String existingPWD, String txPWD, String idUser, String txARVault){
                   String userInfo = '{"existingPWD":"'+existingPWD
            +'","txPWD":"'+txPWD
            +'", "idUser": "'+ idUser
            +'"}';
        String serviceURL = '/users/user/changepassword';
        return generateResponseStr('POST', idUser, txARVault,serviceURL, userInfo);        
    }
    
    public static Map<String, Object> getSettings (String idUser, String txARVault){
        String userInfo = '{"idUser": "'+ idUser+'"}';
        String serviceURL = '/getSettings';
        Map<String, Object> responseList = generateResponse(idUser, txARVault, serviceURL, userInfo);
        responseList = convertToObjectList(responseList);
        return responseList; 
    }
    public static String  addAWSEnvi(String idUser, String txARVault, String nmLable, String defaultSettings, 
                                    String s3IdAcckey, String s3IdSeckey,
                                    String s3Region, String s3EncryptionEnabled){
       String userInfo = '{"defaultSettings":"'+defaultSettings
            +'","nmLable":"'+nmLable
            +'", "s3IdAcckey": "'+s3IdAcckey
            +'", "s3IdSeckey":"'+ s3IdSeckey
            +'", "idUser": "'+ idUser
            +'", "s3Region": "'+ s3Region
            +'", "s3EncryptionEnabled": "'+ s3EncryptionEnabled
            +'"}';
        System.debug('userInfo:'+userInfo);
        String serviceURL = '/addAwsEnvi';
        return generateResponseStr('POST', idUser, txARVault, serviceURL, userInfo);                
    }
    
    public static List<Object>  getCompareMembers(String idUser, String txARVault, Integer fbackupID,Integer sbackupID, String memType, String memName){
        String userInfo = '{"readerList":[{"backupId":'+fbackupID+',"sfMemType":"'+memType+'","sfMemName":"'+memName+'"},'+
            '{"backupId":'+sbackupID+',"sfMemType":"'+memType+'","sfMemName":"'+memName+'"}]}';
        
        String serviceURL = '/getComparedMetaFiles';
        Map<String, Object> responseObj = generateResponse(idUser, txARVault, serviceURL, userInfo);
        List<Object> responseList = new List<Object>();
        List<Object> leftResponseList = new List<Object>();
        List<Object> rightResponseList = new List<Object>();
        for(String key:responseObj.keySet()){
            if(key.startsWith('left')){
				Map<String, Object> leftMap = new Map<String, Object>();                
                String leftValue = (String) responseObj.get(key);                
                if(leftValue.startsWith('+') || leftValue.startsWith('-')){
                	leftMap.put('value', leftValue.substring(1, leftValue.length()));
                    leftMap.put('diff', leftValue.substring(0, 1));                    
                }else{
                    leftMap.put('value', leftValue);
                    leftMap.put('diff', '');
                }
                leftResponseList.add(leftMap);
            }else if(key.startsWith('right')){
                Map<String, Object> rightMap = new Map<String, Object>();
                String rightValue = (String) responseObj.get(key);                
                if(rightValue.startsWith('+') || rightValue.startsWith('-')){
                	rightMap.put('value', rightValue.substring(1, rightValue.length()));
                    rightMap.put('diff', rightValue.substring(0, 1));
                }else{
                    rightMap.put('value', rightValue);
                    rightMap.put('diff', '');
                }
                rightResponseList.add(rightMap);
            }                
        }
        responseList.add(leftResponseList);
        responseList.add(rightResponseList);
        return responseList; 
    }
    
    public static String restoreWithoutChild (List<Object> listObject){ 
        String recordIdList = '';
        if(listObject != null && listObject.size() > 0){
            integer recCount = 0;
            for(Object metaObject: listObject){
                System.debug('metaObject:'+metaObject);
                recordIdList += '"'+metaObject+'":["$All"]';
                recCount++;
                if(recCount < listObject.size()){
                    recordIdList += ', ';
                }
            }
        }          
        return   recordIdList;                     
    }
    
    public static String restoreWithChild (List<Object> metadataList, List<Object> dataList ) {
        
        String recordIdList = '';
        if(metadataList != null && metadataList.size() > 0){
            integer recCount = 0;
            for(Object metaObject: metadataList){
                System.debug('metaObject:'+metaObject);
                Map<String, Object> metaMap = (Map<String, Object>) metaObject;
                if(metaMap != null && metaMap.size() > 0){
                    recordIdList += '"'+metaMap.get('name')+'":["';
                    List<Object> members = (List<Object>) metaMap.get('members');
                    integer memCount =0;
                    for(Object oMember: members){
                        String member = (String) oMember;
                        recordIdList += member;
                        memCount++;
                        if(memCount < members.size()){
                            recordIdList += '", "';
                        }
                    }
                    recordIdList += '"]';
                }
                recCount++;
                if(recCount < metadataList.size()){
                    recordIdList += ', ';
                }
            }
        }
        //recordIdList += '\\"CustomObject\\":[\\"Account\\",\\"Contact\\",\\"Asset\\"]';

        if(dataList != null && dataList.size() > 0){
            integer dataCount = 0;
            for(Object dataObject: dataList){
                System.debug('dataObject:'+dataObject);
                Map<String, Object> dataMap = (Map<String, Object>) dataObject;
                if(dataMap != null && dataMap.size() > 0){
                    recordIdList += '"'+dataMap.get('name')+'":["';
                    List<Object> records = (List<Object>) dataMap.get('records');
                    integer recCount =0;
                    for(Object oRecord: records){
                        String record = (String) oRecord;
                        recordIdList += record;
                        recCount++;
                        if(recCount < records.size()){
                            recordIdList += '", "';
                        }
                    }
                    recordIdList += '"]';
                }
                dataCount++;
                if(dataCount < dataList.size()){
                    recordIdList += ', ';
                }
            }
        }
        //recordIdList += '\\"Account\\":[\\"\\",\\"\\"],\\"Contact\\":[\\"\\"]';
        return   recordIdList;                     
    }
    public static String startRestore (String idUser, String txARVault, Integer backupId, String srcSfOrgId, String destSfOrgId,
                                       String metadataTypes, String metadata, String dataObjects, String data ) 
	{
        List<Object> metadataList = new List<Object>();
        String recordIdList = '{"metadata":{';
        if(metadata != null && metadata != '[]'){
            metadataList = (List<Object>) JSON.deserializeUntyped(metadata);
            recordIdList +=  restoreWithChild(metadataList, null);                 
        }else{
            List<Object> metaTypeList = (List<Object>) JSON.deserializeUntyped(metadataTypes);
            recordIdList +=  restoreWithoutChild(metaTypeList);  
        }
        recordIdList += '}, "data":{ ';
        List<Object> dataList = new List<Object>();
        if(data != null && data != '[]'){
            dataList = (List<Object>) JSON.deserializeUntyped(data);   
            recordIdList +=  restoreWithChild(null, dataList);                 
        }else{
            List<Object> dataObjList = (List<Object>) JSON.deserializeUntyped(dataObjects);
            recordIdList +=  restoreWithoutChild(dataObjList);
        }
		recordIdList += '} }'; 
        System.debug('recordIdList:'+recordIdList);
        String jsonInput = '{"backupId": '+backupId +','
            +' "srcOrgId":  "'+srcSfOrgId+'", '
            +' "destOrgId": "'+destSfOrgId+'", '
            +' "userId": "'+idUser+'", '
            +' "restorableMemsMap" : '+recordIdList
            +' }';
        System.debug('json:'+jsonInput);
        String serviceURL = '/startRestore';
        return generateResponseStr('POST', idUser, txARVault, serviceURL, jsonInput);   
    }
    
    public static String startBackupRestore (String idUser, String txARVault, Integer backupId, String srcSfOrgId, String destSfOrgId,
                                       String metadataTypes, String dataObjects )  {
        List<Object> metadataList = new List<Object>();
        String recordIdList = '{"metadata":{';
        if(metadataTypes != null && metadataTypes != ''){
            List<Object> metaTypeList = (List<Object>) JSON.deserializeUntyped(metadataTypes);
            for(Integer i=0; i < metaTypeList.size(); i++){
                String s = (String) metaTypeList.get(i);
            	recordIdList += '"'+s+'" : ["$All"]' ; 
                if(i < metaTypeList.size()-1){
                    recordIdList += ', ';
                }
            }            
        }
        recordIdList += '}, "data":{ ';
        List<Object> dataList = new List<Object>();
        if(dataObjects != null && dataObjects != ''){
            List<Object> dataObjList = (List<Object>) JSON.deserializeUntyped(dataObjects);
            for(Integer i=0; i < dataObjList.size(); i++){
                String s = (String) dataObjList.get(i);
            	recordIdList += '"'+s+'" : ["$All"]' ; 
                if(i < dataObjList.size()-1){
                    recordIdList += ', ';
                }
            }
        }
		recordIdList += '} }'; 
        System.debug('recordIdList:'+recordIdList);                                   
        String jsonInput = '{"backupId": '+backupId +','
            +' "srcOrgId":  "'+srcSfOrgId+'", '
            +' "destOrgId": "'+destSfOrgId+'", '
            +' "userId": "'+idUser+'", '
            +' "restorableMemsMap" : '+recordIdList
            +' }';
        System.debug('json:'+jsonInput);
        String serviceURL = '/startRestore';
        return generateResponseStr('POST', idUser, txARVault, serviceURL, jsonInput);   
    }
    
    public static List<Object> getListOfRestores (String idUser, String txARVault, String sfOrgId) {
        String jsonInput = '{"sfOrgId":"'+sfOrgId +'" }';        
        String serviceURL = '/getAllRestoreStats';
        return generateListResponse(idUser, txARVault, serviceURL, jsonInput);                
    }
    
    public static Map<String, Object> getRestoreObject (String idUser, String txARVault, Integer restoreID) {
        String jsonInput = '{"idRestore" : '+restoreID+'}';
        String serviceURL = '/getSpecificRestoreStats';
       
        Map<String, Object> responseData = generateResponse(idUser, txARVault,serviceURL, jsonInput);
        if(responseData != null && responseData.size() > 0){
            Map<String, Object> resultCritList =  (Map<String, Object>) responseData.get('dataResultSet');          
            Map<String, Object> metaResultCritList =  (Map<String, Object>) responseData.get('metadataResultSet'); 
            System.debug('resultCritList:'+resultCritList);
            responseData.put('dataResultSet', restoreObjectList(resultCritList));
            System.debug('metaResultCritList:'+metaResultCritList);
            responseData.put('metadataResultSet', restoreMetadataList(metaResultCritList));     
        }       
        return responseData;        
    }                
    
    private static List<Object> restoreObjectList(Map<String, Object> resultSet){
        List<Object> dataList = new List<Object>();
        if(resultSet != null && resultSet.size() > 0){
            for(String objectKey: resultSet.keySet()){
                Map<String, Object> objectMap = (Map<String, Object>) resultSet.get(objectKey);
                dataList.add(objectMap);
            }
        }
        return dataList;
    }
    
    private static Map<String, Object> restoreMetadataList(Map<String, Object> resultSet){
        if(resultSet != null && resultSet.size() > 0){                                                     
            Map<String, Object> successMap = new Map<String, Object>();            
            Map<String, Object> successResult = (Map<String, Object>) resultSet.get('Success');
            Map<String, Object> errorResult = (Map<String, Object>) resultSet.get('Errors');
            for (String strKey : successResult.keyset() )  {
                Map<String, Object> mObj = (Map<String, Object>) successResult.get(strKey);
                successMap.putAll(mObj);
            }
            System.debug('successList:'+successMap);
            resultSet.put('Success', successMap);
            Map<String, Object> errorMap = new Map<String, Object>();
            for (String strKey : errorResult.keyset() )  {
                Map<String, Object> mObj = (Map<String, Object>) errorResult.get(strKey);
                errorMap.putAll(mObj);
            }           
            System.debug('errorList:'+errorMap);
            resultSet.put('Errors', errorMap);                   
        }          
        return resultSet;
    }
    
    public static  String getObject(String objName, Map<String, Object> rMap){
        String excelString = '';
        System.debug('objName:'+objName);
        if('Restore'.equals(objName)){
            excelString = getRestoreObject(rMap);
        }else if('Backup'.equals(objName)){
            excelString = getBackupObject(rMap);
        }
        return excelString;
    }
    public static  String getRestoreObject(Map<String, Object> rMap){
        String rLabel = (String) rMap.get('txtLabel');
        String bUser = (String) rMap.get('idUser');
        Long rDateTime = (Long) rMap.get('tmStamp');
        DateTime dt = DateTime.newInstance(rDateTime);
        dt.format('MM/DD/YYYY HH:MM:SS');
        Integer metadataSuccCount = (Integer) rMap.get('metaSuccessCount');
        Integer metadataFailCount = (Integer) rMap.get('metaFailureCount');
        Integer dataSuccCount = (Integer) rMap.get('succesRecords'); 
        Integer dataFailCount = (Integer) rMap.get('failedRecords'); 
        Integer apiCalls  = (Integer) rMap.get('nbrTotApi');
        Integer duration  = (Integer) rMap.get('strTotDuration');
        String status  = (String) rMap.get('objProcStatus');
        string recordString = formatNull(rLabel)+','+bUser+','+dt+','+formatNullToZero(metadataSuccCount)+','+formatNullToZero(metadataFailCount)+','+formatNullToZero(dataSuccCount) 
            	+','+formatNullToZero(dataFailCount) +','+formatNullToZero(apiCalls) +','+ formatNullToZero(duration)  +','+status +'\n';
        return recordString;
    } 
    
    public static  String getBackupObject(Map<String, Object> rMap){
        String backupLabel = (String) rMap.get('bkpLabel');
        String bUser = (String) rMap.get('idUser');
        Long rDateTime = (Long) rMap.get('tmStamp');
        DateTime dt = DateTime.newInstance(rDateTime);
        dt.format('MM/DD/YYYY HH:MM:SS');
        String metadataType = (String) rMap.get('isFullMetaBackup');        
        String dataType = (String) rMap.get('isFullDataBackup');                
        Integer metadataCount = (Integer) rMap.get('metaSuccessCount');
        Integer dataCount = (Integer) rMap.get('successCount'); 
        Integer duration  = (Integer) rMap.get('strTotDuration');
        Integer apiCalls = (Integer) rMap.get('nbrTotApi');
        String status  = (String) rMap.get('objProcStatus');
        string recordString = formatNull(backupLabel)+','+bUser+','+dt+','+formatNullToZero(metadataCount)+','+formatNullToZero(dataCount) 
            	+','+formatBackupType(metadataType)+','+formatBackupType(dataType)+','+formatNullToZero(apiCalls) +','+ formatNullToZero(duration)  +','+status +'\n';
        return recordString;
    }
    
    public static String sendEmailNotification(String sfOrgId, String objects, String mMail, String subject){
        String header, csvname = '';        
        if(subject.contains('Restore')){
            header = 'Label, User, Date/Time, Metadata Success, Metadata Failure, Data Success, Data Failure, API Calls, Duration, Status \n';
            csvname = 'Restore';
        }else if(subject.contains('Backup')){
            header = 'Label, User, Date/Time, Metadata Count, Data Count, Metadata, Data, API Calls, Duration, Status \n';
            csvname = 'Backup';
        }
        System.debug('objects:'+objects);
        string finalstr = header ;
        List<Object> objectsList =(List<Object>) JSON.deserializeUntyped(objects);
        for(Object a: objectsList)
        {
            Map<String, Object> rMap = (Map<String, Object>) a;
            String recordString = getObject(csvname, rMap);
            finalstr = finalstr +recordString;
        }
        Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
        blob csvBlob = Blob.valueOf(finalstr);
        csvname += '_'+sfOrgId+'.csv';
        csvAttc.setFileName(csvname);
        csvAttc.setBody(csvBlob);
        Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
        String[] toAddresses = new list<string>  {mMail};
            //String[] toAddresses = new list<string> {'jayashree.j@autorabit.com'};//, 'naresh.v@autorabit.com', 'leelapavan.a@autorabit.com'};
            email.setSubject(subject);
        email.setToAddresses( toAddresses );
        email.setSenderDisplayName('ARVault User'); 
        email.setPlainTextBody('Please find attached the activity list.');
        
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        
        return 'Success';  
    }
       
    public static boolean isEmailAttachment(String sfOrgId, String objects, String subject){
        string header = 'Activity ID, User , Date/Time, Duration, Records, Size, API Calls, Status \n';
        string finalstr = header ;
        string csvname = '';
        if(subject.contains('Restore')){
            csvname = 'Restore';
        }else if(subject.contains('Backup')){
            csvname = 'Backup';
        }
        System.debug('subject:'+subject+':csvname:'+csvname);
        System.debug('objects:'+objects);
        List<Object> objectsList =(List<Object>) JSON.deserializeUntyped(objects);
        for(Object a: objectsList)
        {
            Map<String, Object> rMap = (Map<String, Object>) a;
            String recordString = getObject(csvname, rMap);
            finalstr = finalstr +recordString;
        }
        Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
        blob csvBlob = Blob.valueOf(finalstr);
        csvname += '_'+sfOrgId+'.csv';        
        csvAttc.setFileName(csvname);
        csvAttc.setBody(csvBlob);
        if(csvBlob != null && csvBlob.size() > 0){
            return true;
        }
        return false;
    }
    
    private static String formatBackupType(String backupType){
        if('yes'.equals(backupType)){
            return 'Full';
        }else if('no'.equals(backupType)){
            return 'Incremental';
        }else{
            return 'none';
        }
    }
    
    private static Integer formatNullToZero(Integer i){
        if(i == null) {
            i = 0;
        }
        return i;
    } 
    
    private static String formatNull(String val){
        if(val == null){
            val = '';
        }
        return val;    
    }
    
    private static String formatZero(String val){
        if(val == null || val == ''){
            val = '0';
        }
        return val;    
    }
    
    private static String responseNoAuth(String serviceURL, String jsonInput){

        List<CustomSetting__c> pos = [SELECT EndPoint_URL__c FROM CustomSetting__c where name= 'WEBSERVICE_URL'];
        String baseURL = '';
        if(pos.size() > 0){
            baseURL = pos.get(0).EndPoint_URL__c; 
        }
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(baseURL + serviceURL);
        req.setMethod('POST');
        req.setHeader('Content-type', 'application/json');               
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

    private static Map<String, Object> responseMapNoAuth(String serviceURL, String jsonInput){
        
        List<CustomSetting__c> pos = [SELECT EndPoint_URL__c FROM CustomSetting__c where name= 'WEBSERVICE_URL'];
        String baseURL = '';
        if(pos.size() > 0){
            baseURL = pos.get(0).EndPoint_URL__c;
        }
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(baseURL + serviceURL);
        req.setMethod('POST');
        req.setHeader('Content-type', 'application/json');
        req.setBody(jsonInput);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        Map<String, Object> responseObjects = new Map<String, Object>();
        if(res.getStatusCode() == 200){
            
            system.debug('Authentication success!!!' + res);
            System.debug(res.getBody());
            responseObjects = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());                         
        }else{
            
            System.debug('Authentication failed!!!' + res + res.getStatusCode() + res.getBody());
            responseObjects.put('error', res.getBody());                                        
        }
        return responseObjects;
    }
    
    public static List<Object> getAllUsers(String idUser, String txARVault){        
        String serviceURL = '/users/all';
        System.debug('txARVault:'+txARVault);
        return getResponse('GET', idUser, txARVault, serviceURL);
    }
    
    public static String addNewUser(String firstName, String lastName, String middleName, String country, String mobile,
                                    String timeZone, String email, String designation, String description, String roles)
    {
    	String serviceURL = '/users/user';
        String jsonInput = '{"nmFirstName":"'+firstName +'", "nmLastName" : "'+ lastName +'", "nmMiddleName" : "'+ middleName
            +'", "nmCountry" : "'+ country +'", "nbrMobile" : "'+ mobile +'", "nmTimeZone" : "'+ timeZone
            +'", "idEmail" : "'+ email +'", "nmDesignation" : "'+ designation +'", "desc" : "'+ description
            +'", "roles" : "'+ roles +'" }';                
        return responseNoAuth(serviceURL, jsonInput);                                    
    }
    
    public static Map<String, Object> getUserObject(String idUser, String txARVault, String userId){
        String serviceURL = '/users/user/'+userId;
        Map<String, Object> userObject = getResponseMap('GET', idUser, txARVault, serviceURL);
        return userObject;
    }
    
    public static List<Object> getResponse(String requestMethod, String idUser, String txARVault, String serviceURL){
        
        List<CustomSetting__c> pos = [SELECT EndPoint_URL__c FROM CustomSetting__c where name= 'WEBSERVICE_URL'];
        String baseURL = '';
        if(pos.size() > 0){
            baseURL = pos.get(0).EndPoint_URL__c;
        }
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(baseURL + serviceURL);
        req.setMethod(requestMethod);
        req.setHeader('Content-type', 'application/json');

        //Blob headerValue = Blob.valueOf(idUser + ':' + EncodingUtil.base64Decode(txARVault).toString());
        String authorizationHeader = 'Bearer ' + txARVault; //EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        List<Object> responseObjects = new List<Object>();
        if(res.getStatusCode() == 200){            
            system.debug('Authentication success!!!' + res);
            System.debug(res.getBody());
            responseObjects = (List<Object>) JSON.deserializeUntyped(res.getBody());                         
        }          
        return responseObjects;
    }    
    
    public static Map<String, Object> getResponseMap(String requestMethod, String idUser, String txARVault, String serviceURL){
        
        List<CustomSetting__c> pos = [SELECT EndPoint_URL__c FROM CustomSetting__c where name= 'WEBSERVICE_URL'];
        String baseURL = '';
        if(pos.size() > 0){
            baseURL = pos.get(0).EndPoint_URL__c;
        }
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(baseURL + serviceURL);
        req.setMethod(requestMethod);
        req.setHeader('Content-type', 'application/json');

        //Blob headerValue = Blob.valueOf(idUser + ':' + EncodingUtil.base64Decode(txARVault).toString());
        String authorizationHeader = 'Bearer ' + txARVault;//EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        Map<String, Object> responseObjects = new Map<String, Object>();
        if(res.getStatusCode() == 200){            
            system.debug('Authentication success!!!' + res);
            System.debug(res.getBody());
            responseObjects = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());                         
        }          
        return responseObjects;
    }
    
    public static List<Object> getAllRoles(String idUser, String txARVault){        
        String serviceURL = '/users/roles/all';
        return getResponse('GET',idUser, txARVault, serviceURL);
    }
    
    public static String addNewRole(String idUser, String txARVault, String roleName, String roleDesc, String permissions){
        String serviceURL = '/users/roles/role';
        List<Object> permission = new List<Object>();
        if(permissions != null && permissions != ''){
            permission = (List<Object>) JSON.deserializeUntyped(permissions);
        }
        System.debug('permission:'+permission);
        String permissionList = '[';
        integer iCount = 0;
        for(Object perm:permission){
            Map<String, Object> permMap = (Map<String, Object>) perm;
            String permissionID = (String) permMap.get('permissionOrder');
            String permissionName = (String) permMap.get('permissionName');
            permissionList += '{"permissionId": ' + permissionID +', "permissionName": "'+ permissionName +'", '
                			+ ' "product": {  "productId": 1, "productName": "ARVault",  "productDesc": "ARVault Project" } '
                		+'}';            
            iCount++;
            if(iCount < permission.size()){
                permissionList += ', ';
            }                       
        }
        permissionList += ']';
        String jsonInput = '{"roleName":"'+roleName +'", "roleDesc" : "'+ roleDesc
            +'", "permissions" : '+ permissionList +' }';     
        System.debug('jsonInput:'+jsonInput);
        return generateResponseStr('POST', idUser, txARVault, serviceURL, jsonInput);
    }        
        
    public static Map<String, Object> getUserRole(String idUser, String txARVault, String roleId){
        String serviceURL = '/users/roles/role/'+roleId;
        Map<String, Object> roleObject = getResponseMap('GET', idUser, txARVault, serviceURL);
        return roleObject;
    }
    
    public static String saveEditRole(String idUser, String txARVault, String roleId, String roleName, String roleDesc, String permissions){
        String serviceURL = '/users/roles/role';
        List<Object> permission = new List<Object>();
        if(permissions != null && permissions != ''){
            permission = (List<Object>) JSON.deserializeUntyped(permissions);
        }
        System.debug('permission:'+permission);
        String permissionList = '[';
        integer iCount = 0;
        for(Object perm:permission){
            Map<String, Object> permMap = (Map<String, Object>) perm;
            String permissionID = (String) permMap.get('permissionOrder');
            String permissionName = (String) permMap.get('permissionName');
            permissionList += '{"permissionId": ' + permissionID +', "permissionName": "'+ permissionName +'", '
                			+ ' "product": {  "productId": 1, "productName": "ARVault",  "productDesc": "ARVault Project" } '
                		+'}';            
            iCount++;
            if(iCount < permission.size()){
                permissionList += ', ';
            }                       
        }
        permissionList += ']';
		
        String jsonInput = '{"roleId": "'+roleId+'",' 
     					+ ' "roleName":"'+roleName +'", "roleDesc" : "'+ roleDesc
            +'", "modifiedDate" : ' + DateTime.now().getTime()
     		+', "permissions" : '+ permissionList +' }';     
        System.debug('jsonInput:'+jsonInput);
        return generateResponseStr('PUT', idUser, txARVault, serviceURL, jsonInput);
    } 
    
    public static String deleteRole(String idUser, String txARVault, String roleId){
        String serviceURL = '/users/roles/role/'+roleId;
        Map<String, Object> returnMap = getResponseMap('DELETE', idUser, txARVault, serviceURL);
        System.debug('returnMap:'+returnMap);
        if(returnMap != null && returnMap.size() > 0){
            return 'true';
        }
        return 'false';    
    }
    
    public static String saveEditUser(String idUser, String txARVault, String userID, String firstName, String lastName, String middleName, String country, 
                                            String email, Integer mobile, String designation, String  timezone, String role){
        String serviceURL = '/users/user';
            System.debug('inputs:'+idUser+':'+txARVault+':'+userID+':'+firstName+':'+lastName+':'+middleName+':'+country+':'+email+':'+mobile+':'+designation+':'+timezone+':'+role);
        String jsonInput = '{  "idUser": "'+idUser+'", '
            				+' "nmFirstName": "'+firstName+'", "nmLastName": "'+lastName+'", "nmMiddleName": "'+middleName+'", '
            				+'   "nmCountry": "'+country+'",  "idEmail": "'+email+'", "nbrMobile": '+mobile+',   '
            				+'  "nmDesignation": "'+designation+'", "tmModifiedDate": '+DateTime.now().getTime()+', "desc": "" , '
            				+' "roles": [        { "roleId": "93ca9b22-cbdb-4bdc-b4ff-6fb02bdeb564"  },        { "roleId": "93ca9b22-cbdb-4bdc-b4ff-6fb02bdeb564"  }    ]    }';
/*	"flActive": true,    "flIsAdmin": false,    "updateType": null,    "existingPWD": null, "organization": null,    
	"licences": null,    "productId": null,    "customerId": null,    "password": null,    "newPassword": null,    "tmCreatedDate": 1519994467000,    */

        System.debug('jsonInput:'+jsonInput);
        return generateResponseStr('PUT', idUser, txARVault, serviceURL, jsonInput);
    } 
}