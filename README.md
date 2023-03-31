# DataLad Catalog Demo

This DataLad superdataset and associated catalog is a demonstration of the
decentralizeddata portal functionality of
the open source data management tool, DataLad (www.datalad.org). The catalog enables
discoverability of multiple heterogeneous collections of data without relying on a
centrally maintained database, hosting service, or (meta)data standard. The catalog
is generated entirely from harmonized metadata, while the respective datasets are
hosted and maintained independently of each other. This is achieved by DataLad's
capability to represent collections of data as modular, structured, and machine
actionable units (DataLad datasets), followed by adding and extracting metadata
(with datalad-metalad: https://github.com/datalad/datalad-metalad), and finally
harmonizing and rendering metadata in the catalog that you are vieweing (using
datalad-catalog: https://github.com/datalad/datalad-metalad).

The provenance tracking functionality of DataLad allows all steps leading to the
final state of the catalog to encapsulated in the DataLad superdataset. This includes the
linking of sub-datasets (i.e. all the datasets in the catalog), extraction of metadata,
metadata harmionization, and lastly the generation of the catalog and all its entries.
Such provenance records are easily re-executable, meaning that with the required
software tools installed or with a containerized workflow, anyone should be able
to reproduce the same outcome.

Browse the catalog and its datasets to explore its functionality:
[https://jsheunis.github.io/datalad-catalog-demo](https://jsheunis.github.io/datalad-catalog-demo)

## DIY cataloging

Until a better description arrives, follow the steps in [`code/generate_catalog.sh`](code/generate_catalog.sh) to re-create the catalog from scratch.

## TODO:

- update `requirements.txt` to add specific commits for git repos
- capture the execution steps for reproducibility with `datalad run`
- add more subdatasets to showcase additional extractors
    - ris/bib files with https://github.com/mslw/datalad-wackyextra
    - singularity images with `datalad-container` 
    - datalad runrecords (on superdataset) with `datalad-metalad`
- address https://github.com/datalad/datalad-metalad/issues/373 for more convenience when generating catalog dataset names 
