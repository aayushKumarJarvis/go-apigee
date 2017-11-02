APPNAME=go-apigee
VERSION=0.0.1

build:
	go build -tags netgo -ldflags "-w" -o ${APPNAME} .

build-linux:
	GOOS=linux GOARCH=amd64 go build -tags netgo -ldflags "-w -s -X main.APP_VERSION=${VERSION}" -v -o ${APPNAME}-linux-amd64 .

build-mac:
	GOOS=darwin GOARCH=amd64 go build -tags netgo -ldflags "-w -s -X main.APP_VERSION=${VERSION}" -v -o ${APPNAME}-darwin-amd64 .

build-all: build-mac build-linux

clean:
	rm -f ${APPNAME}
	rm -f ${APPNAME}-linux-amd64
	rm -f ${APPNAME}-darwin-amd64

all: setup
	build
	install

setup:
	go get -u github.com/wadey/gocovmerge
	glide install

test-only:
	go test ${TESTFLAGS} -coverprofile=${name}.txt github.com/aayushKumarJarvis/go-apigee/${name}
