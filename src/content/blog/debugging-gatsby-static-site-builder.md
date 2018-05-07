---
title: "Debugging Gatsby Static Site Builder"
date: 2018-05-03T11:14:21-04:00
draft: false
description: "Gatsby, the not-so-blazing-fast-but-beautiful static site renderer with React & GraphQL"
tags: ["gh-pages", "gatsby", "graphql", "react", "javascript"]
---


# Gatsby JS 

I love code & I love good documentation so I LOVE a great static-site builder like [Hugo](https://gohugo.io/), 
or the super-lightweight static-site scheme [oracle learning-library uses](https://github.com/oracle/learning-library/tree/master/workshops). 
There's been a lot of buzz about [Gatsby](https://www.gatsbyjs.org/) so I decided to give it a go!

</br></br>
<a href="https://unofficialoraclecloudhub.github.io/oracledb-graphql-demo/" target="_blank">
  ![](/img/uncloudhub-graphql-oracledb.png)
</a>

I Built a static site with 
[Gatsby js](https://www.gatsbyjs.org/), pictured above & available at [https://unofficialoraclecloudhub.github.io/oracledb-graphql-demo/](https://unofficialoraclecloudhub.github.io/oracledb-graphql-demo/)


</br></br>
## Building the Site
All of the code is available at https://github.com/unofficialoraclecloudhub/oracledb-graphql-demo/tree/master/docs. 
I used [ericwindmill/gatsby-starter-docs](https://github.com/ericwindmill/gatsby-starter-docs) as the starting point. 
The site (especially the code highlighted with [prismjs](http://prismjs.com/)) is beautiful! 

I thought Gatsby felt flimsy. If you make a small change (like a filename) you need to clear your cache and then wait **MINUTES** for the code to transpile. With hugo I hardly every wait a full second. 

</br></br>
## Debugging Gatsby 

This was not easy. I easily lost a few days playing with this and if there was one this I could tell my past self, it would be this; 
```
set DEBUG=* && node.exe --inspect-brk=6359 node_modules\\gatsby-cli\\lib\\index.js develop --verbose
```

With this one line your log output goes from *nil* to *muy-verbose* 😉 . Note that this command is on windows & assumes you are using 
the `gatsby-cli` installed in your `node_modules` and not globally. 


</br></br>
## tl;dr
Gatsby is great if you want to work extensively with `graphql` and `react` AND you're willing to wait ages every time you make 
a change to your site. 

I won't be using gatsby again, next static-site generator on my list to test is Facebook's [docusaurus.io](https://docusaurus.io/)




</br></br>