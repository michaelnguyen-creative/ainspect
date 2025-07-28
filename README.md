# Documentation

`Local Inspections` & `Local Assets` for Display only
- Limited set of properties => only what is required for the feature


Canonical data source = `Captured` & `Downloaded`
- Full properties

### Data flow

Push: Captured => Local => Remote (SharePoint)
Pull: Remote (SharePoint) => Downloaded => Local

| Collection         | Logic      | Description                                    | ...                                   |
| ------------------ | ------------------ | ----------------------------------------- | ---------------------------------------------- |
| Captured           | Captured = Save(Record)  | Captured data, waiting for sync           | ...  |
| Downloaded         | Downloaded = Download(Remote)  | Synced data downloaded for offline access | ...  |
| Local              | Local = Captured + Downloaded  | Display/read only                         | ...  |

### Data model

[michaelnguyen.creative/ai-nspect](https://dbdocs.io/michaelnguyen.creative/ai-nspect)
Password: VenNRyzhXj6Biz@
