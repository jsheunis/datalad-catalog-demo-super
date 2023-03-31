#!/bin/zsh

# To recreate the catalog from scratch, run these steps from the command line in order:

# What was done in preparation?
# a. datalad create -c text2git datalad-catalog-demo-super
# b. cd datalad-catalog-demo-super
# c. per subdataset: datalad clone -d . <subdataset-url>

# 0: Setup
git clone https://github.com/jsheunis/datalad-catalog-demo-super.git
cd datalad-catalog-demo-super
chmod -R u+rwx code/*

# 1: run code/extract_dataset_level.sh for all dataset_level extractors
code/extract_dataset_level.sh metalad_core
code/extract_dataset_level.sh metalad_studyiminimeta
code/extract_dataset_level.sh datacite_gin
code/extract_dataset_level.sh bids_dataset

# 2: concatenate dataset-level output files together:
cat outputs/dataset_metadata_*.jsonl > outputs/dataset_metadata.jsonl

# 3: run code/extract_file_level.sh (this takes a few minutes)
code/extract_file_level.sh

# 4: transform into something that datalad-catalog can translate
python code/transform_metadata_structure.py outputs/dataset_metadata.jsonl outputs/dataset_metadata_transformed.jsonl
python code/transform_metadata_structure.py outputs/file_metadata.jsonl outputs/file_metadata_transformed.jsonl

# 5: translate to catalog schema (the file metadata translation takes a few minutes)
datalad -f json catalog translate outputs/dataset_metadata_transformed.jsonl > outputs/dataset_metadata_translated.jsonl
datalad -f json catalog translate outputs/file_metadata_transformed.jsonl > outputs/file_metadata_translated.jsonl

# 6: transform into something that can be added to the catalog
python code/transform_translated_metadata.py outputs/dataset_metadata_translated.jsonl outputs/dataset_metadata_for_catalog.jsonl
python code/transform_translated_metadata.py outputs/file_metadata_translated.jsonl outputs/file_metadata_for_catalog.jsonl

# 7: create catalog
datalad catalog create -c ../datalad-catalog-demo -y inputs/catalog_config.json

# 8: add metadata to catalog
datalad catalog add -c ../datalad-catalog-demo -m outputs/dataset_metadata_for_catalog.jsonl
datalad catalog add -c ../datalad-catalog-demo -m outputs/file_metadata_for_catalog.jsonl

# 9: set catalog homepage (id and version should be the one for which metadata was extracted, might differ from below)
datalad catalog set-super -c ../datalad-catalog-demo -i ff750e89-09bf-48cc-b21c-fe94f071da00 -v 75ce5bfa9380ff05a2046473cfa292f98f754596

# 10: test catalog locally
datalad catalog serve -c ../datalad-catalog-demo

# Afterwards:
# - cd ../datalad-catalog-demo
# - git init
# - create 'datalad-catalog-demo' repo on github
# - git remote add github https://github.com/jsheunis/datalad-catalog-demo.git
# - git add --all
# - git commit -m "turn catalog into a git repo"
# - git push github main
# - enable github pages on github repo
# - et voila!
