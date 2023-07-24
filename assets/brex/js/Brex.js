console.log('brex.js')

class Brex {
  xhr = new XMLHttpRequest();
  xsltProc = new XSLTProcessor();
  
  xmlDoc;

  constructor() {
    if (this.constructor == Brex) {
      throw new Error("Abstract classes can't be instantiated.");
    }
  }

  createXML(url) {
    this.xhr.open('GET', "/brdp?utility=getfile&ct=xml&path=" + url, false);
    this.xhr.send(null);
    return this.xmlDoc = this.xhr.responseXML;
  }
}


class SnsRules extends Brex {
  getDb(path){
    let url = path;
    this.createXML(url);
  }
  getXmlDoc(){
    console.log('this.xmlDoc',this.xmlDoc);
    return this.xmlDoc;
  }
}

let sns = new SnsRules();
sns.getDb('view/brex/style/xsl/snsRules.xml')
sns.getXmlDoc();
