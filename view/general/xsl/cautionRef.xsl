<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="dmRef.xsl"/>

<xsl:param name="cautionRepository_path"/>

<xsl:template match="cautionRef">
  <xsl:param name="cautionIdentNumber" select="@cautionIdentNumber"/>
  <xsl:variable name="cautionSpec" select="document($cautionRepository_path)//cautionRepository/cautionSpec[cautionIdent/@cautionIdentNumber = $cautionIdentNumber]"/>
  <!-- <xsl:variable name="cautionSpec" select="document('/ietp_n219/view/general/test/comrep.xml')//cautionRepository/cautionSpec[cautionIdent/@cautionIdentNumber = $cautionIdentNumber]"/> -->
  <!-- <xsl:variable name="cautionSpec" select="document('comrep.xml')//warningAndCautionPara"/> -->
  <xsl:apply-templates select="dmRef"/>
  <xsl:apply-templates select="$cautionSpec"/>
</xsl:template>

<xsl:template match="cautionSpec">
  <div class="d-flex justify-content-center">
    <div class="caution">
      <div class="heading"><span id="{cautionIdent/@cautionIdentNumber}">CAUTION</span></div>
      <xsl:apply-templates select="child::*[name() != 'cautionIdent']"/>
    </div>
  </div>
</xsl:template>

</xsl:stylesheet>