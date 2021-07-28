# Krustlet Docs

> :book: This repo contains the [Krustlet Docs](https://github.com/krustlet/krustlet/tree/main/docs)  
> :ship: Also the website config to generate [docs.krustlet.dev](https://docs.krustlet.dev/)  
> :link: Looking for the main Krustlet.dev website? Visit [krustlet.dev](https://github.com/krustlet/krustlet.dev)  


## Editing Content

docs.krustlet.dev is a static site. The documentation content needs to be located at `docs/content/docs/`.

To ensure the docs content renders correctly in the theme, each page will need to have [front matter](https://gohugo.io/content-management/front-matter/) metadata. Example front matter:

```
---
title: "Docs Home"
linkTitle: "Home"
description: "Krustlet Docs"
weight: 1
type: docs
---
```

## Front Matter Notes:

* inclusion of `type: docs` is important for the theme to properly index the site contents
* the `linkTitle` attribute allows you to simplify the name as it appears in the left-side nav bar - ideally it should be short and clear - whereas the title can handle longform names for pages/documents.


# Site Development

## Notes

* built with the [Hugo](https://gohugo.io/) static site generator
* custom theme uses [Docsy](https://www.docsy.dev/) as a base, with [Bootstrap](https://getbootstrap.com/) as the underlying css framework and some Krustlet custom sass additions
* deployed to [Netlify](https://app.netlify.com/sites/krustlet-docs/deploys) via merges to main. (@flynnduism can grant additional access to account)
* metrics tracked via Google Analytics (as part of Krustlet.dev)

## Install dependencies:

* Hugo [installation guide](https://gohugo.io/getting-started/installing/)  
* NPM packages are installed by running `yarn`. [Install Yarn](https://yarnpkg.com/getting-started/install) if you need to.  

## Run the site:

```
// install npm packages
yarn

// rebuild the site (to compile latest css/js)
hugo

// or serve the site for local dev
hugo serve
```

## Deploying the site:

The site auto deploys the main branch via [Netlify](https://app.netlify.com/sites/krustlet-docs). Once pull requests are merged the changes will appear at docs.krustlet.dev after a couple of minutes. Check the [logs](https://app.netlify.com/sites/krustlet-docs/deploys) for details.

[![Netlify Status](https://api.netlify.com/api/v1/badges/51ec134b-5691-434b-b6d7-f749c07f914d/deploy-status)](https://app.netlify.com/sites/krustlet-docs/deploys)

`hugo serve` will run the site locally at [localhost:1313](http://localhost:1313/)
