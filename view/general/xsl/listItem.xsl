<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="note.xsl"/>
  <xsl:include href="para.xsl"/> 

  <xsl:template match="listItem">
    <li>
      <xsl:apply-templates />
    </li>
  </xsl:template>

</xsl:stylesheet>