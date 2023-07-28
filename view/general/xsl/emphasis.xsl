<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="textElemGroupStyle.xsl"/>

  <!-- <xsl:template match="emphasis">
    <xsl:value-of select="@emphasisType"/>
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template> -->

  <!-- need Bootstrap class -->
  <xsl:template match="emphasis">
    <xsl:choose>
      <xsl:when test="@emphasisType = 'em01'">
        <span class="fw-bold">&#60;<xsl:apply-templates/>&#62;</span>
      </xsl:when>
      <xsl:when test="@emphasisType = 'em02'">
        <span class="fst-italic">@<xsl:apply-templates/></span>
      </xsl:when>
      <xsl:when test="@emphasisType = 'em03'">
        <span class="text-decoration-underline">value</span>
      </xsl:when>
      <xsl:when test="@emphasisType = 'em05'">
        <span class="text-decoration-underline">value</span>
      </xsl:when>
      <xsl:otherwise>
        <span><xsl:apply-templates/></span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>