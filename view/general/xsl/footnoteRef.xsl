<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="custom_asterisk.xsl"/>

  <xsl:template match="footnoteRef">
    <xsl:param name="internalRefId"><xsl:value-of select="@internalRefId"/></xsl:param>
    <xsl:variable name="footnoteMark"><xsl:value-of select="//footnote[@id = $internalRefId]/@footnoteMark"/></xsl:variable>
    <sup>
      <xsl:for-each select="//footnote[@footnoteMark = $footnoteMark]">
        <xsl:if test="@id = $internalRefId">
          <xsl:call-template name="asterisk">
            <xsl:with-param name="pos"><xsl:value-of select="position()"/></xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
    </sup>
  </xsl:template>

</xsl:stylesheet>