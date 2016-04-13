#! /bin/sh

# Word is for chumps! Generate docx files
# directly from the README.md files you
# already wrote.

pandoc_path=/usr/local/bin/pandoc
reference_path=reference.docx
document_dir=docs

die () {
    echo >&2 "$@"
    exit 1
}

printf "Scanning directory for README.md files... "
markdown_files=$(find . -name README.md -type f -print)
printf "DONE\n"
if [ ${#markdown_files[@]} -eq 0 ]
then
  die "No README.md files found. Shame on you!"
else
  printf "Preparing to process markdown files:\n"
  printf "  Validating destination directory: ${document_dir}/ ... "
  mkdir -p $document_dir
  printf "DONE\n"
  printf "  Validating reference document: ${reference_path} ... "
  if [ -e ${reference_path} ]
  then
    printf "FOUND\n"
  else
    die "File does not exist!"
  fi
  printf "Processing files:\n"
  cwd=$(pwd)
  for markdown_file in ${markdown_files[@]}
  do
    line=$(head -n 1 $markdown_file)
    if [[ $line == \#* ]]
    then
      file_path="${markdown_file%README.md}"
      title="${line/\# /}"
      printf "  ${markdown_file}: ${title}\n"
      printf "    Converting from markdown to docx...\n"
      #printf "${pandoc_path} -i \"${markdown_file}\" -o \"${document_dir}/${title}.docx\" -f markdown -t docx --reference-docx=${reference_docx} --smart\n"
      cd $file_path
      ${pandoc_path} -i README.md -o "${cwd}/${document_dir}/${title}.docx" -f markdown -t docx --reference-docx="${reference_path}" --smart
      cd $cwd
      printf "    Generated ${document_dir}/${title}.docx.\n"
    else
      printf "  SKIPPING ${markdown_file}: No title found\n"
    fi
  done
  printf "Complete.\n"
fi
