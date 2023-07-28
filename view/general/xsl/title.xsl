<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="textElemGroupStyle.xsl"/>

  <xsl:template match="title">
    <xsl:param name="heading">h1</xsl:param>

    <xsl:choose>
      <xsl:when test="$heading = 'h1'">
        <h1><xsl:apply-templates/></h1>      
      </xsl:when>
      <xsl:otherwise>
        <span><xsl:apply-templates/></span><br/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>