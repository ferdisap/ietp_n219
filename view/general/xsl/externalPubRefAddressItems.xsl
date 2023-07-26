<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="externalPubIssueDate.xsl"/>
<xsl:include href="security.xsl"/>
<xsl:include href="responsiblePartnerCompany.xsl"/>
<xsl:include href="pubMedia.xsl"/>
<xsl:include href="shortExternalPubTitle.xsl"/>

  <xsl:template match="externalPubRefAddressItems">
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>