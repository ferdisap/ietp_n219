<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="symbol.xsl"/>
<xsl:include href="warningAndCautionPara.xsl"/>

<!-- berhasil, cek demo11 -->
<xsl:template match="warning">
  <div class="d-flex justify-content-center">
    <div class="warning">
      <div class="heading"><span>WARNING</span></div>
      <xsl:apply-templates/>
    </div>
  </div>
</xsl:template>

</xsl:stylesheet>