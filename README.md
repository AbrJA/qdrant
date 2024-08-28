# library(qdrant)

Client implementation to interact with [qdrant](https://github.com/qdrant/qdrant) database. **Work in progress**

## Installation

```
remotes::install_github("AbrJA/qdrant@progress")
```

## Usage

```
library(qdrant)

client <- Client$new("http://localhost:6333/")

client$collection$list() 

client$collection$delete("test")

client$collection$create(name = "test", 
                         image = vector(240, "Cosine", quantization_config = product("x4", TRUE)),
                         texto = vector(64, "Dot", datatype = "float16"), 
                         quantization_config = binary(TRUE))

client$collection$info("test") 

client$collection$exists("test") |>
  httr2::resp_body_json()
```
