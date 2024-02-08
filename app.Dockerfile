FROM alpine:3.15 AS build
RUN apk add --no-cache python2
RUN python -m ensurepip

WORKDIR /app
COPY ./foodtrucks/project/flask-app/requirements.txt ./
RUN pip install -r requirements.txt

FROM alpine:3.15
RUN apk add --no-cache python2
WORKDIR /app
COPY --from=build /usr/lib/python2.7 /usr/lib/python2.7
COPY /foodtrucks/project/flask-app/app.py ./

EXPOSE 5000
ENTRYPOINT [ "python", "app.py" ]