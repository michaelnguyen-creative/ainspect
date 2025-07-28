# Sytem Documentation

### Data flow

Push: Captured => Local => Remote (SharePoint)

Pull: Remote (SharePoint) => Downloaded => Local

| Collection         | Logic                          | Description                               | ...                                   |
| ------------------ | ------------------------------ | ----------------------------------------- | ---------------------------------------------- |
| Captured           | Captured = Save(Record)        | Captured data, waiting for sync           | ...  |
| Downloaded         | Downloaded = Download(Remote)  | Synced data downloaded for offline access | ...  |
| Local              | Local = Captured + Downloaded  | Display/read only                         | ...  |

### Data model

[michaelnguyen.creative/ai-nspect](https://dbdocs.io/michaelnguyen.creative/ai-nspect)

Password: VenNRyzhXj6Biz@

[Source](https://dbdiagram.io/d/ai-nspect-684eb10c3cc77757c8ef42c3)

### Deployment

Power Platform
| Environment   | Type        | App name              | Description                                                    |
| ------------- | ----------- | --------------------- | -------------------------------------------------------------- |
| GMD.CDS.PROD  | Dev/UAT     | Kiểm kê tài sản UAT   | Môi trường dev & test ban đầu                                  |
| DX.PROD01     | Production  | Kiểm kê tài sản       | Môi trường production hiện tại sau khi đã migrate data source  |

### Data sources

| Location    | Url                                                                                                         | App name             | 
| ----------  | ----------------------------------------------------------------------------------------------------------- | -------------------- |
| SharePoint  | [GMDQLTS-QLTSdata/Inspections](https://gmdcorp.sharepoint.com/sites/GMDQLTS-QLTSdata/Lists/Inspections)     | Kiểm kê tài sản      |
| SharePoint  | [GMDQLTS-QLTSdata/Assets](https://gmdcorp.sharepoint.com/sites/GMDQLTS-QLTSdata/Lists/Assets)               | Kiểm kê tài sản      |
| SharePoint  | [gmd.dx/Inspections](https://gmdcorp.sharepoint.com/sites/gmd.dx/Lists/Inspections)     | Kiểm kê tài sản UAT  |
| SharePoint  | [gmd.dx/Assets](https://gmdcorp.sharepoint.com/sites/gmd.dx/Lists/Assets)               | Kiểm kê tài sản UAT  |
