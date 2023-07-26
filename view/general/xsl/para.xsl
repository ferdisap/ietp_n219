<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="textElemGroupStyle.xsl"/>

  <!-- <xsl:template match="para">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template> -->  

  <!-- <xsl:template match="emphasis">
    <div style="margin-left:20px;">
      <xsl:apply-templates />
    </div>
  </xsl:template> -->

  <!-- <xsl:template match="randomList">
    <ul>
      <xsl:for-each select="listItem">
        <li>
          <xsl:apply-templates />
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="sequentialList">
    <ol>
      <xsl:for-each select="listItem">
        <li>
          <xsl:apply-templates />
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template>

  <xsl:template match="listItem">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:include href="commonConstruct/referencing/dmRef.xsl" /> -->
</xsl:stylesheet>