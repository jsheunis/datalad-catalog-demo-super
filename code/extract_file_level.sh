#!/bin/zsh

DATASET_PATH=".."
PIPELINE_PATH="extract_file_pipeline.json"

datalad meta-conduct "$PIPELINE_PATH" \
    traverser.top_level_dir=$DATASET_PATH \
    traverser.item_type=file \
    traverser.traverse_sub_datasets=True \
    extractor1.extractor_type=file \
    extractor1.extractor_name=metalad_core >> ../outputs/file_metadata.jsonl