<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="levelledPara.xsl"/>

  <xsl:template match="levelledParaAlts">
    <div class="levelledParaAlts"><xsl:apply-templates/></div>
  </xsl:template>
</xsl:stylesheet>