<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="attentionSequentialList.xsl"/> 
  <xsl:include href="attentionRandomList.xsl"/> 

  <!-- cek demo11 -->
  <xsl:template match="notePara">
    <p class="text-start"><xsl:apply-templates/></p>
  </xsl:template>

</xsl:stylesheet>