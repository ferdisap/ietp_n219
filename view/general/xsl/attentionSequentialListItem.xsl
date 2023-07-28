<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="attentionListItemPara.xsl"/>
  <xsl:include href="attentionRandomList.xsl"/> 

  <xsl:template match="attentionSequentialListItem">
    <li>
      <xsl:apply-templates />
    </li>
  </xsl:template>

</xsl:stylesheet>