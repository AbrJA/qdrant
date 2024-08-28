# library(qdrant)

Client implementation to interact with [qdrant](https://github.com/qdrant/qdrant) database. **Work in progress**

## Installation

```
remotes::install_github("AbrJA/qdrant@progress")
```

## Usage

### Initialize client

```
library(qdrant)

client <- Client$new("http://localhost:6333/")
```

### Create collection

```
client$collection$create(name = "test", 
                         image = vector(240, "Cosine", quantization_config = product("x4", TRUE)),
                         texto = vector(64, "Dot", datatype = "float16"), 
                         quantization_config = binary(TRUE))
```

### List collections

```
client$collection$list() 
```

### Collection info

```
client$collection$info("test")
```

### Update collection parameters (not implemented yet)

```
client$collection$update("test", ...)
```

### List aliases for collection

```
client$collection$aliases("test")
```

### Delete collection

```
client$collection$delete("test")
```

### Update aliases of the collections

```
client$collection$alias$update(create_alias("test", "test_one"))
client$collection$alias$update(create_alias("test_one", "test_two"), delete_alias("test_two"))
```

### List collections aliases

```
client$alias$list()
```

### 

```

```

### 

```

```

### 

```

```

### 

```

```

### 

```

```

### 

```

```

### 

```

```
