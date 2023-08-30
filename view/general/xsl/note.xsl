<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="symbol.xsl"/>
  <xsl:include href="notePara.xsl"/> 
  <xsl:include href="attentionSequentialList.xsl"/> 
  <xsl:include href="attentionRandomList.xsl"/> 

  <!-- berhasil, cek demo11 -->
  <xsl:template match="note">
    <div class="d-flex justify-content-center">
      <div class="note">
        <div class="heading"><span>NOTE</span></div>
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>