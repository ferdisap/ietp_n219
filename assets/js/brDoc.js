const xhr = new XMLHttpRequest();
const parser = new DOMParser();
const xsltProcessor = new XSLTProcessor();
const xmlSerializer = new XMLSerializer();

xhr.open('GET', "style/xsl/brDoc/brDetail.xsl", false);
xhr.send(null);
const xslDetail = xhr.responseXML;
// console.log(xslDetail);

xhr.open('GET', "style/xsl/brDoc/brList.xsl", false);
xhr.send(null);
const xslList = xhr.responseXML;
// console.log("xslList",xslList);

xhr.open('GET', "dmodule/br/DMC-N219-A-04-10-0100-00A-024A-D_001-00_EN-US.xml", false);
xhr.send(null);
const xmlRef = xhr.responseXML;
// console.log(xmlRef);



function evaluator(brId){
  let xPath = `//brPara[@brDecisionPointUniqueIdent = '${brId}']`;
  let evaluate = xmlRef.evaluate(xPath,xmlRef,null,XPathResult.ORDERED_NODE_SNAPSHOT_TYPE,null);
  return evaluate.snapshotItem(0);
}

function openList(){
  xsltProcessor.importStylesheet(xslList);
  let fragment = xsltProcessor.transformToFragment(xmlRef,document);
  let container = document.getElementById('container-list');
  container.innerHTML = '';
  container.appendChild(fragment);
  
  // dump();

  goToHash(window.location.hash);
}

function openDetail(brId,brDecisionId,trId){
  window.brDetail ? window.brDetail.style.backgroundColor = 'white' : null;

  // console.log('brId',brId);
  let result = evaluator(brId);
  xsltProcessor.importStylesheet(xslDetail);
  let fragment = xsltProcessor.transformToFragment(result,document);
  
  let container = document.getElementById('container-detail');
  container.innerHTML = '';
  container.appendChild(fragment);

  container.style.width = "30%";
  container.previousElementSibling.style.width = "70%";

  openDecision(brDecisionId);

  window.brDetail = document.getElementById(trId);
  window.brDetail.style.backgroundColor = 'antiquewhite';

}

function closeDetail(){
  let container = document.getElementById('container-detail');
  container.innerHTML = "";

  container.previousElementSibling.style.width = "100%";
  container.style.width = "0%";
}

function openDecision(brDecisionId){
  if(brDecisionId == '' || brDecisionId == undefined ){
    return;
  }
  xhr.open('GET', "dmodule/br/" + brDecisionId + ".xml", false);
  xhr.send(null);
  const xmlDetail = xhr.responseXML;
  console.log('detail', xmlDetail);

  xsltProcessor.importStylesheet(xslDetail);
  let fragment = xsltProcessor.transformToFragment(xmlDetail,document);

  let container = document.getElementById('brDecision');
  if (container != undefined){
    container.innerHTML = fragment.firstChild.innerHTML;
  }
}

function setURLHash(id){
  window.history.pushState({},"",window.location.origin + window.location.pathname + '#' + id);
}

function goToHash(hash){
  window.location.hash = "";
  setTimeout(()=>{
    window.location.hash = hash;
  },0);
}

window.brDetail = null;



// ############ //
function dump(){
  let a = document.querySelector('tbody a');
  a.click()
}





