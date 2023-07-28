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
      <div id="tes">
        <xsl:apply-templates select="//dmStatus/security"/>
      </div>
    </div>
  </xsl:template>

  <!-- <xsl:template match="security">
      <span>FOO</span>
  </xsl:template> -->
  
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
      <td><xsl:apply-templates select="brAudit/brCurrentStatus"/></td>
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

  <xsl:template match="brCurrentStatus">
    <xsl:choose>
      <xsl:when test="@brStatus = 'brst01'"><span class="fw-bold text-warning">Unverified</span></xsl:when>
      <xsl:when test="@brStatus = 'brst02'"><span class="text-success">First verification</span></xsl:when>
      <xsl:when test="@brStatus = 'brst03'"><span class="text-success">Second verification</span></xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>