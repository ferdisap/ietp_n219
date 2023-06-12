<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="brDoc.xsl" />

<!-- IMPORT VS INCLUDE -->
<!-- <xsl:include> allows you to include one stylesheet into another. The included stylesheet's templates will have the same default priorities and import precedence as the including stylesheet. <xsl:import> offers the same, but the import precedence of elements in an imported stylesheet is always less than that of the importing stylesheet. -->
<xsl:template match="/dmodule">
  <xsl:apply-imports/>
</xsl:template>
</xsl:stylesheet>