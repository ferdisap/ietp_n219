console.log('test.xsl');

async function checkXSL(xmlFile = 'demo7.xsl', xslFile = 'demo7.xsl'){
  const xmlDoc = await createXML(null, 'GET', "", 'getfile', 'xml', "view/general/test/" + xmlFile);
  const xslDoc = await createXML(null, 'GET', "", 'getfile', 'xml', "view/general/test/" + xslFile);
  
  const xslProc = new XSLTProcessor();
  
  xslProc.importStylesheet(xslDoc);
  
  let dom = xslProc.transformToDocument(xmlDoc);
  
  console.log(window.dom = dom);
  document.getElementById('container').innerHTML = dom.firstElementChild.outerHTML;
}


