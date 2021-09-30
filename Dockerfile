FROM python:3
ADD helloworld.py /
EXPOSE 3333
CMD [ "python", "./helloworld.py"]
