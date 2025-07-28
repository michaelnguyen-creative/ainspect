# Sytem Documentation

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

[Source](https://dbdiagram.io/d/ai-nspect-684eb10c3cc77757c8ef42c3)

### Deployment

Power Platform
| Env                | Type      | Description                                    | ...                                   |
| ------------------ | ------------------ | ----------------------------------------- | ---------------------------------------------- |
| GMD.CDS.PROD           | Dev/UAT  | Môi trường dev & test ban đầu          | ...  |
| DX.PROD01         | Production  | Môi trường production hiện tại | ...  |
