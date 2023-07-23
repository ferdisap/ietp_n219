<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="brPara">
    <tr>
      <xsl:attribute name="no"><xsl:number/></xsl:attribute>
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
      <xsl:attribute name="onclick">BrdpTable.openDetail('<xsl:value-of select="@brDecisionPointUniqueIdent"/>','<xsl:value-of select="./brDecision/@brDecisionIdentNumber"/>','<xsl:value-of select="@id"/>',this)</xsl:attribute>
      <td>
        <a>
          <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
          <xsl:value-of select="@brDecisionPointUniqueIdent"/>
        </a>
      </td>
      <td><xsl:value-of select="brDecisionPointContent/title"/></td>
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

</xsl:stylesheet>