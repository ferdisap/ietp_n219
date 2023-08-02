<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="subOrSuperScriptElemGroupStyle.xsl"/>
<!-- Sebelum render page, lebih baik di clear kan \n\t nya agar spasi numbering tiadk kacau saat human read-->

<xsl:template match="internalRef">
  <xsl:message>Need general.css</xsl:message>
  <xsl:comment>Need general.css</xsl:comment>
  
  <!-- 
    1. .tooltip-trigger akan memanipulasi .tooltip-target ketika mouseover
    2. .tooltip-target memiliki display none saat mouse tidak di hover
    3. irtt11 (hotspot) style will be made later, karena belum terlalu paham dengan <webcgm>
    3. irtt12 (parameter) style will be made later, karena belum memerlukan

    ex. output >>> "Fig. 1 Internal Ref Text" (tanpa tooltip)
   -->

  <span>
    <!-- setting attribute class -->
    <xsl:if test="$outputView"><xsl:attribute name="class">tooltip-trigger</xsl:attribute></xsl:if>
    
    <!-- calling template irrt (FIG. 01 TABLE. 01, etc) -->
    <a><xsl:attribute name="href">#<xsl:value-of select="@internalRefId"/></xsl:attribute>
      <xsl:call-template name="irtt"/>
      
      <!-- Tooltip target view -->
      <xsl:if test="$outputView = 'electronic'">
        <span class="tooltip-target">
          <xsl:value-of select="@targetTitle"/>
        </span>
      </xsl:if>
    </a>
  </span>
</xsl:template>

<!-- get the view Prefix and Number, eg. Fig. 1, Fig. 2-->
<xsl:template name="irtt">
  <xsl:choose>
    <xsl:when test="@internalRefTargetType = 'irtt01'">
      Fig.&#160;<xsl:call-template name="getPosition">
        <xsl:with-param name="xpath" select="//figure"/>
        <xsl:with-param name="idCompared" select="@internalRefId"/>
      </xsl:call-template>&#160;
      <xsl:apply-templates/> <!-- Text inside <internalRef> -->
    </xsl:when>
    
    <xsl:when test="@internalRefTargetType = 'irtt02'">
      Table.&#160;<xsl:call-template name="getPosition">
        <xsl:with-param name="xpath" select="//table"/>
        <xsl:with-param name="idCompared" select="@internalRefId"/>
      </xsl:call-template>&#160;
      <xsl:apply-templates/> <!-- Text inside <internalRef> -->
    </xsl:when>

    <xsl:when test="@internalRefTargetType = 'irtt03'">
      Mma.&#160;<xsl:call-template name="getPosition">
        <xsl:with-param name="xpath" select="//multimedia"/>
        <xsl:with-param name="idCompared" select="@internalRefId"/>
      </xsl:call-template>&#160;
      <xsl:apply-templates/> <!-- Text inside <internalRef> -->
    </xsl:when>

    <xsl:when test="@internalRefTargetType = 'irtt04'">
      <xsl:choose>
        <xsl:when test="boolean(//supplyDesc[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//supplyDesc[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//supplyDesc[@id = @internalRefId]/name)">
          <xsl:apply-templates select="//supplyDesc[@id = @internalRefId]/name"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:when test="@internalRefTargetType = 'irtt05'">
      <xsl:choose>
        <xsl:when test="boolean(//supportEquipDescr[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//supportEquipDescr[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//supportEquipDescr[@id = @internalRefId]/name)">
          <xsl:apply-templates select="//supportEquipDescr[@id = @internalRefId]/name"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:when test="@internalRefTargetType = 'irtt06'">
      <xsl:choose>
        <xsl:when test="boolean(//spareDescr[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//spareDescr[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//spareDescr[@id = @internalRefId]/name)">
          <xsl:apply-templates select="//spareDescr[@id = @internalRefId]/name"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:when test="@internalRefTargetType = 'irtt07'">
      Para.<xsl:call-template name="getPosition">
        <xsl:with-param name="xpath" select="//levelledPara"/>
        <xsl:with-param name="idCompared" select="$refId"/>
        <xsl:with-param name="includedParent" select="'yes'"/>
        <xsl:with-param name="parentName" select="'levelledPara'"/>
      </xsl:call-template>
    </xsl:when>

    <xsl:when test="@internalRefTargetType = 'irtt08'">
      Step.&#160;<xsl:call-template name="getPosition">
        <xsl:with-param name="xpath" select="//proceduralStep"/>
      </xsl:call-template>
    </xsl:when>

    <xsl:when test="@internalRefTargetType = 'irtt09'">
      Fig.&#160;<xsl:call-template name="getPositionGraphic">
        <xsl:with-param name="xpath" select="//graphic[@id = 'gra-002']/.."/>
        <xsl:with-param name="compared" select="//graphic[@id = 'gra-002']/.."/>
      </xsl:call-template>&#160;
      <xsl:apply-templates/>
    </xsl:when>
    
    <xsl:when test="@internalRefTargetType = 'irtt10'">
      <!-- Decide Prefix Name of multimedia (3D. X....) -->
      <xsl:call-template name="multimediaTypePrefix"/>
      <!-- get the position of multimediaObject -->
      &#160;<xsl:call-template name="getPosition">
        <xsl:with-param name="xpath" select="//multimediaObject"/>
        <xsl:with-param name="idCompared" select="@internalRefId"/>
      </xsl:call-template>&#160;
      <!-- Text inside <internalRef> -->
      <xsl:apply-templates/> 
    </xsl:when>

    <xsl:when test="@internalRefTargetType = 'irtt11'">
    </xsl:when>

    <xsl:when test="@internalRefTargetType = 'irtt12'">
    </xsl:when>

    <xsl:when test="@internalRefTargetType = 'irtt13'">        
      <xsl:choose>
        <xsl:when test="boolean(//zoneRef[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//zoneRef[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//zoneRef[@id = @internalRefId]/name)">
          <xsl:apply-templates select="//zoneRef[@id = @internalRefId]/name"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:when test="@internalRefTargetType = 'irtt14'">        
      <xsl:choose>
        <xsl:when test="boolean(//workLocation[@id = @internalRefId]/workArea)">
          <xsl:apply-templates select="//workLocation[@id = @internalRefId]/workArea"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:when test="@internalRefTargetType = 'irtt15'">        
      <xsl:choose>
        <xsl:when test="boolean(//sbmaterialSet[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//sbmaterialSet[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//sbSupportEquipSet[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//sbSupportEquipSet[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//sbIndividualSupportEquip[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//sbIndividualSupportEquip[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//sbExternalSupportEquipSet[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//sbExternalSupportEquipSet[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//sbSupplySet[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//sbSupplySet[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//sbIndividualSupply[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//sbIndividualSupply[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//sbExternalSupplySet[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//sbExternalSupplySet[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//sbSpareSet[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//sbSpareSet[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//sbIndividualSpare[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//sbIndividualSpare[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//sbExternalSpareSet[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//sbExternalSpareSet[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//sbRemovedSpareSet[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//sbRemovedSpareSet[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:when test="boolean(//sbIndividualRemovedSpareSet[@id = @internalRefId]/shortName)">
          <xsl:apply-templates select="//sbIndividualRemovedSpareSet[@id = @internalRefId]/shortName"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:when test="@internalRefTargetType = 'irtt16'">        
      <xsl:choose>
        <xsl:when test="boolean(//accessPointRef[@id = @internalRefId]/name)">
          <xsl:apply-templates select="//accessPointRef[@id = @internalRefId]/name"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:otherwise>
      <xsl:comment>ERROR: the attribute <xsl:value-of select="@internalRefTargetType"/>&#160; doesn't exist.</xsl:comment>
        <xsl:message>ERROR: the attribute <xsl:value-of select="@internalRefTargetType"/>&#160; doesn't exist.</xsl:message>
    </xsl:otherwise>
  </xsl:choose>    
</xsl:template>


<!-- TEMPLATE Helper, lihat demo5.xml/demo5.xsl -->
<!-- TEMPLATE Helper, lihat demo5.xml/demo5.xsl -->
<!-- TEMPLATE Helper, lihat demo5.xml/demo5.xsl -->
<!-- TEMPLATE Helper, lihat demo5.xml/demo5.xsl -->
<!-- TEMPLATE Helper, lihat demo5.xml/demo5.xsl -->
<!-- TEMPLATE Helper, lihat demo5.xml/demo5.xsl -->

<xsl:template name="multimediaTypePrefix">
  <xsl:choose>
    <xsl:when test="//multimediaObject/@multimediaType = '3D'">3D.</xsl:when>
    <xsl:when test="//multimediaObject/@multimediaType = 'audio'">Audio.</xsl:when>
    <xsl:when test="//multimediaObject/@multimediaType = 'video'">Video.</xsl:when>
    <xsl:otherwise>Any.</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Refer to demo5.xsl/demo5.xml 02 -->
<xsl:template name="getPosition">
  <xsl:param name="xpath"/>
  <xsl:param name="idCompared"/>
  <xsl:param name="includedParent" select="no"/>
  <xsl:param name="parentName" select="'levelledPara'"/>
  <xsl:for-each select="$xpath">
    <xsl:if test="@id = $idCompared">
      <xsl:if test="$includedParent = 'yes'">
        <xsl:call-template name="checkParent"><xsl:with-param name="parentName" select="$parentName"/></xsl:call-template>
      </xsl:if><xsl:number/>
    </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template name="checkParent">
  <xsl:param name="parentName" select="'levelledPara'"/>
  <xsl:if test="name(parent::*) = $parentName">
    <xsl:call-template name="getParentPosition">
      <xsl:with-param name="parentName" select="$parentName"/>
    </xsl:call-template>.
  </xsl:if>
</xsl:template>

<xsl:template name="getParentPosition">
  <xsl:param name="compared" select=".."/>
  <xsl:param name="parentName" select="'levelledPara'"/>
  <xsl:if test="$parentName = 'levelledPara'">
    <xsl:for-each select="../../levelledPara">
      <xsl:if test=". = $compared">
        <xsl:call-template name="checkParent">
          <xsl:with-param name="parentName" select="$parentName"/>
        </xsl:call-template><xsl:number/>
      </xsl:if>
    </xsl:for-each>
  </xsl:if>
</xsl:template>
<!-- end of Refer to demo5.xsl/demo5.xml 02 -->

<!-- Refer to demo5.xsl/demo5.xml 03 -->
<xsl:template name="getPositionGraphic">
  <xsl:param name="xpath"/>
  <xsl:param name="compared"/>
  Fig.&#160;<xsl:for-each select="$xpath">
    <xsl:if test=". = $compared">
      <xsl:number/>&#160;sheet&#160;<xsl:call-template name="getPosition">
        <xsl:with-param name="xpath" select="//graphic"/>
        <xsl:with-param name="idCompared" select="'gra-002'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>
</xsl:template>
<!-- end of Refer to demo5.xsl/demo5.xml 03 -->

</xsl:stylesheet>