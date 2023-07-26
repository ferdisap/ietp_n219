console.log('Brex.js')

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
      // this.parent.renderHtml('snsRule', this.htmlDoc);
    }
  },

  ContextRule: {
    get parent() {return Brex;},
    url: "view/brex/style/xsl/contextRules.xml",
    xslDoc: async () => {
      console.log(this);
      return await Brex.createXML(Brex.ContextRule.url);
    },
    htmlDoc: () => {
      return Brex.xmlToHtml(Brex.brexDoc, Brex.ContextRule.xslDoc).firstElementChild
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
      xhr.open(method, "/?utility=getfile&ct=xml&path=" + url, false); 
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
      console.log(element, idContainer, container);
      container.innerHTML = element.outerHTML;
      this.currentContent = idContainer;
    }

    localStorage.setItem('currentContent', this.currentContent);
  },

  async refresh(){
    this.brexDoc = await this.createXML(this.url);
  }
}


document.addEventListener('DOMContentLoaded', async () => {
  let prom = new Promise(async (resolve, reject) => {
    await Brex.refresh();
    await Brex.SnsRule.refresh();
    await Brex.ContextRule.refresh();

    if (Brex.brexDoc instanceof XMLDocument){
      resolve(true);    
    } else {
      reject(false);
    }
  });

  // berfungsi agar diawal kita akan otomatis buka menu SNS Rules atau Context Rules atay Non Context Rules
  prom.then( v => {
    if(v){
      let currentContent = localStorage.getItem('currentContent');
      if (currentContent == null){
        Brex.renderHtml('SnsRule', Brex.SnsRule.htmlDoc);
      } else {
        console.log(`Brex.${currentContent}`);
        eval(`Brex.renderHtml('${currentContent}', Brex.${currentContent}.htmlDoc)`);
      }
    }
  });
})