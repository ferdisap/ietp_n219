<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="/css/bootstrap_5.2.0.min.css">
  <title>Tes XSL</title>
  <style>
    table {
      border-collapse: collapse;
      letter-spacing: 1px;
      font-size: 0.8rem;
      height: inherit;
      width: 1000px;
    }

    thead {
      display: block;
    }

    tbody {
      display: block;
      width: inherit;
      overflow: auto;
      height: inherit;
    }

    tbody th, tbody td:last-child {
      white-space: nowrap;
    }

    td, th {
      border: 1px solid rgb(190, 190, 190);
      padding-left: 10px;
      padding-right: 10px;
      padding-top: 5px;
      padding-bottom: 5px;
    }

    .bg-green {
        background-color: green !important;
      }
      .bg-amber {
        background-color: #FFC107;
      }
      .bg-yellow {
        background-color: yellow;
      }
      .bg-red {
        background-color: red;
      }
      .bg-white {
        background-color: white;
      }
      .bg-grey {
        background-color: grey;
      }
      .bg-black {
        background-color: black;
      }      
      .bg-yellow-txt-black {
        background-color: yellow !important;
        color: black !important;
      }
      .bg-red-txt-black {
        background-color: red !important;
        color: black !important;
      }
      .bg-red-txt-white {
        background-color: red !important;
        color: white !important;
      }
      .bg-black-txt-yellow {
        background-color: black !important;
        color: yellow !important;
      }
      .bg-black-txt-white {
        background-color: black !important;
        color: white !important;
      }
      .bg-black-txt-red {
        background-color: black !important;
        color: red !important;
      }
      .bg-black-txt-green {
        background-color: black !important;
        color: green !important;
      }
      .bg-black-txt-amber {
        background-color: black !important;
        color:  var(--custom-color-amber1-)!important;
      }

      .top-25 {
        top: 25% !important;
      }
      .start-15 {
        left: 15% !important;
      }



  </style>
</head>
<body>
  <div id="container"></div>
  
  <script src="/?utility=getfile&ct=javascript&path=view/general/test/tesxsl.js"></script>
  <script src="/?utility=getfile&ct=javascript&path=assets/general/js/createXML.js"></script>
</body>
</html>