<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="enterpriseName.xsl"/>

  <xsl:template match="responsiblePartnerCompany">
    <xsl:value-of select="@enterpriseCode"/>
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>