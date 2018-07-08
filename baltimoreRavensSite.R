baltimoreRavensSite <- "http://kwese.espn.com/nfl/team/_/name/bal/baltimore-ravens"

doc <- ?htmlTreeParse(baltimoreRavensSite)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
scores <- xpathSApply(rootNode, "li[@class='score']", xmlValue)
team <- xpathSApply(rootNode, "li[@class='team-name']", xmlValue)
team
scores
