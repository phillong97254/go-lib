# go-lib

Thư viện Go dùng chung cho các service của go-admin-wallet (vai trò giống `go-library` ở các dự án trước).
Mỗi service import theo version, nên sửa thư viện ở đây rồi release là các service `make mod` để cập nhật.

| Package | Nội dung |
|---|---|
| `authkit` | Claims/Policy (scope, role), verify JWT qua JWKS (cache + xoay key), middleware REST `Authenticate`/`Require`, gRPC `UnaryServerInterceptor`/`ForwardTokenInterceptor`, `WriteJSON`/`WriteError` |
| `database` | `New(Config)` mở Postgres bằng gorm (pool, retry ping), `Migrate(url, fs, dir)` chạy golang-migrate từ SQL nhúng |
| `apperr` | Kiểu lỗi trả từ service lên handler (HTTP status + message + lỗi gốc) và `Write(w, err)` |

## Phát hành version mới

```bash
make test
git commit -am "..." && make release VERSION=v0.2.0   # tag + push
```

Trong service:

```bash
make mod                          # cập nhật mọi thư viện (kể cả go-lib) + tidy + vendor
make mod GO_LIB_VERSION=v0.2.0    # chốt go-lib ở 1 version cụ thể
```

Khi đang sửa go-lib và muốn thử ngay trong service mà chưa release, dùng bản local qua `replace => ../go-lib`
(`make mod-local` trong service), push xong thì `make mod-remote`.
