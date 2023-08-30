<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="subScript.xsl"/> 
  <xsl:include href="superScript.xsl"/> 

  <xsl:template match="simplePara">
    <span><xsl:apply-templates/></span><br/>
  </xsl:template>

</xsl:stylesheet>