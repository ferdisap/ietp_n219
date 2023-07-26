<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="title">
    <h1><xsl:apply-templates/></h1>
  </xsl:template>

</xsl:stylesheet>