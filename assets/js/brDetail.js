function changeZIndex(el){
  el = el.previousElementSibling;
  return el.id == 'brDecision' ? el.style.zIndex = (el.style.zIndex * -1) : null;
}