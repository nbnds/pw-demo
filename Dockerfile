FROM mcr.microsoft.com/playwright/python:v1.22.0-focal

RUN pip install --upgrade pip
RUN pip install --no-cache-dir --upgrade playwright
RUN pip install --no-cache-dir --upgrade pytest
RUN pip install --no-cache-dir --upgrade pytest-playwright
RUN pip install --no-cache-dir --upgrade allure-pytest

# Install and Update browsers
RUN python -m playwright install 

RUN apt-get update
RUN apt-get install -y unzip
RUN apt-get install -y wget
RUN apt-get install -y openjdk-11-jre-headless

# set working directory
WORKDIR /tests 

# set variable for allure version to download
ENV ALLURE_VER "2.18.1" 

# open port
EXPOSE 8085

# get allure commandline executable and unzip it
RUN wget -O allure-commandline.zip https://github.com/allure-framework/allure2/releases/download/${ALLURE_VER}/allure-${ALLURE_VER}.zip
RUN unzip allure-commandline.zip -d /allure
RUN mv /allure/allure-${ALLURE_VER}/* /allure
RUN rm allure-commandline.zip

ENV PATH="/allure/bin:${PATH}"