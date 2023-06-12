<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
  <!-- <html> -->
    <!-- <body> -->
      <!-- <p>TES</p> -->
      <book>
        <xsl:call-template name="book">
          <xsl:with-param name="name" select="'nama bukunya adalah XXX'"/>
        </xsl:call-template>
      </book>
    <!-- </body> -->
  <!-- </html> -->
  </xsl:template>

  <xsl:template name="book">
    <xsl:param name="name"/>
    <!-- <nameBook><xsl:value-of select="$name_book"/>  foo</nameBook> -->
    <!-- <p><xsl:value-of select="$name"/> - foo</p> -->
    <name><xsl:value-of select="$name"/> - foo</name>
    <name><xsl:value-of select="$name"/> - bar</name>
  </xsl:template>
</xsl:stylesheet>