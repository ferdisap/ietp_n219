const Search = {
  filterBy: 'all',
  value: null,
  xpath_ident: function(value){
    return `//@brDecisionPointUniqueIdent[contains(.,'${value}')]/ancestor::brPara`
  },
  xpath_title:function(value){
    return `//brDecisionPointContent/title[contains(.,'${value}')]/ancestor::brPara`;
  },
  xpath_definition:function(value){
    return `//brDecisionPointText[contains(.,'${value}')]/ancestor::brPara`;
  },
  xpath_category:function(value){
    return `//@brCategoryNumber[contains(.,'${value}')]/ancestor::brPara | //brCategory[contains(.,'${value}')]/ancestor::brPara`;
  },

  setNodeEvaluator(value){
    let xpath = null;
    if(this.filterBy == 'all'){
      xpath = 
        this.xpath_ident(value) + ' | ' + 
        this.xpath_title(value) + ' | ' + 
        this.xpath_definition(value) + ' | ' + 
        this.xpath_category(value);
    }
    else {
      xpath = eval(`this.xpath_${this.filterBy}('${value}')`);
    }
    return xpath;
  },

  run(value) {
    let xpath = this.setNodeEvaluator(value);
    
    // settimoute berfungsi untuk menambahkan loading image
    this.loadingImg();
    setTimeout(() => {
        
    // prepare XMLHttpRequest
    const myXMLHTTPRequest = new XMLHttpRequest();
  
    // get the xsl transform for template table
    myXMLHTTPRequest.open("GET", "style/xsl/brDoc/brDoc.xsl", false);
    myXMLHTTPRequest.send(null);
    const xslRef = myXMLHTTPRequest.responseXML;
    // console.log('xslRef', xslRef);
  
    // get the dmodule to search the value
    myXMLHTTPRequest.open('GET', "dmodule/br/DMC-N219-A-04-10-0100-00A-024A-D_001-00_EN-US.xml", false);
    myXMLHTTPRequest.send(null);
    const xmlRef = myXMLHTTPRequest.responseXML;
    // console.log("xmlRef", xmlRef);
  
    // prepare XSLT processor within the stylesheet imported
    const xsltProcessor = new XSLTProcessor();
    xsltProcessor.importStylesheet(xslRef);
  
    // prepare serializer, to extract the result of XSLT processing.
    const XMLS = new XMLSerializer();
  
    // XPath evaluator from the xmlRef (dmodule)
    const searchResult = xmlRef.evaluate(
      xpath,
      xmlRef, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
  
    // delete all tbody innerHTML
    var tbody= document.querySelector('table tbody');
    tbody.innerHTML = '';
  
    let node = null;
    let parser = new DOMParser();
    let container = document.createElement('tbody');

    let trNumber = 1;
    for (let i = 0; i < searchResult.snapshotLength; i++) {
      node = searchResult.snapshotItem(i);
      // console.log("node",node );

      // make <tr>, by extracting the XSLT result and make the serialize
      var result = xsltProcessor.transformToDocument(node);
      result = XMLS.serializeToString(result);
      
      // parsing the result of XSLT to change it into DOM
      let parserResult = parser.parseFromString(result, "text/xml");
  
      // re make <tr> because use parser.firstChild (<tr>...</tr>) cannot resolve
      let tr = document.createElement('tr');
      tr.setAttribute('id',parserResult.firstChild.id);
      tr.setAttribute('onclick', parserResult.firstChild.getAttribute('onclick'));
      tr.innerHTML = parserResult.firstChild.innerHTML;
      tr.firstChild.innerHTML = trNumber;
      trNumber += 1;
  
      // change the table body, pakai container biar nanti enak nambahin icon loading muter2
      container.appendChild(tr);
    }
    // change the table body
    tbody.innerHTML = container.innerHTML;

    document.querySelector('#search-result').innerHTML = "The total result is " + searchResult.snapshotLength + ".";
    }, 0);
  },

  search(value){
    let form = document.getElementById('form-search');
    let filterBy = null;
    form.filterBy.forEach(el => {
      if(el.checked){
        filterBy = el.value;
      }
    })
    this.filterBy = filterBy;
    // return
    // this.value = value;
    // console.log('this.value',this.value);
    // this.loadingImg();
    this.run(value);
    // delay.call(this, 300, () => {
    //   this.run(value);
    // });
  },

  loadingImg(){
    let tbody= document.querySelector('table tbody');
    tbody.innerHTML = 'Searching proccess...';
  },

  init: (function(){
    document.querySelector('#form-search').addEventListener('keypress', (e) => {
      // console.log(e.key);
      if (e.keyCode === 13) { // enter button
        e.preventDefault();
        // console.log(e.target.value);
        Search.search(e.target.value);
      } 
    });
  })()

}

function delay(t, callback){
  clearTimeout(this.to);
  this.to = setTimeout(callback, t);
}