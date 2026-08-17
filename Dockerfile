# --- Этап 1: Сборка приложения ---
# Берем официальный образ Go на базе легковесного Alpine Linux
FROM golang:1.24-alpine AS builder

WORKDIR /app

# Копируем файл зависимостей и скачиваем их (если они появятся)
COPY go.mod ./
RUN go mod download

# Копируем файлы кода
COPY main.go ./

# Компилируем! 
# CGO_ENABLED=0 отключает зависимости от C-библиотек (делает бинарник полностью переносимым)
# GOOS=linux собирает бинарник строго под Linux
RUN CGO_ENABLED=0 GOOS=linux go build -o server main.go


# --- Этап 2: Финальный легковесный образ ---
FROM alpine:3.19

WORKDIR /root/

# Самая магия: копируем готовый скомпилированный файл "server" из этапа "builder"
COPY --from=builder /app/server .

# Указываем, что наше приложение внутри контейнера слушает порт 8080
EXPOSE 8080

# Команда, которая запустится при старте контейнера
CMD ["./server"]

