# R Package Development for Statisticians

Testing if pull request bot is behaving as expected. 

## Overview

This workshop focuses on transforming statistical analysis/method scripts into robust, testable, and maintainable packages. Participants will learn how to incorporate version control, automated testing, and collaboration tools using GitHub, with a goal of building packages that are easy to scale and maintain.

## Setup

Follow the instructions in the [SetupGuide.pdf](SetupGuide.pdf) file to prepare for the workshop.

## Requirements

- Experience with R
- Experience with Git/GitHub
- A GitHub account

## Learning Objectives

- How to develop a working R package with co-located tests
- How to use GitHub Actions to automate testing and package maintenance workflows

## Software

- RStudio
- Git and GitHub

## Outline

### Part 1: Building a Package (1 hour 5 minutes)

- The Script-to-Package Mindset Shift (5 min): Discuss common issues with unstructured scripts and introduce the idea of creating packages to reduce technical debt. 
- Package Structure (20 min): Hands-on setup to convert an analysis script into a proper package.
- Building Your Safety Net (25 min): Participants will use ```testthat``` to implement their own test code. 
- Code coverage (5 min): Exploring tools to ensure your code is sufficiently covered by tests. 
- Documenting code (10 min): Introduction to ```roxygen2``` for preparing documentation vignettes.

### Part 2: GitHub Actions - Automating your package maintenance (50 minutes)

- CI/CD Demystified (5 min): Introduction to continuous integration and its importance for collaborators.
- GitHub Actions Setup (40 min): Hands-on configuration of automated workflows for testing and validation with GitHub Actions. Incorporating GitHub Actions with Pull Request workflows
- Troubleshooting Common Issues (5 min): Discuss solutions for common problems like failing tests or large datasets.

### Part 3: Beyond the Workshop (5 minutes)

- Your Next Steps Roadmap: Actionable steps for participants to continue improving their workflows.
- Community & Resources: Key resources for R/Python package development, testing, and GitHub community support.

## Acknowledgements

*Material developed by Adrien Osakwe.*

*Workshop materials were created as part of the McGill Initiative in Computational Medicine*
*The session was coordinated and organized by the Biostatistics Section of the Statistical Society of Canada*
