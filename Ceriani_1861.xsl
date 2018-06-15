<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform
                       https://www.w3.org/2007/schema-for-xslt20.xsd
                       http://www.w3.org/1999/XSL/Format
                       https://svn.apache.org/repos/asf/xmlgraphics/fop/trunk/fop/src/foschema/fop.xsd">
	<xsl:template match="/TEI">
		<xsl:element name="html">
			<xsl:attribute name="lang">en</xsl:attribute>
			<xsl:element name="head">
				<xsl:element name="title">
					<xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/>
				</xsl:element>
				<xsl:element name="link">
					<xsl:attribute name="rel">stylesheet</xsl:attribute>
					<xsl:attribute name="type">text/css</xsl:attribute>
					<xsl:attribute name="href">Ceriani_1861.css</xsl:attribute>
				</xsl:element>
			</xsl:element>
			<xsl:element name="body">
				<xsl:element name="h1">
					<xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/>
				</xsl:element>
				<xsl:element name="p">
					<xsl:text>Based on </xsl:text> 
					<xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/bibl/author"/>
					<xsl:text>, </xsl:text>
					<xsl:element name="i">
						<xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/bibl/title"/>
					</xsl:element>
					<xsl:text>, </xsl:text>
					<xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/bibl/date"/>
				</xsl:element>
				<p>
					<xsl:value-of select="/TEI/teiHeader/encodingDesc/p"/>
					<xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/publicationStmt/publisher"/>
				</p>
				<hr/>
				<xsl:apply-templates select="/TEI/text/body"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="/TEI/text/body">
			<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="/TEI/text/body/pb">
		<xsl:element name="p">
			<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
			<xsl:value-of select="@type"/>
			<xsl:text> p. </xsl:text> 
			<xsl:value-of select="@n"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="/TEI/text/body/head">
		<xsl:element name="h2">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
<!-- 
	is there a good way to make float divs properly nest? 
	probably should rely on cb, as in <cb type="Ceriani" n="2"/>
	<xsl:variable name="header" select="generate-id(.)"/>
	<xsl:for-each select="following-sibling::p[generate-id(preceding-sibling::h1[1]) = $header]">
	<xsl:apply-templates select="following-sibling::*[generate-id(preceding-sibling::pb[1]) = $pageid]"/>
	...
	<xsl:template match="/TEI/text/body/pb">
		<xsl:variable name="pageid" select="generate-id(.)"/>
	</xsl:template>
	<xsl:template match="/TEI/text/body/cb">
		<xsl:if test="@type='Ceriani' and @n='2'">
			<xsl:element name="div">
				<xsl:attribute name="style">float:left;</xsl:attribute>
				<xsl:apply-templates select="following-sibling::*[generate-id(preceding-sibling::pb[1]) = $pageid]"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
-->
	<xsl:template match="//milestone">
		<xsl:if test="@unit='page'">
			<span>
				<xsl:attribute name="class">pagenum</xsl:attribute>
				<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
				<xsl:value-of select="@type"/>
				<xsl:value-of select="@n"/>
			</span>
		</xsl:if>
		<xsl:if test="@unit='ch'">
			<xsl:element name="span">
				<xsl:attribute name="class">ch</xsl:attribute>
				<xsl:value-of select="@n"/>
				<xsl:text>:</xsl:text>
			</xsl:element>
		</xsl:if>
		<xsl:if test="@unit='vs'">
			<xsl:element name="span">
				<xsl:attribute name="class">vs</xsl:attribute>
				<xsl:value-of select="@n"/>
			</xsl:element>
		</xsl:if>
		<xsl:if test="@unit='column' and @n='b'">
			<xsl:element name="span">
				<xsl:attribute name="class">col</xsl:attribute>
				<xsl:text>b</xsl:text>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="/TEI/text/body/p">
		<xsl:choose>
			<xsl:when test="@part='F'">
				<xsl:element name="p">
					<xsl:attribute name="class">noindent</xsl:attribute>
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="p">
					<xsl:attribute name="class">hanging</xsl:attribute>
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="/TEI/text/body/p//lb">
		<xsl:if test="@type='inWord'">-</xsl:if>
		<xsl:element name="br"/>
	</xsl:template>
	<xsl:template match="/TEI/text/body/gap">
		<xsl:element name="p">
			<xsl:attribute name="class">pagegap</xsl:attribute>
			<xsl:text>[</xsl:text>
			<xsl:value-of select="@quantity"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="@unit"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="@reason"/>
			<xsl:text>]</xsl:text>
		</xsl:element>
	</xsl:template>
	<xsl:template match="/TEI/text/body/p//gap">
		<xsl:element name="span">
			<xsl:attribute name="class">chargap</xsl:attribute>
			<xsl:text>[</xsl:text>
			<xsl:value-of select="@quantity"/>
			<xsl:text>?]</xsl:text>
		</xsl:element>
	</xsl:template>
<!-- 
	<xsl:template match="/TEI/text/body/p/choice">
		<xsl:apply-templates/>
	</xsl:template>
-->
	<xsl:template match="/TEI/text/body/p/choice/sic">
		<xsl:element name="span">
			<xsl:attribute name="class">sic</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="/TEI/text/body/p/choice/corr">
		<xsl:element name="span">
			<xsl:attribute name="class">corr</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="/TEI/text/body/p/add">
		<xsl:element name="span">
			<xsl:attribute name="class">add</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="/TEI/text/body/p/surplus">
		<xsl:element name="span">
			<xsl:attribute name="class">surplus</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="/TEI/text/body/p/unclear">
		<xsl:element name="span">
			<xsl:attribute name="class">unclear</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="//space">
		<xsl:element name="span">
			<xsl:attribute name="class">vacat</xsl:attribute>
			<xsl:text> vacat </xsl:text>
		</xsl:element>
	</xsl:template>
 </xsl:stylesheet>