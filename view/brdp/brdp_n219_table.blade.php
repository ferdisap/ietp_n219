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
</header>

<article id="BrList"></article>
@endsection

@section('scripts_onBottom')
<script src="/?utility=getfile&ct=javascript&path=assets/general/js/createXML.js"></script>
<script src="/?utility=getfile&ct=javascript&path=assets/general/js/AllStyle.js"></script>
<script src="/?utility=getfile&ct=javascript&path=assets/brdp/js/Brdp2.js"></script>
@endsection