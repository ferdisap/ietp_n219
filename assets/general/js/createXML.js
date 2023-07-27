function createXML(create = [null, 'root'], method = 'GET', url ="", utility = 'getfile', ct = 'xml', path = "", ){

  if (method == null){
    let namespace = create[0];
    let root = create[1];
    return Promise.resolve(document.implementation.createDocument(namespace, root, null));
  } 
  else if(method == 'GET'){
    xhr = new XMLHttpRequest();

    let prom = new Promise((resolve,reject) => {
      // xhr.open(method, "/?utility=getfile&ct=xml&path=" + url, false); 
      xhr.open(method, `${url}/?utility=${utility}&ct=${ct}&path=${path}` , false); 
      // xhr.open(method, `${url}/?utility=${utility}` , false); 
      xhr.onload = () => {
        if (xhr.status >= 200 && xhr.status < 300) {
            if (ct == 'xml'){
              return resolve(xhr.responseXML)
            } else {
              return resolve(JSON.parse(xhr.responseText));              
            }
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
    return prom;
  }

  
}