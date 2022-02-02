from mcr.microsoft.com/playwright:v1.18.0-focal

RUN pip install --upgrade pip
RUN pip install --no-cache-dir --upgrade playwright
RUN pip install --no-cache-dir --upgrade pytest
RUN pip install --no-cache-dir --upgrade pytest-playwright
RUN pip install --no-cache-dir --upgrade allure-pytest

RUN python -m playwright install # Install and Update browsers

RUN apt-get update
RUN apt-get install -y unzip
RUN apt-get install -y openjdk-11-jre-headless

WORKDIR /tests # set working directory
ENV ALLURE_VER '2.17.2' # set variable for allure version to download

RUN wget -O allure-commandline.zip https://github.com/allure-framework/allure2/releases/download/${ALLURE_VER}/allure-${ALLURE_VER}.zip
RUN unzip allure-commandline.zip -d /allure
RUN mv /allure/allure-${ALLURE_VER}/* /allure
RUN rm allure-commandline.zip

ENV PATH="/allure/bin:${PATH}"