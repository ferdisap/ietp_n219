<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <div>
      <div class="container-lg mt-3" style="width:90%; height:75vh; overflow:auto">
        <table id="brdpList-table">
            <thead>
              <tr>
                <th>Ident</th>
                <th>Title</th>
                <th>Category</th>
                <th>Audit</th>
                <th>Decision</th>
              </tr>
              <tr>
                <td>
                  <div class="input-group">
                    <input type="number" class="filterSort input-group-text p-0" style="width: 30px" for="ident" id="" max="5" min="1" value="1"/>
                    <input type="text" class="form-control" filterBy="ident" placeholder="search ident.." onkeypress="Brdp.BrSearch.listener(this,event)"/>
                  </div>
                </td>
                <td>
                  <div class="input-group">
                    <input type="number" class="filterSort input-group-text p-0" style="width: 30px" for="title" id="" max="5" min="1" value="2"/>
                    <input type="text" class="form-control" filterBy="title" placeholder="search title.." onkeypress="Brdp.BrSearch.listener(this,event)"/>
                  </div>
                </td>
                <td>
                  <div class="input-group">
                    <input type="number" class="filterSort input-group-text p-0" style="width: 30px" for="category" id="" max="5" min="1" value="3"/>
                    <input type="text" class="form-control" filterBy="category" placeholder="search category.." onkeypress="Brdp.BrSearch.listener(this,event)"/>
                  </div>
                </td>
                <td>
                  <div class="input-group">
                    <input type="number" class="filterSort input-group-text p-0" style="width: 30px" for="audit" id="" max="5" min="1" value="4"/>
                    <input type="text" class="form-control" filterBy="audit" placeholder="search audit.." onkeypress="Brdp.BrSearch.listener(this,event)"/>
                  </div>
                </td>
                <td>
                  <div class="input-group">
                    <input type="number" class="filterSort input-group-text p-0" style="width: 30px" for="decision" id="" max="5" min="1" value="5"/>
                    <input type="text" class="form-control" filterBy="decision" placeholder="search decision.." onkeypress="Brdp.BrSearch.listener(this,event)"/>
                  </div>
                </td>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="//content/brDoc/brLevelledPara">
                <xsl:apply-templates/>
              </xsl:for-each>
            </tbody>       
        </table>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="brPara">
    <tr>
      <xsl:attribute name="onmouseover">Brdp.BrDetail.changeBgColor(this)</xsl:attribute>
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
      <xsl:attribute name="onclick">Brdp.BrDetail.openDetail('<xsl:value-of select="@brDecisionPointUniqueIdent"/>','<xsl:value-of select="./brDecision/@brDecisionIdentNumber"/>','<xsl:value-of select="@id"/>',this)</xsl:attribute>
      <td>
          <a>
            <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
            <xsl:value-of select="@brDecisionPointUniqueIdent"/>
          </a>
      </td>
      <td>
        <xsl:value-of select="brDecisionPointContent/title"/>
      </td>
      <td>
        <xsl:for-each select="brRelatedTo/brCategoryGroup/brCategory">
          <xsl:value-of select="@brCategoryNumber"/>,&#160;
        </xsl:for-each>
      </td>
      <td>none</td>
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

  <!-- <xsl:template match="dmodule">
    <xsl:apply-templates select="content"/>
  </xsl:template>

  <xsl:template match="content">
    <lists>
      <xsl:for-each select="brDoc/brLevelledPara">
        <xsl:apply-templates/>
      </xsl:for-each>
    </lists>
  </xsl:template>

  <xsl:template match="brPara">
    <list>
      <xsl:attribute name="no"><xsl:number/></xsl:attribute>
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
      <xsl:attribute name="tr_onclick">BrdpTable.openDetail('<xsl:value-of select="@brDecisionPointUniqueIdent"/>','<xsl:value-of select="./brDecision/@brDecisionIdentNumber"/>','<xsl:value-of select="@id"/>',this)</xsl:attribute>
      <ident>
        <a>
          <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
          <xsl:value-of select="@brDecisionPointUniqueIdent"/>
        </a>
      </ident>
      <title>
        <xsl:value-of select="brDecisionPointContent/title"/>
      </title>
      <category>
        <xsl:for-each select="brRelatedTo/brCategoryGroup/brCategory">
          <xsl:value-of select="@brCategoryNumber"/>,&#160;
        </xsl:for-each>
      </category>
      <audit>none</audit>
      <decision>
        <xsl:apply-templates select="brDecision"/>
      </decision>
    </list>
  </xsl:template>

  <xsl:template match="brDecision">
    <xsl:if test="not(descendant::brDecisionPending)">
      <span><xsl:value-of select="@brDecisionIdentNumber"/></span>
    </xsl:if>
    <xsl:if test="boolean(descendant::brDecisionPending)">
      <span style="color:red">PENDING - </span><br/>
      <span><xsl:value-of select="@brDecisionIdentNumber"/></span>
    </xsl:if>
  </xsl:template> -->

  <!-- textElemGroupStyle -->
  <!-- <xsl:template match="para">
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
  </xsl:template> -->
  <!-- end of textElemGroupStyle -->

</xsl:stylesheet>