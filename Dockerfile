FROM golang:1.19.3-alpine3.17 AS build

WORKDIR /src/
COPY go.* *.go /src/
RUN go mod init croc-hunter
RUN go mod tidy
RUN CGO_ENABLED=0 go build -o /bin/croc-hunter

FROM scratch
COPY static/ static/
COPY --from=build /bin/croc-hunter /bin/croc-hunter

CMD ["croc-hunter"]

EXPOSE 8080
