<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9">

  <xsl:output method="html" indent="yes" />

  <xsl:template match="/">
    <html>
      <head>
        <title>Sitemap</title>
        <style>
          body { font-family: sans-serif; }
          h1 { color: #333; }
          ul { list-style: none; padding: 0; }
          li { margin: 5px 0; }
        </style>
      </head>
      <body>
        <h1>Sitemap</h1>
        <ul>
          <xsl:for-each select="sitemap:urlset/sitemap:url">
            <li><a href="{sitemap:loc}"><xsl:value-of select="sitemap:loc"/></a></li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
