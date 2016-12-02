//
//  connectForWSA
//  test_call_wsa
//
//  Created by Ощепков Александр Юрьевич on 01.06.15.
//  Copyright (c) 2015 Ощепков Александр Юрьевич. All rights reserved.
//

import Foundation
import UIKit

class connectForWSA :UIViewController, UITextFieldDelegate, NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var mutableData:NSMutableData = NSMutableData.alloc()
    var currentElementName:NSString = ""
    var valueElement:NSString = ""
    func call_wsa_soap(atributes_U:NSString,atributes_P:NSString,atributes_D:NSString) -> String
    {
        
        alert_mess(atributes_U)
        return atributes_D
    }
    func alert_mess(message:NSString)
    {
        
        var alert = UIAlertView()
        alert.title = message
        alert.message = "sdfgsfdg"
        alert.addButtonWithTitle("OK!!!")
        alert.show()
    }
    func connectTOsoap(atributes_U:NSString,atributes_P:NSString,atributes_D:NSString)
    {
        /*
        var xml_que = "<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>  <soap:Body>  <Authenticate xmlns='http://172.16.20.48/wsa_Dev'>  <userName>\(atributes_U)</userName>   <password>\(atributes_P)</password>  <domain>\(atributes_D)</domain>  </Authenticate> </soap:Body>  </soap:Envelope>"
        */
        
        var xml_que = "<?xml version='1.0' encoding='utf-8'?> <soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>  <soap:Body>  <transact_all xmlns='http://172.16.20.48/wsa_Dev'> <var1>\(atributes_U)</var1> <var2>\(atributes_P)</var2> </transact_all> </soap:Body>  </soap:Envelope>"
        
        var urlstring = "https://topgorn.sibcem.ru/wsa_Dev/service1.asmx"
        var url = NSURL(string: urlstring)
        var theRequest = NSMutableURLRequest(URL: url!)
        var msgLength = String(countElements(xml_que))
        theRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        theRequest.HTTPMethod = "POST"
        
        theRequest.HTTPBody = xml_que.dataUsingEncoding(NSUTF32StringEncoding, allowLossyConversion: false)
        
        
        var connection = NSURLConnection(request: theRequest, delegate: self, startImmediately: true)
        
        
        connection!.start()
        
        if (connection == true)
        {
            var mutableData:Void = NSMutableData.initialize()
        }
        
    }
    func connection (connection:NSURLConnection!, didReceiveResponse response : NSURLResponse!)
    {
        mutableData.length = 0;
    }
    func connection (connection:NSURLConnection!, didReceiveData data: NSData!)
    {
        mutableData.appendData(data)
    }
    func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: NSURLProtectionSpace) -> Bool {
        NSLog("isEqualtoString: %@", NSURLAuthenticationMethodServerTrust.isEqualToString(protectionSpace.authenticationMethod!))
        NSLog("isEqual: %@", isEqual (NSURLAuthenticationMethodServerTrust.isEqualToString(protectionSpace.authenticationMethod!)))
        //    return NSURLAuthenticationMethodServerTrust.isEqualToString(protectionSpace.authenticationMethod!)
        return protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
    }
    
    func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge)
    {
        /*var credentional:NSURLCredential = NSURLCredential()
        if isEqual(NSURLAuthenticationMethodServerTrust.isEqualToString(challenge.protectionSpace.authenticationMethod!))
        {
        NSLog("isEqual: %@", isEqual("topgorn.sibcem.ru" == challenge.protectionSpace.host))
        if isEqual("topgorn.sibcem.ru" == challenge.protectionSpace.host)
        {
        //NSLog("isEqual: %@", "asdfasdf")
        credentional = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust)
        challenge.sender.useCredential(credentional, forAuthenticationChallenge: challenge)
        }
        }
        
        //    challenge.sender.useCredential(credentional, forAuthenticationChallenge: challenge)
        challenge.sender .continueWithoutCredentialForAuthenticationChallenge(challenge)*/
        challenge.sender.useCredential(NSURLCredential(forTrust: challenge.protectionSpace.serverTrust), forAuthenticationChallenge: challenge)
    }
    func connectionDidFinishLoading(connection:NSURLConnection!)
    {
        var xmlParser = NSXMLParser(data: mutableData)
        xmlParser.delegate = self
        xmlParser.parse()
        xmlParser.shouldResolveExternalEntities = true
        
    }
    
    
    
    func parser (parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!)
    {
        currentElementName = elementName
        NSLog("String %@", elementName)
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        
    }
    func parser(parser: NSXMLParser!, foundCharacters string: String) {
        NSLog("String %@", string)
        //self.text_call_txt.text = string
    }
    
    
    
}