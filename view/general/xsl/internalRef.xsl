<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="subOrSuperScriptElemGroupStyle.xsl"/>

  <xsl:template match="internalRef">
    <xsl:value-of select="@internalRefTargetType"/>
    <xsl:value-of select="@referredFragment"/>
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>