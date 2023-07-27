<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="../textElemGroupStyle.xml" />
<xsl:include href="../commonConstruct/referencing/dmRef.xsl" />

  <xsl:template match="brPara">
    <html>
      <head>
        <link rel="stylesheet" href="style/css/brDetail.css"/>
        <script src="../../../../../assets/brdp/js/brDetail.js"></script>
      </head>
      <body>
      <div>
        <img src="../../../../../assets/brdp/others/close_btn.png" id="close-detail" onclick="closeDetail()"/>
        <!-- BR Decision Value-->
        <xsl:apply-templates select="//brDecision"/>

        <!-- BR Detail Container -->
        <div id="brPara" onclick="changeZIndex(this)">
          <!-- <xsl:attribute name="id"> <xsl:value-of select="@id" /> </xsl:attribute> -->
          
          <h1><xsl:value-of select="@brDecisionPointUniqueIdent"/></h1>
          <h4><xsl:value-of select="//brDecisionPointContent/title"/></h4>
          <hr/>

          <!-- brDecision Related to -->
          <div class="related_to">
            <h4 class="bold my-0">Business rule decision point is related to:</h4><br/>

            <!-- place in spesification -->
            <span class="bold">Place in specification:</span>
            <p class="mt-0">
              <span class="bold">
              <xsl:apply-templates select="//brRelatedTo//dmCode" />
              <!-- <xsl:value-of select="//brRelatedTo//dmCode/@modelIdentCode"/>-<xsl:value-of select="//brRelatedTo//dmCode/@systemDiffCode"/>-<xsl:value-of select="//brRelatedTo//dmCode/@systemCode"/>-<xsl:value-of select="//brRelatedTo//dmCode/@subSystemCode"/><xsl:value-of select="//brRelatedTo//dmCode/@subSubSystemCode"/>-<xsl:value-of select="//brRelatedTo//dmCode/@assyCode"/>-<xsl:value-of select="//brRelatedTo//dmCode/@disassyCode"/><xsl:value-of select="//brRelatedTo//dmCode/@disassyCodeVariant"/>-<xsl:value-of select="//brRelatedTo//dmCode/@infoCode"/><xsl:value-of select="//brRelatedTo//dmCode/@infoCodeVariant"/>-<xsl:value-of select="//brRelatedTo//dmCode/@itemLocationCode"/> -->
              </span>
              &#160; <xsl:value-of select="//brRelatedTo//dmRef/@referredFragment"/>
            </p>

            <!-- business rule category -->
            <span class="bold">Business rule category:</span>
            <p class="mt-0">
              <span class="bold">
              <xsl:value-of select="//brRelatedTo//brCategory/@brCategoryNumber" />
              </span>
              &#160; <xsl:value-of select="//brRelatedTo//brCategory/title"/>
            </p>
            <apply-templates select="//brRelatedTo//brCategory/brCategoryDescription"/>

             <!-- Related S1000D XML Schemas -->
             <span class="bold">Business rule applicability schema:</span><br/>
             <xsl:apply-templates select="//brRelatedTo//s1000dSchemas"/>

             <!-- Decision Point Content -->
             <span class="bold">Business rule decision point content: - 
              <xsl:value-of select="//brDecisionPointContent/title"/>
             </span>
             <br/>
             <!-- <xsl:apply-templates select="//brDecisionPointContent/brDecisionPointText"/> -->
             <xsl:apply-templates select="//brDecisionPointContent/brDecisionPointText">
                <xsl:with-param name="isShowDmCode" select="'foobar'"/>
             </xsl:apply-templates>
             <br/>
             <xsl:apply-templates select="//brDecisionPointContent/brDecisionPointValueGroup"/>
          </div>          
        </div>
      </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="brDecisionPointValueGroup">
    <span class="bold">Values allowed: &#160;</span>You may select <span class="bold"><xsl:value-of select="@brDecisionValueSelection"/></span> value.
    <br/><br/>
    <xsl:for-each select="brDecisionPointValue">
      <span class="bold">Value allowed: &#160;</span><xsl:value-of select="@brDecisionValueAllowed"/>
      <xsl:apply-templates/>
      <br></br>
    </xsl:for-each>
      
  </xsl:template>

  <xsl:template match="s1000dSchemas"> 
    <ul>
      <xsl:for-each select="@*[.=1]">
        <xsl:choose>
          <xsl:when test="name()='appliccrossreftableXsd'">
              <li>Applicable Cross Reference Table</li>
          </xsl:when>
          <xsl:when test="name()='brDocXsd'">
              <li>Business rule data module</li>
          </xsl:when>
          <xsl:when test="name()='brexXsd'">
              <li>Business rule exchange index</li>
          </xsl:when>
          <xsl:when test="name()='checklistXsd'">
              <li>Crew checklist</li>
          </xsl:when>
          <xsl:when test="name()='commentXsd'">
              <li>Comment</li>
          </xsl:when>
          <xsl:when test="name()='comrepXsd'">
              <li>Common information repository</li>
          </xsl:when>
          <xsl:when test="name()='condcrossreftableXsd'">
              <li>Applicability conditions cross reference table</li>
          </xsl:when>
          <xsl:when test="name()='containerXsd'">
              <li>Container</li>
          </xsl:when>
          <xsl:when test="name()='crewXsd'">
              <li>Crew</li>
          </xsl:when>
          <xsl:when test="name()='ddnXsd'">
              <li>Data dispatch note</li>
          </xsl:when>
          <xsl:when test="name()='descriptXsd'">
              <li>Descriptive</li>
          </xsl:when>
          <xsl:when test="name()='dmlXsd'">
              <li>Data management list</li>
          </xsl:when>
          <xsl:when test="name()='faultXsd'">
              <li>Fault</li>
          </xsl:when>
          <xsl:when test="name()='frontmatterXsd'">
              <li>Front matter</li>
          </xsl:when>
          <xsl:when test="name()='icnMetadataXsd'">
              <li>ICN metadata</li>
          </xsl:when>
          <xsl:when test="name()='ipdXsd'">
              <li>IPD data module</li>
          </xsl:when>
          <xsl:when test="name()='learningXsd'">
              <li>Learning data module</li>
          </xsl:when>
          <xsl:when test="name()='pmXsd'">
              <li>Pulication module</li>
          </xsl:when>
          <xsl:when test="name()='prdcrossreftableXsd'">
              <li>Product crossreference table data module</li>
          </xsl:when>
          <xsl:when test="name()='procedXsd'">
              <li>Procedural data module</li>
          </xsl:when>
          <xsl:when test="name()='processXsd'">
              <li>Process data module</li>
          </xsl:when>
          <xsl:when test="name()='sbXsd'">
              <li>Service bulletin data module</li>
          </xsl:when>
          <xsl:when test="name()='schedulXsd'">
              <li>Maintenance planning data module</li>
          </xsl:when>
          <xsl:when test="name()='scocontentXsd'">
              <li>SCO content data module</li>
          </xsl:when>
          <xsl:when test="name()='scormcontentpackageXsd'">
              <li>SCORM</li>
          </xsl:when>
          <xsl:when test="name()='updateXsd'">
              <li>Update file Schema</li>
          </xsl:when>
          <xsl:when test="name()='wrngdataXsd'">
              <li>Wiring data module</li>
          </xsl:when>
          <xsl:when test="name()='wrngfldsXsd'">
              <li>Wiring fields data module</li>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each> 
    </ul>  
  </xsl:template>

  <xsl:template match="brDecisionPointValue">
    <p>Value allowed: <xsl:value-of select="@brDecisionValueAllowed"/></p>
  </xsl:template>

  <xsl:template match="brDecision">
    <xsl:choose>
      <xsl:when test="not(descendant::brDecisionPending)">
        <div id="brDecision" style="z-index:1">
          <h3>BR Decision</h3>
          <xsl:apply-templates select="brDecisionText"/>
          <xsl:for-each select="brDecisionValueGroup/brDecisionValue">
            <div>
              <span class="bold">Value Registered: </span><span><xsl:value-of select="@brDecisionValueRegistered"/></span>
              <xsl:apply-templates/>
            </div>
          </xsl:for-each>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <div id="brDecision" style="z-index:1;background-color:red">
          <h3>BR Decision</h3>
          <xsl:apply-templates select="brDecisionText"/>
          <xsl:for-each select="brDecisionValueGroup/brDecisionValue">
            <div>
              <span class="bold">Value Registered: </span><span><xsl:value-of select="@brDecisionValueRegistered"/></span>
              <xsl:apply-templates/>
            </div>
          </xsl:for-each>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>