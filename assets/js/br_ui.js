document.addEventListener('keydown', function(e){
  if (e.key == "/"){
    e.preventDefault();
    document.querySelector('form#form-search > input').focus();
  }
})