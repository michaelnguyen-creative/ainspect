# Mô hình dữ liệu

| Bảng               | Thời điểm tạo      | Ai tạo               | Dữ liệu chứa                                   |
| ------------------ | ------------------ | -------------------- | ---------------------------------------------- |
| InspectionSchedule | Trước khi kiểm kê  | Planner              | Kế hoạch tổng thể (thời gian, khu vực, mô tả)  |
| Assignments        | Trước khi kiểm kê  | Planner/hệ thống     | Ai → kiểm kê cái gì trong kế hoạch nào         |
| Inspections        | Trong/ sau kiểm kê | Inspector/Technician | Kết quả, trạng thái, hình ảnh, ghi chú kiểm kê |


| Collection         | ...      | ...                                    | ...                                   |
| ------------------ | ------------------ | ----------------------------------------- | ---------------------------------------------- |
| Captured           | Captured = Save(Record)  | Captured data, waiting for sync           | ...  |
| Downloaded         | Downloaded = Download(Remote)  | Synced data downloaded for offline access | ...  |
| Local              | Local = Captured + Downloaded  | Display/read only                         | ...  |
