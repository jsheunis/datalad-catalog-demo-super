#!/bin/zsh

DATASET_PATH=`pwd`
PIPELINE_PATH="$DATASET_PATH/code/extract_single_pipeline.json"
touch "$DATASET_PATH/outputs/file_metadata.jsonl"
datalad -f json meta-conduct "$PIPELINE_PATH" \
    traverser.top_level_dir=$DATASET_PATH \
    traverser.item_type=file \
    traverser.traverse_sub_datasets=True \
    extractor1.extractor_type=file \
    extractor1.extractor_name=metalad_core \
    > "$DATASET_PATH/outputs/file_metadata.jsonl" \
    2> "$DATASET_PATH/outputs/file_metadata.err"