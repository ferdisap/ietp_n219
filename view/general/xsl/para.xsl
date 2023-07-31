<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="textElemGroupStyle.xsl"/>

  <xsl:template match="para">
    <xsl:choose>
      <xsl:when test="name(parent::*) = 'listItem'">
        <span>
          <xsl:apply-templates/>
        </span> 
      </xsl:when>
      <xsl:when test="name(child::*) = 'randomList'">
        <p class="mb-0">
          <xsl:apply-templates/>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>