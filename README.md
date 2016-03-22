# Pandomime Document Generator

## Introduction

__Pandomime__ -- Express yourself without a Word.

You spend your whole day in your IDE -- why leave to generate documentation?  Pandomime allows you to continue maintaining your documents in markdown for easy collaboration and versioning.  At any time (or continuously) generate DOCX format documentation in a clean, uniform, and templatized manner.

Include diagrams, tables and images just as you would in a regular markdown file.  Add page numbers and date stamps just like you would with a typical Word document.  Deliver them to your customer without ever clicking on that _W_.

## Requirements

Pandomime uses `pandoc` for document conversion. You can grab it at [pandoc.org](http://pandoc.org/).

## How It Works

Run `generate_docs.sh` from the any directory.  It will drill down into all subdirectories and do the following:

1. Find any files named `README.md`
2. Extract out the first __First Level Header (#)__ in the document to use as the document title.
3. Generate a DOCX file by combining the markdown from the file and formatting from the reference document specified in the configuration.
4. Save the DOCX file in the document subdirectory specified in configuration using the name extracted above.
5. Continue on to the next `README.md` file.

## Configuration

`generate-docs.sh` uses three constants:

* __pandoc_path__ -- Location of pandoc installed on this machine.
* __reference_path__ -- Location of reference DOCX file.
* __document_dir__ -- Relative subdirectory for document files.

`README.md` is alwways assumed as the name of the markdown input files.
