# High-level: Phân quyền truy cập và hành vi theo vai trò hệ thống
Feature: Phân quyền truy cập và hành vi theo vai trò hệ thống
  Hệ thống xác định vai trò của người dùng và cấp quyền tương ứng trên ứng dụng

  Scenario Outline: Người dùng đăng nhập và được cấp quyền theo vai trò
    Given người dùng "<Tên>" đăng nhập vào hệ thống
    When hệ thống xác định người dùng có vai trò "<Vai trò>"
    Then hệ thống cấp quyền "<Quyền hành vi>"

    Examples:
      | Tên          | Vai trò     | Quyền hành vi                                                   |
      | An           | Kế hoạch    | Tạo kế hoạch kiểm kê, xem toàn bộ tài sản & lịch kiểm kê       |
      | Bình         | Quản lý     | Xem tất cả tài sản, kiểm kê, xác nhận & phê duyệt kết quả      |
      | Châu         | Kiểm kê     | Chỉ được kiểm kê tài sản được phân công, xem lịch cá nhân      |
      | Dũng         | Kỹ thuật    | Cập nhật tình trạng tài sản, thêm ghi chú kỹ thuật              |

# Planner
Feature: Quyền của vai trò Kế hoạch
  Người dùng có vai trò "Kế hoạch" có quyền tạo và điều phối kế hoạch kiểm kê

  Scenario: Tạo lịch kiểm kê cho nhóm kiểm kê
    Given người dùng có vai trò "Kế hoạch"
    When người dùng chọn danh sách tài sản và gán cho kiểm kê viên
    Then hệ thống tạo lịch kiểm kê mới trong bảng "InspectionSchedule"
    And mỗi kiểm kê viên chỉ thấy tài sản được phân công

  Scenario: Xem tổng quan tình hình kiểm kê
    Given người dùng có vai trò "Kế hoạch"
    When người dùng truy cập dashboard kiểm kê
    Then hệ thống hiển thị tổng số tài sản, tiến độ, tỷ lệ hoàn thành

# Manager
Feature: Quyền của vai trò Quản lý
  Người dùng "Quản lý" có quyền giám sát, kiểm tra và phê duyệt kết quả

  Scenario: Xem toàn bộ kết quả kiểm kê
    Given người dùng có vai trò "Quản lý"
    When người dùng truy cập danh sách biên bản kiểm kê
    Then hệ thống hiển thị tất cả biên bản từ bảng "Inspections"

  Scenario: Phê duyệt hoặc yêu cầu kiểm tra lại
    Given người dùng có vai trò "Quản lý"
    When người dùng mở biên bản và nhấn "Phê duyệt" hoặc "Yêu cầu kiểm tra lại"
    Then hệ thống cập nhật trường trạng thái tương ứng trong bảng Inspections

# Inspector
Feature: Quyền của vai trò Kiểm kê
  Người dùng "Kiểm kê" chỉ được kiểm kê các tài sản được phân công

  Scenario: Gửi biên bản kiểm kê
    Given người dùng có vai trò "Kiểm kê"
    And người dùng được phân công tài sản A
    When người dùng truy cập form kiểm kê và gửi thông tin
    Then hệ thống lưu thông tin vào bảng Inspections
    And ghi nhận người gửi là tài khoản đang đăng nhập

  Scenario: Không thấy tài sản không được phân công
    Given người dùng có vai trò "Kiểm kê"
    When người dùng truy cập danh sách tài sản
    Then hệ thống chỉ hiển thị các tài sản được gán kiểm kê cho người dùng đó

# Technician
Feature: Quyền của vai trò Kỹ thuật
  Người dùng "Kỹ thuật" có quyền cập nhật thông tin kỹ thuật tài sản

  Scenario: Cập nhật trạng thái kỹ thuật của tài sản
    Given người dùng có vai trò "Kỹ thuật"
    When người dùng truy cập màn hình tài sản
    Then hệ thống cho phép cập nhật các trường kỹ thuật như: Tình trạng, lỗi, đề xuất sửa chữa

  Scenario: Thêm ghi chú kỹ thuật cho biên bản kiểm kê
    Given người dùng có vai trò "Kỹ thuật"
    When người dùng mở biên bản kiểm kê
    Then có thể nhập ghi chú kỹ thuật bổ sung vào mục ghi chú hoặc trường riêng
