<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="warningRef.xsl"/>
<xsl:include href="cautionRef.xsl"/>

<!-- berhasil, cek demo11 -->
<xsl:template match="warningAndCautionRef"><xsl:apply-templates/></xsl:template>

</xsl:stylesheet>