<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="textElemGroupStyle.xsl"/>

  <xsl:template match="emphasis">
    <xsl:value-of select="@emphasisType"/>
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>