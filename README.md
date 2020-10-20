 #  DFE-Digital Get into Teaching website content

![Build and Deploy](https://github.com/DFE-Digital/get-into-teaching-content/workflows/Build%20and%20Deploy/badge.svg)
![Release to test](https://github.com/DFE-Digital/get-into-teaching-content/workflows/Release%20to%20test/badge.svg)

## Prerequisites
- None

## Whats included in this repository

- Markdown content for the Get into Teaching website
- Associated static assets for that content
- Dockerbuild file
- GitHub Actions based CI
- Deployment through to GovUK PAAS utilising Docker

## Application for this website

The application this content is combined with is held in a separate [Application repository](https://github.com/DFE-Digital/get-into-teaching-app)

When the application in that repository is deployed, it builds a new application 
Docker Image, then triggers a build of this Repo which creates its own Docker 
Image layered on top of the application one.

The combined image is then deployed through to GovUK PAAS via Github Actions.

## Frontmatter

How markdown content is rendered is controlled from the Frontmatter - that YAML
definition at the start of the markdown file. 

There is also a global frontmatter config which is merged in with the per-page 
front matter. This can be used for things like global acronym definitions.

This can be found at `config/frontmatter.yml`

### Acronyms

Acronyms are replaced with an HTML tag allowing the user to hover to view the
acronym definition.

```YAML
---
accronyms:
  DFE: Department for Education
  VAT: Value added tag
---
```

## DevOps

### Accessibility Scanning
On Deployment to the Development environment (master branch) the [Accessibility Scanner](https://github.com/DFE-Digital/accessibility-scanner) will be run, carrying out a11y accessibility checks on a list of URLS. The list can be amended using the file .accessibility.file

### OWASP Scanning
On deployment to the development environment the web url is scanned using [ZAP Scanner](https://github.com/marketplace/actions/owasp-zap-full-scan). The scanner is controlled by a rules file stored in .zap/rules.tsv.   Ideally there should be no rules supressed but intially it has been agreed to resolve them at a slower pace. The scanner will produce an artifact in the output of the running action (zap_scan.zip), by downloading this file and reading the contents it is possible to see what vulnerabilities have beeen detected.
The following rules have been added:
- 10038	IGNORE	(Content Security Policy (CSP) Header Not Set)
- 10063	IGNORE	(Feature Policy Header Not Set)
- 40025	IGNORE	(Proxy Disclosure)
