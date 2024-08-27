# library(qdrant)

Client implementation to interact with [qdrant](https://github.com/qdrant/qdrant) database. **Work in progress**

## Installation

```
devtools::install("AbrJA/qdrant")
```

## Usage

```
library(qdrant)

client <- Client$new("http://localhost:6333/")

client$collection$create("test", vector(24, "Euclid"))
client$collection$delete("test")
```
