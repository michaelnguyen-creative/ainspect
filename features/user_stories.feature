# Ghi nhận kết quả kiểm tra tài sản
Feature: Ghi nhận kiểm tra tài sản
  Là người kiểm tra
  Tôi muốn có thể ghi nhận tình trạng của tài sản
  Để theo dõi và lưu hồ sơ định kỳ

  Scenario: Ghi nhận tình trạng tài sản
    When Tôi mở biểu mẫu kiểm tra tài sản
    And Tôi điền thông tin về tình trạng, ghi chú, hình ảnh
    Then Hệ thống lưu lại kết quả kiểm tra kèm thời gian và người thực hiện

# Đính kèm hình ảnh và video
Feature: Đính kèm hình ảnh/video
  Là người kiểm tra
  Tôi muốn đính kèm ảnh và video về tài sản
  Để minh hoạ tình trạng thực tế

  Scenario: Tải lên hình ảnh và video
    When Tôi chọn chức năng tải ảnh/video
    And Tôi chọn các tập tin từ điện thoại
    Then Hệ thống lưu lại tập tin cùng với bản ghi kiểm tra

# Ghi chú và vẽ chú thích trên ảnh
Feature: Ghi chú trực tiếp trên ảnh
  Là người kiểm tra
  Tôi muốn có thể vẽ và ghi chú trực tiếp trên ảnh
  Để làm nổi bật khu vực hư hỏng hoặc cần lưu ý

  Scenario: Vẽ chú thích trên ảnh
    When Tôi chọn một ảnh đã tải lên
    And Tôi sử dụng công cụ vẽ để đánh dấu vùng lỗi
    Then Hệ thống lưu ảnh kèm chú thích đã vẽ

# Làm việc ngoại tuyến
Feature: Làm việc offline
  Là người kiểm tra làm việc ở vùng không có mạng
  Tôi muốn có thể nhập dữ liệu khi offline
  Để tiếp tục kiểm tra mà không bị gián đoạn

  Scenario: Nhập thông tin khi không có kết nối
    Given Thiết bị không có kết nối internet
    When Tôi mở ứng dụng kiểm tra tài sản
    And Tôi chụp ảnh/video tài sản
    And Tôi điền thông tin kiểm tra và nhận xét
    Then Hệ thống lưu trữ dữ liệu vào bộ nhớ cục bộ (Local Collection hoặc Device Storage)
    And Giao diện hiển thị trạng thái "Đang lưu ngoại tuyến"

  Scenario: Tự động đồng bộ khi có kết nối trở lại
    Given Có dữ liệu ngoại tuyến chưa đồng bộ
    And Thiết bị kết nối lại được internet
    When Tôi mở lại ứng dụng hoặc ứng dụng đang chạy nền
    Then Hệ thống phát hiện kết nối mạng
    And Hệ thống tự động tải dữ liệu từ bộ nhớ cục bộ lên SharePoint / Dataverse
    And Đánh dấu trạng thái đã đồng bộ
    And Hiển thị thông báo "Đã đồng bộ dữ liệu thành công"



# Xem lại lịch sử kiểm tra của tài sản
Feature: Xem lịch sử kiểm tra
  Là người quản lý
  Tôi muốn xem toàn bộ lịch sử kiểm tra của một tài sản
  Để theo dõi bảo trì và đánh giá hiệu suất

  Scenario: Truy cập lịch sử kiểm tra
    When Tôi tìm kiếm một tài sản
    And Tôi chọn mục "Lịch sử kiểm tra"
    Then Tôi thấy danh sách các lần kiểm tra kèm chi tiết

# Tạo nhiệm vụ kiểm tra theo định kỳ
Feature: Lên lịch kiểm tra định kỳ
  Là người quản lý tài sản
  Tôi muốn thiết lập lịch kiểm tra định kỳ
  Để đảm bảo kiểm tra tài sản diễn ra thường xuyên

  Scenario: Tạo lịch kiểm tra định kỳ
    When Tôi chọn một tài sản
    And Tôi thiết lập chu kỳ kiểm tra (ví dụ: mỗi tháng)
    Then Hệ thống tự động tạo nhiệm vụ kiểm tra vào các thời điểm phù hợp
