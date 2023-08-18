<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="techName.xsl"/>
  <xsl:include href="infoName.xsl"/>
  <xsl:include href="infoNameVariant.xsl"/>

  <xsl:template match="dmTitle">
    <h1 class="w-100 text-center"><xsl:value-of select="techName"/>&#160;-&#160;<xsl:value-of select="infoName"/>
      <xsl:if test="infoNameVariant">
        &#160;-&#160;<xsl:value-of select="infoNameVariant"/>
      </xsl:if>
    </h1>
  </xsl:template>

</xsl:stylesheet>