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
				<title>Translation of <xsl:value-of select="/codex/title"/></title>
			</head>
			<body style="margin:20px;">
				<h1><xsl:value-of select="/codex/title"/></h1>
				<xsl:if test="/codex/book[2]">
					<ol>
					<xsl:for-each select="codex/book">
						<li>
							<a><xsl:attribute name="href">#<xsl:value-of select="title"/></xsl:attribute>
							<xsl:value-of select="title"/></a>
						</li>					
					</xsl:for-each>
					</ol>
				</xsl:if>
				
				<xsl:for-each select="/codex/book">
					<h3><xsl:attribute name="id"><xsl:value-of select="title"/></xsl:attribute>
					Translation of <xsl:value-of select="recension"/>&#160;<xsl:value-of select="title"/> 
					into <xsl:value-of select="rendering"/> by <xsl:value-of select="translator"/> 
					(<xsl:value-of select="publicationyear"/>)</h3>
					<p>
						<xsl:value-of select="title"/> chapters in this document:
						<xsl:for-each select="chapter[@number]">
							<a>
								<xsl:attribute name="href">#ch<xsl:value-of
									select="@number" /></xsl:attribute>
								<xsl:value-of select="@number" />
							</a>&#160;
						</xsl:for-each>
					</p>
					<p>
						Fifth-century/modern page numbers:
						<xsl:for-each select="chapter/paragraph/verse/pagestart">
							<a>
								<xsl:attribute name="href">#5c<xsl:value-of select="@p5c"/></xsl:attribute>
								<xsl:value-of select="@p5c"/>/<xsl:value-of select="@p19c"/>
							</a>&#160;
						</xsl:for-each>
					</p>
					<hr/>
					<xsl:apply-templates select="chapter" />
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="/codex/book/chapter">
		<div> 
			<xsl:attribute name="id">ch<xsl:value-of select="@number"/></xsl:attribute>
			<xsl:attribute name="style">max-width:6.5in;</xsl:attribute>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="/codex/book/chapter/paragraph">
		<p>
		<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="/codex/book/chapter/paragraph/verse">
		<xsl:if test="@number &gt; 0">
		<span>
			<xsl:attribute name="style">color:darkgreen;font-size:80%;vertical-align:text-top;</xsl:attribute>
			<xsl:value-of select="../../@number"/>:<xsl:value-of select="@number"/>
		</span>&#160;</xsl:if>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="/codex/book/chapter/paragraph/verse/line">
		<br/><xsl:value-of select="."/>
		<xsl:apply-templates select="pagestart" />
	</xsl:template>
	<xsl:template match="//pagestart">
		<span>
			<xsl:attribute name="style">color:darkred;font-size:80%;vertical-align:text-top;</xsl:attribute>
			<xsl:attribute name="id">5c<xsl:value-of select="@p5c"/></xsl:attribute>5c<xsl:value-of select="@p5c"/>&#160;</span>
	</xsl:template>
	<xsl:template match="i">
		<i><xsl:value-of select="."/></i>
	</xsl:template>
 </xsl:stylesheet>