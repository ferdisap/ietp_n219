<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="brDecisionText.xsl" />

<xsl:template match="dmodule">
  <html> 
    <head>
      <!-- <link rel="stylesheet" href="../../style/css/main.css"/> -->
      <script src="assets/js/brDoc_search.js"></script>
      <link rel="stylesheet" href="style/css/brList.css"/>
    </head>
    <body onload="alert('foo')">

      <img style="width:30%;position:absolute;right:2%;top:1em;" src="assets/others/n219_logo.png" alt=""/>
      <h2>
        <xsl:value-of select="identAndStatusSection/dmAddress/dmAddressItems/dmTitle/techName"/> &#160; - &#160;
        <xsl:value-of select="identAndStatusSection/dmAddress/dmAddressItems/dmTitle/infoName"/></h2>
      <div>
        <form action="" method="get" id="form-search">
          <input placeholder="search here.." /><button type="button" id="btn-search" onclick="Search.search(event.target.previousElementSibling.value)">Search</button><br/>
          <!-- <input placeholder="search here.." /><button type="button" onclick="event.preventDefault;Search.search(event.target.previousElementSibling.value)">Search</button><br/> -->

          <input type="radio" name="filterBy" id="all" value="all" checked="checked" onchange="Search.filterBy = event.target.value"/>
          <label for="all">all</label>

          <input type="radio" name="filterBy" id="ident" value="ident" onchange="Search.filterBy = event.target.value"/>
          <label for="ident">ident</label>

          <input type="radio" name="filterBy" id="title" value="title" onchange="Search.filterBy = event.target.value"/>
          <label for="title">title</label>

          <input type="radio" name="filterBy" id="definition" value="definition" onchange="Search.filterBy = event.target.value"/>
          <label for="definition">definition</label>

          <input type="radio" name="filterBy" id="category" value="category" onchange="Search.filterBy = event.target.value"/>
          <label for="category">category</label>

          <input type="radio" name="filterBy" id="decision" value="decision" onchange="Search.filterBy = event.target.value"/>
          <label for="decision">decision</label>

        </form>

      </div>
      <br/>
      <div>
        <span id="search-result"></span><br/>
        <table border="1">
          <thead>
            <tr bgcolor="#9acd32">
              <th class="no">No.</th>
              <th>Ident</th>
              <th>Title</th>
              <th>Category</th>
              <th>Decision</th>
            </tr>
          </thead>
          <tbody>
            <xsl:apply-templates select="content"/>
          </tbody>
        </table>
      </div>
    </body>
  </html>
</xsl:template>

<xsl:template match="content">
  <xsl:for-each select="brDoc/brLevelledPara">
    <xsl:apply-templates/>
  </xsl:for-each>
</xsl:template>

<xsl:template match="brPara">
  <tr>
    <xsl:attribute name="id">
      <xsl:value-of select="@id"/>
    </xsl:attribute>
    <xsl:attribute name="onclick">setURLHash('<xsl:value-of select="@id"/>')</xsl:attribute>

    <!-- table body -->
    <td><xsl:number/></td>
    <td><a>
        <xsl:attribute name="href">javascript:openDetail('<xsl:value-of select="@brDecisionPointUniqueIdent"/>','<xsl:value-of select="./brDecision/@brDecisionIdentNumber"/>','<xsl:value-of select="@id"/>')</xsl:attribute>
        <xsl:value-of select="@brDecisionPointUniqueIdent"/></a>
    </td>
    <td><xsl:value-of select="brDecisionPointContent/title"/></td>
    <!-- <td><xsl:value-of select="brRelatedTo/brCategoryGroup/brCategory/@brCategoryNumber"/> - <xsl:value-of select="brRelatedTo/brCategoryGroup/brCategory/title"/></td> -->
    <td>
        <xsl:for-each select="brRelatedTo/brCategoryGroup/brCategory">
          <xsl:value-of select="@brCategoryNumber"/>,&#160;
        </xsl:for-each>
    </td>
    <td><xsl:apply-templates select="brDecision"/></td>
  </tr>
</xsl:template>

<xsl:template match="brDecision">
  <xsl:if test="not(descendant::brDecisionPending)">
    <span><xsl:value-of select="@brDecisionIdentNumber"/></span>
  </xsl:if>
  <xsl:if test="boolean(descendant::brDecisionPending)">
    <span style="color:red">PENDING - </span><br/>
    <span><xsl:value-of select="@brDecisionIdentNumber"/></span>
  </xsl:if>
</xsl:template>

  <!-- textElemGroupStyle -->
 <xsl:template match="para">
    <p>
      <xsl:apply-templates>
        <xsl:with-param name="isShowDmCode" select="'yes'"/>
        <xsl:with-param name="isShowDmCode">YES</xsl:with-param>
      </xsl:apply-templates>
    </p>
  </xsl:template>

  <xsl:template match="randomList">
    <ul>
      <xsl:for-each select="listItem">
        <li>
          <xsl:apply-templates />
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="sequentialList">
    <ol>
      <xsl:for-each select="listItem">
        <li>
          <xsl:apply-templates />
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template>

  <xsl:template match="listItem">
    <xsl:apply-templates />
  </xsl:template>
  <!-- end of textElemGroupStyle -->

</xsl:stylesheet>