Makefile project for research
=============================

The goal of this template is to provide a folder structure and Makefile that can
be used to keep research work organized. The main idea is that a Makefile can be
used for all steps from raw data processing to LaTeX compilation. This ensures
that the whole research is reproducible. Additionally, it means that changes in
data or processing methods are automatically propagated all the way to the final
paper, and the folder structure can hopefully help to keep things organized.


Folder structure
================

- *data*: Raw data, not modified in any way. May include download scripts. May
include symlinks for large files/folders. May include git submodules for
datasets, if applicable.
- *script*: Contains all code (Python, MATLAB, ...) that produces results used
in the paper.
  - *proc*: Processing of raw data to produce intermediate results.
  - *tex*: Generating figures or tex files.
  - *utils*: Utility code.
  - *requirements.txt*: For python installation with pip.
- *external-code*: Code that was used for this research, but does not generate
files for the paper. For example: a paparazzi commit, added as submodule.
- *generated*: Folder to keep all generated data. The entire folder can be
removed with a make clean, except perhaps for intermediate results that take
excessive time to generate.
  - *data*: Intermediate results.
  - *tex*: Files to be included in LaTeX documents.
    - *fig/article_format*: Figures generated for article with specified format
    and file type.
    - *input*: Generated LaTeX files, e.g. with results or other important
    numbers.
- *tex*: LaTeX files for the article. Put a root file in this folder. Separating
content and format files might make it easier to target different conferences or
journals.
  - *format/format_name*: Files belonging to a specific format, e.g. IEEE.
  - *content*: Files belonging to this research.
