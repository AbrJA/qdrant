# library(qdrant)

Client implementation to interact with [qdrant](https://github.com/qdrant/qdrant) database. **Work in progress**

## Installation

```
remotes::install_github("AbrJA/qdrant@progress")
```

## Usage

### Initialize

```
library(qdrant)

client <- Client$new("http://localhost:6333/")
```

### Service

#### Returns information about the running Qdrant instance

```
client$info()
```

#### Get cluster status info

```
client$cluster()
```

#### Collect telemetry data

```
client$telemetry()
```

#### Collect Prometheus metrics data

```
client$metrics()
```

#### Get lock options (Set lock options not implemented yet!)

```
client$locks()
```

#### Kubernetes healthz endpoint

```
client$healthz()
```

#### Kubernetes livez endpoint

```
client$livez()
```

#### Kubernetes readyz endpoint

```
client$readyz()
```

#### List collections

```
client$collections()
```

#### List collections aliases

```
client$aliases()
```

#### List of storage snapshots

```
client$snapshots()
```

### Collections

#### Create collection

```
client$collection$create(name = "test", 
                         image = vector(240, "Cosine", quantization_config = product("x4", TRUE)),
                         texto = vector(64, "Dot", datatype = "float16"), 
                         quantization_config = binary(TRUE))
```

#### Collection info

```
client$collection$info("test")
```

#### Update collection parameters (not implemented yet)

```
client$collection$update("test", ...)
```

#### List aliases for collection

```
client$collection$aliases("test")
```

#### Delete collection

```
client$collection$delete("test")
```

#### Update aliases of the collections

```
client$collection$alias$update(create_alias("test", "test_one"))
client$collection$alias$update(rename_alias("test_one", "test_two"), delete_alias("test_two"))
```

#### 

```

```

#### 

```

```

#### 

```

```

### Snapshots

#### Create storage snapshot

```
client$snapshot$create()
```

#### Download storage snapshot

```
client$snapshot$download(name, "./snapshot.snapshot")
```

#### Delete storage snapshot

```
client$snapshot$delete(name)
```
