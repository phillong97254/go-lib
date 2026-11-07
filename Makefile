# go-lib: thư viện dùng chung cho các service của go-admin-wallet (giống go-library ở các dự án trước).
# Service import theo version: go get github.com/phillong97254/go-lib@vX.Y.Z (hoặc make mod trong service).
VERSION ?=

.PHONY: mod test release

mod:
	go get -u ./...
	go mod tidy

test:
	go test -race ./...

# make release VERSION=v0.2.0  -> tag + push để các service go get được version mới
release:
	@test -n "$(VERSION)" || (echo "Thiếu VERSION, ví dụ: make release VERSION=v0.2.0" && exit 1)
	git tag $(VERSION)
	git push origin $(VERSION)
