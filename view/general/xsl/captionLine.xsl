<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="acronymTerm.xsl"/>

  <xsl:template match="captionLine">
    <span>
      <xsl:attribute name="class">text-nowrap&#32;fw-bold</xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>