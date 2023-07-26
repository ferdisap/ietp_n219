<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="partNumber.xsl"/>
<xsl:include href="serialNumber.xsl"/>

  <xsl:template match="partAndSerialNumber">
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>