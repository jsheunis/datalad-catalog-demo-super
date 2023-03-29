#!/bin/zsh

DATASET_PATH=".."
PIPELINE_PATH="extract_dataset_pipeline.json"

datalad meta-conduct "$PIPELINE_PATH" \
    traverser.top_level_dir=$DATASET_PATH \
    traverser.item_type=dataset \
    traverser.traverse_sub_datasets=True \
    extractor1.extractor_type=dataset \
    extractor1.extractor_name=metalad_core \
    extractor2.extractor_type=dataset \
    extractor2.extractor_name=metalad_studyminimeta \
    extractor3.extractor_type=dataset \
    extractor3.extractor_name=bids_dataset \
    extractor4.extractor_type=dataset \
    extractor4.extractor_name=gin_datacite >> ../outputs/dataset_metadata.jsonl