@extends('html_head')
@section('styles')
<link rel="stylesheet" href="/?utility=getfile&ct=css&path=view/brdp/style/css/table.css">
<link rel="stylesheet" href="/?utility=getfile&ct=css&path=view/general/css/general.css">
@endSection
@section('scripts_onTop')
<script src="/?utility=getfile&ct=javascript&path=assets/general/js/hideShow.js"></script>
@endsection
@section('body')
<header>
  @include('navbar')

  <div class="container text-center mt-3">
    <h1>N219 Project - BRDP</h1>
    <div class="nav justify-content-center d-flex">
      <a href="#" class="nav-link">S1000D</a>
      <a href="#" class="nav-link disabled">PTDI</a>
      <a href="#" class="nav-link disabled">Contract</a>
      <a href="#" class="nav-link disabled">Customer</a>
    </div>
    
    <div class="container mt-3 d-flex justify-content-center">
      <input class="form-control w-50" type="text" filterBy="all" placeholder="find everything of business rule.." aria-label="find business rule" onkeypress="Brdp.BrSearch.listener(this,event)">
    </div>
    <p id="totalSearchResult" class="mb-0 my-1"></p>
  </div>
  <div class="text-center"><a href="javascript:void(0)" rel="noopener noreferrer" onclick='window.open("/refreshLocalStorage","_blank", "popup=yes,width=100,height=100,noopener,noreferrer")'>Refresh</a> Local Storage</div>
</header>

<article id="BrList"></article>
@endsection

@section('scripts_onBottom')
<script src="/?utility=getfile&ct=javascript&path=assets/general/js/createXML.js"></script>
<script src="/?utility=getfile&ct=javascript&path=assets/general/js/AllStyle.js"></script>
<script src="/?utility=getfile&ct=javascript&path=assets/brdp/js/Brdp2.js"></script>
<script>
  function refresh(){
    Brdp.refresh()
    .then((v) => v ? Brdp.BrList.refresh() : false)
    .then((v) =>  v ? Brdp.BrDetail.refresh() : false)
    .then((v) =>  v ? Brdp.BrDecision.refresh() : false)
    .then((v) =>  {
      if (v) {
        Brdp.renderHtml('BrList', Brdp.BrList.htmlDoc.firstElementChild);
        
        // setting table width // TIDAK DIPAKAI karena pakai fixed value width
        // let tbody_tr1_children = document.querySelector('tbody > tr').childNodes;
        // let thead_tr1_children = document.querySelector('thead > tr:nth-child(1)').childNodes;
        // let thead_tr2_children = document.querySelector('thead > tr:nth-child(2)').childNodes;

        // for (let i = 0; i < thead_tr1_children.length; i++) {
        //   thead_tr1_children[i].style.width = tbody_tr1_children[i].offsetWidth + "px";
        // }
        // for (let i = 0; i < thead_tr2_children.length; i++) {
        //   thead_tr2_children[i].style.width = tbody_tr1_children[i].offsetWidth + "px";
        // }
      }
    })
  }
  document.addEventListener('DOMContentLoaded', ()=>{
    refresh();
  });
</script>
@endsection