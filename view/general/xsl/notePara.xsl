<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="attentionSequentialList.xsl"/> 
  <xsl:include href="attentionRandomList.xsl"/> 

  <xsl:template match="notePara">
    <xsl:apply-templates />
  </xsl:template>

</xsl:stylesheet>