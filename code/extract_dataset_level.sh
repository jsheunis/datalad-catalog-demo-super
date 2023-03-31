#!/bin/zsh

EXTRACTOR=$1
DATASET_PATH=`pwd`
PIPELINE_PATH="$DATASET_PATH/code/extract_single_pipeline.json"
touch "$DATASET_PATH/outputs/dataset_metadata_$EXTRACTOR.jsonl"
touch "$DATASET_PATH/outputs/dataset_metadata_$EXTRACTOR.err"
datalad -f json meta-conduct "$PIPELINE_PATH" \
    traverser.top_level_dir=$DATASET_PATH \
    traverser.item_type=dataset \
    traverser.traverse_sub_datasets=True \
    extractor1.extractor_type=dataset \
    extractor1.extractor_name=$EXTRACTOR \
    > "$DATASET_PATH/outputs/dataset_metadata_$EXTRACTOR.jsonl" \
    2> "$DATASET_PATH/outputs/dataset_metadata_$EXTRACTOR.err"