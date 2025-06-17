

##### 🔒 Logic quyền truy cập (PowerApps + Dataverse security filters)

- Kế hoạch (Planner): Toàn quyền với bảng Assets, Assignments, xem Inspections
- Quản lý (Manager): Read tất cả Inspections, write ApprovalStatus
- Kiểm kê (Inspector): Read Assets được phân công (qua InspectionSchedule), create Inspections
- Kỹ thuật (Technician): Read Assets, write TechnicalNotes hoặc Status