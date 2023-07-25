console.log('brex.js')

const Brex = {

  SnsRule: {
    get parent() {return Brex;},
    url: "view/brex/style/xsl/snsRules.xml",
    xslDoc: async () => {
      console.log(this);
      return await Brex.createXML(Brex.SnsRule.url);
    },
    htmlDoc: () => {
      return Brex.xmlToHtml(Brex.brexDoc, Brex.SnsRule.xslDoc).firstElementChild
    },  
    async refresh(){
      this.xslDoc = await this.xslDoc();
      this.htmlDoc = await this.htmlDoc();
      this.parent.renderHtml('snsRules', this.htmlDoc);
    }
  },

  ContextRule: {
    get parent() {return Brex;},
    url: "view/brex/style/xsl/contextRules.xml",
    xslDoc: async () => {
      console.log(this);
      return await Brex.createXML(Brex.SnsRule.url);
    },
    htmlDoc: () => {
      return Brex.xmlToHtml(Brex.brexDoc, Brex.SnsRule.xslDoc).firstElementChild
    },  
    async refresh(){
      this.xslDoc = await this.xslDoc();
      this.htmlDoc = await this.htmlDoc();
    }
  },

  url: "dmodule/brex/DMC-N219-A-00-00-0000-00A-022A-D_001-00_EN-US.xml",
  brexDoc: null,

  createXML(url, method = 'GET'){
    console.log(url);
    xhr = new XMLHttpRequest();
    let prom = new Promise((resolve,reject) => {
      xhr.open(method, "/brdp?utility=getfile&ct=xml&path=" + url, false); 
      xhr.onload = () => {
        if (xhr.status >= 200 && xhr.status < 300) {
            return resolve(xhr.responseXML)
        } else {
            reject({
                status: this.status,
                statusText: xhr.statusText
            });
        }
      };
      xhr.onerror = () => {
          reject({
              status: this.status,
              statusText: xhr.statusText
          });
      };
      xhr.send();
    });
    return prom
  },

  renderHtml(idContainer, node){
    let div = document.createElement('div');
    div.innerHTML = node.outerHTML;

    return this.showContent(idContainer, div);
  },
    
  xmlToHtml(xmlDoc, xslDoc){
    let xsltProcessor = new XSLTProcessor();
    xsltProcessor.importStylesheet(xslDoc)

    let dom = xsltProcessor.transformToDocument(xmlDoc);
    return dom;
  },

  showContent(idContainer, element = undefined){
    if (this.currentContent != undefined){
      let currentContentContainer = document.getElementById(this.currentContent);
      currentContentContainer.innerHTML = '';
    }
    
    if (element != undefined){
      let container = document.getElementById(idContainer);
      container.innerHTML = element.outerHTML;
      this.currentContent = idContainer;
    }
  },

  async refresh(){
    this.brexDoc = await this.createXML(this.url);
  }
}


document.addEventListener('DOMContentLoaded', function(){
  Brex.refresh();
  Brex.SnsRule.refresh()
})