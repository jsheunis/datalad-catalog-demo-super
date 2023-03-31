#!/bin/zsh

# Run these steps from the command line in order:

# 0: prep
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

