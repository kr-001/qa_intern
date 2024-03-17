# Flask JSON Handling and Testing

This repository contains a Flask server for handling POST requests with JSON payloads, along with automation tests and introductory load testing scripts.

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)
- [Load Testing](#load-testing)

## Introduction

This Flask application provides two endpoints:

1. `/submit-json`: Endpoint for handling POST requests with JSON payloads.
2. `/submit-data`: Endpoint for handling form data submissions.

The application validates incoming data, generates a unique ID, and returns a response containing the processed data along with metadata.

## Installation

To run this application locally, follow these steps:

1. Clone this repository to your local machine:
    ```bash
    git clone https://github.com/kr-001/qa_intern.git
    cd qa_intern
    ```

2. Install dependencies:

    ```bash
    pip install -r requirements.txt
    ```

## Running the App

Start the development server:

```bash
python app.py or flask run
```

## Testing the App
1. Install Robot Framework
   ```bash
   pip install robotframework
   ```
2. Run Robot test file :
   ```bash
   test_json_requests.robot
   ```
## Load  Testing with Locust
1. Run the Locust file
   ```bash
   locust -f locust.py
   ```
2. This will open your browser and go to `http://localhost:8089` to access the Locust web interface. 
3. Set the desired number of users and spawn rate, then start the test to simulate load on the server.
