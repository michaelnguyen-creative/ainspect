

# Feature: Xem thông tin tài sản
Feature: Xem thông tin tài sản
  Mô tả: Người dùng chỉ được phép xem chi tiết tài sản ở chế độ chỉ đọc, không có quyền chỉnh sửa.

  Scenario: Hiển thị thông tin tài sản ở chế độ chỉ đọc
    Given người dùng đã đăng nhập thành công
    When người dùng chọn một tài sản từ danh sách hoặc nhấp vào đường dẫn chi tiết
    Then hệ thống hiển thị thông tin tài sản gồm: Mã định danh, Tên tài sản, Đơn vị, Tình trạng, v.v.
    And các trường được hiển thị ở chế độ chỉ đọc
    And không hiển thị nút "Chỉnh sửa" hoặc bất kỳ hành động cập nhật nào
    And thông tin được lấy từ bảng Asset và Inspection (read-only)

  Acceptance Criteria:
    - Dữ liệu khớp với thông tin master data và bản ghi kiểm kê gần nhất

# Feature: Ghi nhận kết quả kiểm tra tài sản
Feature: Ghi nhận kết quả kiểm tra tài sản
  Mô tả: Người kiểm tra ghi nhận tình trạng tài sản để phục vụ kiểm kê và lịch sử bảo trì.

  Scenario: Ghi nhận tình trạng tài sản
    Given người dùng đã đăng nhập và có quyền kiểm kê
    And biểu mẫu kiểm kê đang mở
    When người dùng chọn một tài sản chưa được kiểm kê hôm nay
    And điền thông tin tình trạng, ghi chú, và đính kèm tối đa 4 ảnh
    Then hệ thống lưu kết quả kiểm tra với thời gian, người thực hiện và cập nhật trạng thái "Đã kiểm kê"
    And nếu tài sản đã được kiểm kê hôm nay bởi người khác
    Then hiển thị thông báo: "Tài sản đã được kiểm kê bởi [tên]"

  Acceptance Criteria:
    - Hệ thống ghi nhận người kiểm, thời gian, và trạng thái "Đã kiểm kê"
    - Tránh trùng lặp kiểm kê trong cùng một ngày

Feature: Đính kèm hình ảnh
  Mô tả: Người kiểm tra có thể đính kèm minh chứng thực tế về tài sản thông qua ảnh hoặc video.

  Scenario: Tải lên hình ảnh kiểm tra
    Given biểu mẫu kiểm kê đang được sử dụng
    When người dùng chọn chức năng đính kèm hình ảnh
    And chụp trực tiếp bằng camera hoặc tải từ thiết bị
    Then hệ thống lưu tệp đính kèm vào bản ghi kiểm kê
    And nếu vượt quá giới hạn, hiển thị thông báo: "Chỉ được tải tối đa 4 ảnh"

  Acceptance Criteria:
    - Tối đa: 4 ảnh (.jpg, .png)
    - Tổng kích thước không vượt quá 10MB
    - Ứng dụng kiểm tra có khả năng truy cập camera nếu thiết bị hỗ trợ

# Feature: Làm việc offline
Feature: Làm việc offline
  Mô tả: Người kiểm tra có thể tiếp tục nhập dữ liệu kiểm kê ngay cả khi mất kết nối mạng.

  Scenario: Nhập thông tin khi offline
    Given thiết bị không có kết nối internet
    When người dùng mở ứng dụng kiểm kê
    And điền thông tin và đính kèm ảnh/video
    Then hệ thống lưu dữ liệu vào bộ nhớ cục bộ
    And hiển thị trạng thái: "Đang lưu ngoại tuyến"

  Scenario: Tự động đồng bộ khi có kết nối
    Given thiết bị có dữ liệu kiểm kê lưu offline
    And kết nối internet được khôi phục
    When ứng dụng được mở lại hoặc đang chạy nền
    Then hệ thống tự động đồng bộ dữ liệu với Dataverse
    And hiển thị thông báo: "Đã đồng bộ dữ liệu thành công"
    And đánh dấu trạng thái bản ghi là "Đã đồng bộ"

  Acceptance Criteria:
    - Dữ liệu offline tự động đồng bộ khi có kết nối
    - Người dùng được thông báo sau khi đồng bộ thành công

# Feature: Xem lịch sử kiểm tra tài sản
Feature: Xem lịch sử kiểm tra tài sản
  Mô tả: Người dùng có thể xem lịch sử các lần kiểm tra của từng tài sản.

  Scenario: Truy cập lịch sử kiểm tra
    Given người dùng đang sử dụng ứng dụng kiểm kê
    When người dùng tìm kiếm và chọn một tài sản cụ thể
    And chọn tab hoặc mục "Lịch sử kiểm tra"
    Then hệ thống hiển thị danh sách các lần kiểm tra (ngày, người kiểm, tình trạng)
    And hiển thị tối đa 20 bản ghi gần nhất
    And nếu có hơn 20 bản ghi, hiển thị nút "Tải thêm"

  Acceptance Criteria:
    - Lịch sử kiểm tra sắp xếp theo thời gian giảm dần
    - Có thể mở rộng để tải thêm các bản ghi cũ hơn
