# QLS-MiCM Workshop Onboarding Procedure

The following instructions detail how QLS-MiCM workshop leads can submit new workshop materials or make contributions to existing material in our GitHub organization page. The outline approach will be used henceforth to improve the transparency and efficiency of our review process.

## <ins>Submissions for New Workshops

### 1. Creating a new GitHub Repo

Access our [Workshop Repo Template](https://github.com/QLS-MiCM/Workshop_Template) and select the green "Use this template" button at the top-right to create a fresh repo for your workshop materials with the appropriate formatting.

The repo will have the following structure: 
```
├── README.md # workshop overview, requirements and software, links to colab if used/etc. See README_template
├── Exercises
│   ├── data
│   │   └── datafile1
│   │   └── ...
│   ├── scripts
│   │   └── Exercise1.md and .html
│   │   └── script1.sh/py/r
│   └── answers/results
│       └── ...
├── Slides
│   └── workshopslides.pdf #using the pptx template provided
└── Outline
    └── workshopoutline.pdf #using the template provided
```
It is required to provide at least the following content:

-   README.md (this MUST include a brief outline, prerequisites and setup instructions)

-   Slides
    - Be sure to include an extra slide with the feedback QR code provided under `slides/feedback-qr.png`.

-   Scripts

-   Data

> Every workshop will have its own best way of providing scripts and data. Be mindful and organized so participants can easily access everything as the workshop proceeds (scripts, data and results must me reachable). Do not assume they will know where to find the data or where to store the results!!

### 2. Submitting Workshop Materials

After completing your draft materials, **submit an issue to [the workshop template page](https://github.com/QLS-MiCM/Workshop_Template/issues)** with the **workshop name and date** as the title. From here, our academic team will review the materials and share constructive feedback as is required. After the materials are deemed complete, a new repo page will be made within the QLS-MiCM organization from which participants will access the materials.

## <ins>Contributing to existing Workshop Materials

### 1. Fork the Original Workshop Repo

If the workshop you are leading already has pre-existing material, you can access the existing repository and create a fork. From there, you can make the changes you plan to make.

### 2. Submit a Pull Request & create an issue

After completing your changes, you can submit a pull request to the original repository. Please ensure to include a description of the changes made. Our academic team will then review the changes and provide feedback as needed. A GitHub Actions script will automatically respond with a reminder checklist. **Please complete the checklist to facilitate the review process and ensure the workshop can be deployed on time.**

Once all of the feedback is addressed, the pull request will be approved and merged. 

**⚠️All feedback and communications will be handled via a GitHub Issue in the [Workshop_Template repository](https://github.com/QLS-MiCM/Workshop_Template/issues)!⚠️** This will automatically be generated after your pull request is made. 

## Additional Guidelines

### Recommendations

> Each workshop will have its own needs, so these are only broad recommendations. Consider the organization of the code and legibility as a must. If possible avoid expaining on top a sh/py/r scripts without annotations/clear documentation and use notebooks with separated blocks.

#### Data

> Be mindful about the dataset size and computational times in normal computers as not everyone will have the same computational power. Provide the smallest possible dataset to have results: subsets of the genome, small tables/txts files, etc.

#### For command-line UNIX-based workshops

-   Provide the code in a markdown format (and html or pdf) so that participants can copy and paste the commands directly to the terminal
-   If handson exercises are free code, provide a md document (and html or pdf) with the question, code answer(s) and output
-   For more advanced workshops and if required (i.e as part of a pipeline), .sh scripts can be provided

#### For python-based workshops

-   Use of google-colab notebooks is suggested, adding annotations for each part of the code.
-   If handson exercises are free-code or fill in the blank, provide a different set of notebooks with the answers
-   For more advanced workshops and if required, .py scripts can be provided

#### For R-based workshops

-   Use of R-markdown or Quarto notebooks in Rstudio is suggested, adding annotations for each part of the code.
-   If hands-on are free-code or fill in the blank, provide a different set of notebooks with the answers
-   For more advanced workshops and if required (i.e as part of a pipeline), .r scripts can be provided

#### Multi-tool workshops

Some workshops will require the usage of the command-line and R or python for further processing as part of a pipeline (i.e PRS and omics workshops). If possible, run shell commands inside the python/R notebooks; if not, provide a clear pipeline structure, i.e. as a notebook, so participants can follow each step.



