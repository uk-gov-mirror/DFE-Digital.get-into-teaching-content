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


