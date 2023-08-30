<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="dmRef.xsl"/>

<xsl:param name="warningRepository_path"/>

<xsl:template match="warningRef">
  <xsl:param name="warningIdentNumber" select="@warningIdentNumber"/>
  <xsl:variable name="warningSpec" select="document($warningRepository_path)//warningRepository/warningSpec[warningIdent/@warningIdentNumber = $warningIdentNumber]"/>
  <!-- <xsl:variable name="warningSpec" select="document('/ietp_n219/view/general/test/comrep.xml')//warningRepository/warningSpec[warningIdent/@warningIdentNumber = $warningIdentNumber]"/> -->
  <!-- <xsl:variable name="warningSpec" select="document('comrep.xml')//warningAndCautionPara"/> -->
  <xsl:apply-templates select="dmRef"/>
  <xsl:apply-templates select="$warningSpec"/>
</xsl:template>

<xsl:template match="warningSpec">
  <div class="d-flex justify-content-center">
    <div class="warning">
      <div class="heading"><span id="{warningIdent/@warningIdentNumber}">WARNING</span></div>
      <xsl:apply-templates select="child::*[name() != 'warningIdent']"/>
    </div>
  </div>
</xsl:template>

</xsl:stylesheet>