console.log('test.xsl');

async function checkXSL(xmlFile = 'demo7.xsl', xslFile = 'demo7.xsl'){
  const xmlDoc = await createXML(null, "/ietp_n219/view/general/test/" + xmlFile, 'GET');
  const xslDoc = await createXML(null, "/ietp_n219/view/general/test/" + xslFile, 'GET');
  
  window.xmlDoc = xmlDoc;
  window.xslDoc = xslDoc;

  const xslProc = new XSLTProcessor();
  
  xslProc.importStylesheet(xslDoc);

  // untuk demo11.xsl
  xslProc.setParameter('', 'warningRepository_path', '/ietp_n219/view/general/test/comrep.xml');
  xslProc.setParameter('', 'cautionRepository_path', '/ietp_n219/view/general/test/comrep.xml');

  let dom = xslProc.transformToDocument(xmlDoc);
  
  // console.log(window.dom = dom);
  document.getElementById('container').innerHTML = dom.firstElementChild.outerHTML;

}


