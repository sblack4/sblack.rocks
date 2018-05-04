---
title: "Debugging Gatsby Static Site Builder"
date: 2018-05-03T11:14:21-04:00
draft: true
description: "blog post"
tags: ["blog"]
---

I Built a static site with 
[Gatsby js](https://www.gatsbyjs.org/), [https://unofficialoraclecloudhub.github.io/oracledb-graphql-demo/](https://unofficialoraclecloudhub.github.io/oracledb-graphql-demo/)

```
set DEBUG=* && node.exe --inspect-brk=6359 node_modules\\gatsby-cli\\lib\\index.js develop --verbose
```

