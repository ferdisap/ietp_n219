<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/str" extension-element-prefixes="str">

<!-- need bootstrap css-->
<!-- need crew.css -->
  <xsl:template match="content">
    <div class="content">
      <link rel="stylesheet" href="/ietp_n219/view/general/css/general.css"/>
      <!-- <xsl:apply-templates select="//warning"/>
      <xsl:apply-templates select="//caution"/>
      <xsl:apply-templates select="//note"/> -->
      
      <xsl:apply-templates select="//warningsAndCautionsRef"/>
    </div>
  </xsl:template>

  <xsl:template match="warning">
    <div class="d-flex justify-content-center">
      <div class="warning">
        <div class="heading"><span>WARNING</span></div>
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="caution">
    <div class="d-flex justify-content-center">
      <div class="caution">
        <div class="heading"><span>CAUTION</span></div>
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="note">
    <div class="d-flex justify-content-center">
      <div class="note">
        <div class="heading"><span>NOTE</span></div>
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="warningAndCautionPara">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="notePara">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="warningAndCautionRef">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- <xsl:param name="warn" select="'warn-001'"/> -->
  <!-- <xsl:param name="warn"/> -->
  <xsl:param name="warningRepository_path"/>
  <xsl:template match="warningRef">
    <xsl:param name="warningIdentNumber" select="@warningIdentNumber"/>
    <xsl:variable name="warningSpec" select="document($warningRepository_path)//warningRepository/warningSpec[warningIdent/@warningIdentNumber = $warningIdentNumber]"/>
    <!-- <xsl:variable name="warningSpec" select="document('/ietp_n219/view/general/test/comrep.xml')//warningRepository/warningSpec[warningIdent/@warningIdentNumber = $warningIdentNumber]"/> -->
    <!-- <xsl:variable name="warningSpec" select="document('comrep.xml')//warningAndCautionPara"/> -->
    <xsl:apply-templates select="dmRef"/>
    <xsl:apply-templates select="$warningSpec"/>
  </xsl:template>

  <xsl:param name="cautionRepository_path"/>
  <xsl:template match="cautionRef">
    <xsl:param name="cautionIdentNumber" select="@cautionIdentNumber"/>
    <xsl:variable name="cautionSpec" select="document($cautionRepository_path)//cautionRepository/cautionSpec[cautionIdent/@cautionIdentNumber = $cautionIdentNumber]"/>
    <!-- <xsl:variable name="cautionSpec" select="document('/ietp_n219/view/general/test/comrep.xml')//cautionRepository/cautionSpec[cautionIdent/@cautionIdentNumber = $cautionIdentNumber]"/> -->
    <!-- <xsl:variable name="cautionSpec" select="document('comrep.xml')//warningAndCautionPara"/> -->
    <xsl:apply-templates select="dmRef"/>
    <xsl:apply-templates select="$cautionSpec"/>
  </xsl:template>
  
  <xsl:template match="warningSpec">
    <div class="d-flex justify-content-center">
      <div class="warning">
        <div class="heading"><span id="{warningIdent/@warningIdentNumber}">WARNING</span></div>
        <xsl:apply-templates select="child::*[name() != 'warningIdent']"/>
      </div>
    </div>
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