<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="dmodule">
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
      <xsl:attribute name="tr_onclick">BrdpTable.setURLHash('<xsl:value-of select="@id"/>')</xsl:attribute>
      <xsl:attribute name="td_ident_onclick">BrdpTable.openDetail('<xsl:value-of select="@brDecisionPointUniqueIdent"/>','<xsl:value-of select="./brDecision/@brDecisionIdentNumber"/>','<xsl:value-of select="@id"/>',this)</xsl:attribute>
      <ident>
        <a>
          <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
          <!-- <xsl:attribute name="onclick">openDetail('<xsl:value-of select="@brDecisionPointUniqueIdent"/>','<xsl:value-of select="./brDecision/@brDecisionIdentNumber"/>','<xsl:value-of select="@id"/>',this)</xsl:attribute> -->
          <xsl:value-of select="@brDecisionPointUniqueIdent"/>
        </a>
      </ident>
      <title>
        <xsl:value-of select="brDecisionPointContent/title"/>
      </title>
      <category>
        <xsl:value-of select="brRelatedTo/brCategoryGroup/brCategory/@brCategoryNumber"/>
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
  </xsl:template>

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