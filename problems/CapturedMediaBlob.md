the idea is ok, but actually mediarecord being passed to automate has filecontent as FileContent":"appres://blobmanager/64e67a11a1be43edb4e000f9f4d59196/1

even when the item sync logic implemented this includebinarydata
```
If(
    Connection.Connected,
    UploadInspectionWithMedia.Run(
        JSON(ThisItem, JSONFormat.IncludeBinaryData),
        JSON(
            Filter(CapturedMedia, InspectionId = ThisItem.InspectionId),
            JSONFormat.IncludeBinaryData
        )
    ),
    Notify(
        "No internet connection. Please connect to sync.",
        NotificationType.Error
    )
)
```


media capture logic uses add picture control with saved record point to picture control .Media property => saved the item to CapturedMedia collection

context
```
[{"AssetId":"47765aff-ae6a-45c7-afbd-4a269e599df3","Caption":"","Captured":"2025-06-28T15:28:34.479Z","CapturedBy":"LuanNVM@gemadept.com.vn","FileContent":"appres://blobmanager/64e67a11a1be43edb4e000f9f4d59196/1","FileName":"IMG_20250628_22nn34.jpg","Id":"e9eed940-acb1-4338-8e93-5af4fbeb4f88","InspectionId":"5a8af8e9-7887-4651-a8af-33ce7e4900ec","IsSavedLocally":false,"LastSynced":null,"SyncErrorMessage":"","SyncRetryCount":0,"SyncStatus":"Pending","Type":"image"}]

```

---

