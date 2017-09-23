<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform
                       https://www.w3.org/2007/schema-for-xslt20.xsd
                       http://www.w3.org/1999/XSL/Format
                       https://svn.apache.org/repos/asf/xmlgraphics/fop/trunk/fop/src/foschema/fop.xsd">
	<xsl:template match="/">
		<html>
			<head>
				<title><xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/></title>
			</head>
			<body style="margin:20px;">
				<p>
					<xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/listBibl/biblStruct/monogr/author"/>, 
					<i><xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/listBibl/biblStruct/monogr/title"/></i>
				</p>
				<p>
					<xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/listBibl/biblStruct/monogr/editor/persName/name"/>, 
					<i><xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/></i>, 
					<xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/listBibl/biblStruct/monogr/imprint/date"/>
				</p>
				<p>
					<a>
						<xsl:attribute name="href"><xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/listBibl/biblStruct/ref/@target"/></xsl:attribute>
						<xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/listBibl/biblStruct/ref"/>
					</a>
				</p>
				<p>Codex Ambrosianus modern page numbers in this document:
					<xsl:for-each select="//pb[@type='19c']">
						<a>
							<xsl:attribute name="href">#19c<xsl:value-of select="@n"/></xsl:attribute>
							<xsl:value-of select="@n"/>
						</a>&#160;
					</xsl:for-each>
				</p>
				<hr/>
				<xsl:apply-templates select="TEI/text/body/div"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="ab">
		<p><xsl:value-of select="title"/></p>
	</xsl:template>
	<xsl:template match="/Tei/text/body/div/div/p">
		<p>
			<xsl:apply-templates />
		</p>
	</xsl:template>
	<xsl:template match="pb[@type='knoell']">
		<p style="border-top: 1px solid green;color:green;font-size:80%;vertical-align:text-top;">Knöll page <xsl:value-of select="@n"/></p>
	</xsl:template>
	<xsl:template match="pb[@type='19c']">
		<span>
			<xsl:attribute name="style">color:darkred;font-size:80%;vertical-align:text-top;</xsl:attribute>
			<xsl:attribute name="id">19c<xsl:value-of select="@n"/></xsl:attribute>
			msA<xsl:value-of select="@n"/>&#160;</span>
	</xsl:template>
	<xsl:template match="/TEI/text/body/div/div/p/lb">			<!-- could take this out for dense flow -->
		<br/>
	</xsl:template>
	<xsl:template match="/TEI/text/body/div/div/p/choice">
		<span style="border-bottom: 1px dashed pink;"><xsl:value-of select="corr"/></span>
	</xsl:template>
	<xsl:template match="/TEI/text/body/div/div/p/sic">
		<span style="border-bottom: 1px dotted red;"><xsl:value-of select="."/></span>
	</xsl:template>


 </xsl:stylesheet>
 