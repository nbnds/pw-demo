from mcr.microsoft.com/playwright:v1.17.2-focal

RUN pip install --upgrade pip
RUN pip install --no-cache-dir --upgrade playwright
RUN pip install --no-cache-dir --upgrade pytest-playwright
RUN pip install --no-cache-dir --upgrade allure-pytest

RUN python -m playwright install # Install and Update browsers



COPY ./sample-tests /sample-tests # Copy host folder woth test sources into container
WORKDIR /sample-tests # set working directory

RUN apt-get update
RUN apt-get install -y unzip
RUN apt-get install -y openjdk-11-jre-headless

ENV ALLURE_VER '2.17.2' # set variable for allure version to download

RUN wget -O allure-commandline.zip https://github.com/allure-framework/allure2/releases/download/${ALLURE_VER}/allure-${ALLURE_VER}.zip
RUN unzip allure-commandline.zip -d /allure
RUN mv /allure/allure-${ALLURE_VER}/* /allure
RUN rm allure-commandline.zip

ENV PATH="/allure/bin:${PATH}"

RUN mkdir -p /allure-results # folder with json results
RUN mkdir -p /allure-report # folder with generated interactive report

EXPOSE 8085

# ! Tests should not be executed as part of building the image
# ! Tests should be executed via compose file.
# Remove this tempoarary workaround when done
CMD ["pytest", -"-alluredir=allure-result-folder"]
CMD ["allure", "generate", "allure-results", "--clean", "-o", "allure-report"]
CMD ["allure", "serve", "allure-report", "-p", "8085"]

# https://www.codegrepper.com/code-examples/shell/allure+report+history
# mkdir build/allure-results/history
# cp allure-report/history/* build/allure-results/history

# allure generate --clean build/allure-results
# allure open

