we need to maintain two versions of data, one locally on device and another on sharepoint, lastedit win (last write win) logic for conflict resolution, the user should be able to use the app without internet connection, on connected data should be synced to sharepoint or sharepoint to the app (if same item) based on their last edit time (last write win)

✅ Sync Model: Dual Source with Conflict Resolution
📁 Data Sources
colLocalInspections: local device collection (offline edits)

SharePoint List: RemoteInspections (central source of truth)

Conflict resolution strategy: Last-write-wins logic