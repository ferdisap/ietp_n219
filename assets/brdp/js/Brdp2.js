console.log('Brdp2.js')

const Brdp = {
  BrList: {
    get parent() {return Brdp;},
    url: "view/brdp/style/xsl/brList.xsl",
    xslDoc: null,
    async setXslDoc(){
      return this.xslDoc = await this.parent.createXML(this.url);
    },
    htmlDoc:null,
    async setHtmlDoc(){
      return this.htmlDoc = this.parent.xmlToHtml(this.parent.brdpDoc.firstElementChild, this.xslDoc.firstElementChild);
    },  
    async refresh(){
      await this.setXslDoc();
      await (this.parent.addAllXslStyle.bind(this))(); //pake await agar xsl tambahan tergabung ke xsl ini
      await this.setHtmlDoc();      
      return this.xslDoc ? true : false;
    }
  },
  BrDetail: {
    get parent() {return Brdp;},
    url: "view/brdp/style/xsl/brDetail.xsl",
    xpath: (brDecisionId) => {
      return `//brPara/brDecision[@brDecisionIdentNumber='${brDecisionId}']/parent::*`
    },
    async xslDoc(){
      return await this.parent.createXML(this.url);
    },
    detailOpen: [],
    async openDetail(brIdent, brDecisionId, trId, el){
      //set window hash
      // window.location.hash = "#" + trId; // tidak pakai yang ini karena window akan langsung menuju hash
      window.history.pushState({},"",window.location.origin + window.location.pathname + '#' + trId);

      if (!this.detailOpen.includes(trId)) {
        // open detail
        let tr = document.getElementById(trId + '_detail');
        if (tr == undefined) { // jika tr belum pernah dibuat
          tr = this.createDetailContainer(trId + '_detail');
          el.parentElement.insertBefore(tr, el.nextElementSibling ?? el);
        } else {
          tr.style.display = '';
        }
        this.detailOpen.push(trId);

        // render brdp
        this.xmlNode = Brdp.brdpDoc.evaluate(this.xpath(brDecisionId), this.parent.brdpDoc).iterateNext();
        this.renderBrdp(brIdent, trId + '_detail', brDecisionId);
        // this.setURLHash(trId);
      } else {
        // close detail
        let tr = document.getElementById(trId + '_detail');
        tr.style.display = 'none';
        this.detailOpen = this.parent.removeArrayCertainItem(trId,this.detailOpen);
      }
    }, 
    async renderBrdp(brIdent, containerId, brDecisionId){
      let td = document.createElement('td');
      td.setAttribute('colspan', 5);
      td.style.border = 'inherit';

      let doc = this.parent.xmlToHtml(this.xmlNode, this.xslDoc);;
      td.innerHTML = doc.firstElementChild.outerHTML;

      let decisionXmlNode = await this.parent.BrDecision.getXmlDoc(brDecisionId);
      decisionXmlNode = await decisionXmlNode.firstElementChild;
      let docDecision = this.parent.xmlToHtml(decisionXmlNode, this.xslDoc).firstElementChild;

      td.appendChild(docDecision);

      this.parent.showContent(containerId, td);
    },
    createDetailContainer(id = null) {
      let tr = document.createElement('tr');
      tr.setAttribute('id', id);
      tr.setAttribute('class', 'brdp_detail');
      tr.innerHTML = 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Laboriosam, velit?';
      return tr;
    },
    trMouseOver: document.createElement('tr'),
    changeBgColor(el) {
      this.trMouseOver.style.backgroundColor = null;
      el.style.backgroundColor = "aliceblue";
      this.trMouseOver = el;
    },    
    async refresh(){
      this.xslDoc = await this.xslDoc();
      // add Allstyle to this XSL
      await (this.parent.addAllXslStyle.bind(this))(); //pake await agar xsl tambahan tergabung ke xsl ini
      return true;
    }
  },
  BrDecision: {
    get parent() {return Brdp;},
    
    /**
     * 
     * @param {String} brDecisionId 
     * @returns XMLDoc
     */
    async getXmlDoc(brDecisionId) {
      return await this.parent.createXML(`dmodule/brdp/br_s1000d/decision/${brDecisionId}.xml`, 'GET');
    }
  },
  BrSearch: {    
    get parent() {return Brdp;},
    listener(el, evt) {
      this.parent.BrDetail.detailOpen = [];
      if (evt.keyCode === 13) { // enter button
        evt.preventDefault();
        /** script baru */
        let searchFilterInput = document.querySelectorAll("input[filterBy]");
        let searchInput = [[searchFilterInput[0]]];
        let fb = document.querySelectorAll(`.filterSort`);
        [1,2,3,4,5].forEach(no => {
          let subSearchInput = [];
          fb.forEach(el => {
            if (el.value == no && el.nextElementSibling.value != ''){
              subSearchInput.push(el.nextElementSibling);
            }
          });
          if (subSearchInput.length > 0) {
            searchInput.push(subSearchInput);
          }
        });
        this.runEngine(searchInput);
      }
    },
    async runEngine(searchInput = []) {
      let db = this.parent.brdpDoc;
  
      let brDataModule = document.implementation.createDocument(null, 'dmodule');
      brDataModule.firstElementChild.innerHTML = db.firstElementChild.innerHTML;
  
      // console.log('brDataModule',brDataModule);
  
      // 1. prepare array berisi XPath (filter) berurutan
      let step_xpaths = this.getXPaths(searchInput);
  
      // 2. untuk setiap item dalam urutan (index 1 adalah filter utama)
      for (let i = 0; i < step_xpaths.length; i++) {
          let xPathRes = this.evaluate(step_xpaths[i],brDataModule.firstElementChild); // output object XPathResult
  
          let extractedNode = [];
          for (let i = 0; i < xPathRes.snapshotLength; i++) {
            let xmlNode = xPathRes.snapshotItem(i); // output = "<brPara>"
            extractedNode.push(xmlNode);
          }
            
          // 4. delete all brPara in updatedDb
          while (brDataModule.firstElementChild.firstElementChild){
            brDataModule.firstElementChild.removeChild(brDataModule.firstElementChild.lastChild)
          }
  
          // 5. add brPara to brDataModule
          for (let n = 0; n < extractedNode.length; n++) {
              brDataModule.firstElementChild.appendChild(extractedNode[n]);
          }
      }
      this.renderResult(brDataModule.firstElementChild);
    },
    getXPaths(searchInput = []) {
      let xpaths = [];
      for (let i = 0; i < searchInput.length; i++) {
        let subXPaths = [];
        searchInput[i].forEach(el => {
          subXPaths.push(this.setXpath(el.getAttribute('filterBy'), el.value));
        });
        xpaths.push(subXPaths.join(' | '));
      }
      return xpaths;
    },
    setXpath(filterBy, text) {
      let xpath_ident = `//@brDecisionPointUniqueIdent[contains(.,'${text}')]/ancestor::brPara`;
      let xpath_title = `//brDecisionPointContent/title[contains(.,'${text}')]/ancestor::brPara`;
      let xpath_category = `//@brCategoryNumber[contains(.,'${text}')]/ancestor::brPara | //brCategory[contains(.,'${text}')]/ancestor::brPara`;
  
      switch (filterBy) {
        case 'ident':
          return xpath_ident;
        case 'title':
          return xpath_title;
        case 'category':
          return xpath_category;
        case 'all':
          return xpath_ident + ' | ' + xpath_title + ' | ' + xpath_category;
        default:
          return '';
      }
    },
    evaluate(xpath, xmlRef) {    
      // xmlRef instanceof Node, jadi perlu dijadikan Document supaya bisa pakai fungsi evaluate(xpath)
      let newXmlDoc = document.implementation.createDocument(null, 'dmodule');
      newXmlDoc.firstElementChild.innerHTML = xmlRef.innerHTML;
  
      // evaluate xpath terhadap xmlDoc
      const searchResult = newXmlDoc.evaluate(xpath, newXmlDoc, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
      return searchResult;
    },
    async renderResult(rootNode) {    
      
      const xsltProcessor = new XSLTProcessor();
      let xslSearch = this.parent.BrList.xslDoc;
      this.xslSearch = xslSearch;
      xsltProcessor.importStylesheet(xslSearch);
  
      // rootNode berupa <dmodule><brPara/>...<brPara/>...</dmodule>
      let nodes = rootNode.children;
      let innerHTMLTbody = '';
      for(let node of nodes){
        let dom = xsltProcessor.transformToDocument(node);
        let tr = dom.getRootNode().firstChild
        innerHTMLTbody += tr.outerHTML
      };
      // hapus semua tr dari tbody table brdp
      let oriTbody = document.querySelector('#brdpList-table tbody');
      oriTbody.remove();
  
      // tambahkan tr baru yang didapat dari search
      let newTbody = document.createElement('tbody');
      newTbody.innerHTML = innerHTMLTbody;
      document.getElementById('brdpList-table').appendChild(newTbody);
  
      // menambahkan informasi total jumlah pencarian.
      document.getElementById('totalSearchResult').innerHTML = nodes.length + " result(s) found.";
    },
    
  },

  url: "dmodule/brdp/br_s1000d/DMC-N219-A-00-00-0000-00A-024A-D_001-00_EN-US.xml",
  brdpDoc: null,

  /**  
   * @param {String} url
   * @param {String} method 
   * @returns XMLDocument if using async
   */
  createXML(url, method = 'GET'){
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

  /** 
   * @param {String} idContainer 
   * @param {HTML DOM Node} node 
   * @returns 
   */
  renderHtml(idContainer, node){
    console.log(window.nd = node);
    let div = document.createElement('div');
    div.innerHTML = node.outerHTML;

    console.log(window.div = div);

    return this.showContent(idContainer, div);
  },
    
 /** 
   * @param {xmlNode} xmlDoc 
   * @param {XMLDocument} xslDoc 
   * @returns HTML Document - should use dom.firstChildElement or more.
   */
  xmlToHtml(xmlDoc, xslDoc){
    let xsltProcessor = new XSLTProcessor();
    xsltProcessor.importStylesheet(xslDoc)

    let dom = xsltProcessor.transformToDocument(xmlDoc);
    return dom;
  },

  /** 
   * @param {String} idContainer 
   * @param {HTMLNode} element 
   */
  showContent(idContainer, element = undefined){    
    if (element != undefined){
      let container = document.getElementById(idContainer);
      container.innerHTML = '';
      container.innerHTML = element.outerHTML;
      this.currentContent = idContainer;
    }
  },

  removeArrayCertainItem(item, arr) {
    let i = arr.indexOf(item);
    let newArr = arr;
    if (i > -1) {
      newArr.splice(i, 1);
    }
    return newArr;
  },

  /**
   * this adalah object yang memanggil fungsi ini agar bisa ditambah ke xsl original (setelah xsl original nya telah di download)
   * jadi harus di bind(this);
   */
  async addAllXslStyle(){
    if (AllStyle.xslDoc == undefined){
      await AllStyle.getListAllGeneralStyle();
      AllStyle.cache;
    }
    this.xslDoc.firstElementChild.innerHTML += AllStyle.xslDoc.firstElementChild.innerHTML;
  },
  
  /** */
  async refresh(){
    return this.brdpDoc = await this.createXML(this.url);
  },
}

document.addEventListener('DOMContentLoaded',  () => {

    Brdp.refresh()
    .then((v) => v ? Brdp.BrList.refresh() : false)
    .then((v) =>  v ? Brdp.BrDetail.refresh() : false)
    .then((v) =>  {
      if (v) {
        Brdp.renderHtml('BrList', Brdp.BrList.htmlDoc.firstElementChild);
      }
    })
});

